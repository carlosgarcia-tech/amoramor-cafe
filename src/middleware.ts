/**
 * Middleware de Astro: refresca la sesión de Supabase y guarda los tokens en
 * cookies httpOnly (Set-Cookie del servidor). El JS del navegador ya no puede
 * leer el token desde localStorage, y /admin exige sesión real de server.
 */
import { createServerClient, parseCookieHeader } from '@supabase/ssr';
import { defineMiddleware } from 'astro:middleware';

export const onRequest = defineMiddleware(async (context, next) => {
  // Solo páginas de navegación; prerender (público estático) no necesita sesión.
  if (context.isPrerendered) return next();

  try {
    const supabase = createServerClient(
      // Runtime primero (.env del contenedor/servidor); build como respaldo.
      process.env.PUBLIC_SUPABASE_URL ?? import.meta.env.PUBLIC_SUPABASE_URL,
      process.env.PUBLIC_SUPABASE_PUBLISHABLE_KEY ?? import.meta.env.PUBLIC_SUPABASE_PUBLISHABLE_KEY,
      {
        cookieOptions: { secure: true, sameSite: 'lax' },
        cookies: {
          getAll() {
            // Astro.cookies no tiene getAll: parseamos la cabecera cruda.
            return parseCookieHeader(context.request.headers.get('Cookie') ?? '');
          },
          setAll(cookiesToSet) {
            for (const { name, value, options } of cookiesToSet) {
              context.cookies.set(name, value, { ...options, httpOnly: true, path: '/' });
            }
          },
        },
      },
    );

    // Refresh del access token si venció → Set-Cookie httpOnly del servidor.
    // La puerta del panel la hace RLS con el rol; el /admin muestra login aquí.
    await supabase.auth.getUser();
  } catch {
    // Sin red de Supabase o cookie corrupta: la parte pública sigue accesible.
  }

  return next();
});
