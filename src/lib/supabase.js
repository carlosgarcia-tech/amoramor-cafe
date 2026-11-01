import { createBrowserClient } from '@supabase/ssr';
import { createClient } from '@supabase/supabase-js';

const supabaseUrl = import.meta.env.PUBLIC_SUPABASE_URL;
const supabasePublishableKey = import.meta.env.PUBLIC_SUPABASE_PUBLISHABLE_KEY;

if (!supabaseUrl || !supabasePublishableKey) {
  throw new Error(
    'Faltan las variables de entorno PUBLIC_SUPABASE_URL y/o PUBLIC_SUPABASE_PUBLISHABLE_KEY. ' +
      'Defínelas en el archivo .env de la raíz del proyecto.',
  );
}

// Cliente de navegador: sesión en cookies (no localStorage). El refresh lo
// hace el middleware de Astro con cookies httpOnly; este cliente comparte
// esas cookies.
export const supabase = createBrowserClient(supabaseUrl, supabasePublishableKey, {
  cookieOptions: { secure: true, sameSite: 'lax' },
  // prettier-ignore
  isSingleton: true,
});

// Cliente plano accesible por helpers que no necesitan sesión (público).
export { createClient };
