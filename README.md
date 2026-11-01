# 🌹 Amor Amor Café

> _"La esencia del café, con una gota de nuestro"_ — Bubble waffles, crepas japonesas, waffles coreanos y frappés, servidos con poemas.

Web del proyecto **Amor Amor Café**: landing pública con vitrina 2.5D y datos vivos desde Supabase, más un panel de administración para el staff. Construida con **Astro 7** (SSR) + **Tailwind CSS 4** + **Supabase**.

---

## Stack

| Tecnología | Rol |
| :--- | :--- |
| [Astro 7](https://docs.astro.build) | Framework web · SSR on-demand (`output: 'server'`) |
| [Tailwind CSS 4](https://tailwindcss.com) | Estilos vía `@tailwindcss/vite`, tokens de marca en `@theme` |
| [Supabase](https://supabase.com) | PostgreSQL con RLS, Auth (staff), Storage (imágenes) |
| [@supabase/ssr](https://www.npmjs.com/package/@supabase/ssr) | Sesión en cookies httpOnly (nada de localStorage) |
| [Vercel](https://vercel.com) | Despliegue (adaptador `@astrojs/vercel`) |

**Node requerido:** `>= 22.23.4` (ver `engines` en `package.json`).

---

## Estructura del proyecto

```text
/
├── public/
│   ├── favicon.svg
│   └── fonts/KaushanScript-Regular.woff2   # Fuente de marca (self-hosted, licencia OFL)
├── src/
│   ├── components/          # Secciones del landing y modales
│   │   ├── Navbar.astro     # Barra fija con blur
│   │   ├── Hero.astro       # Portada
│   │   ├── ParallaxSection.astro     # Vitrina 2.5D del Bubble Waffle (scroll)
│   │   ├── TransicionPoema.astro     # Transición poética entre secciones
│   │   ├── MenuSection.astro         # Carta: categorías, productos y modal de detalle
│   │   ├── PromosSection.astro       # Novedades y cupones con código copiable
│   │   ├── BranchesSection.astro     # Sucursales con mapa embebido y "cómo llegar"
│   │   ├── Footer.astro
│   │   └── AdminModal.astro          # Modal FAB alternativo de gestión en el landing
│   ├── layouts/Layout.astro # HTML global: fuentes, metadata, import de estilos
│   ├── lib/
│   │   ├── supabase.js      # Cliente navegador (sesión compartida por cookies)
│   │   └── esc.js           # Helper anti-XSS para interpolar texto de la DB en HTML
│   ├── middleware.ts        # Refresh de sesión Supabase + cookies httpOnly en el server
│   ├── pages/
│   │   ├── index.astro      # Landing (estática, prerender)
│   │   └── admin.astro      # Panel de administración (SSR, exige sesión)
│   ├── styles/global.css    # Paleta, tipografías y utilidades de accesibilidad
│   └── assets/              # Imágenes locales (bubble waffle, logos)
├── supabase/
│   ├── schema.sql           # Tablas + políticas RLS base
│   └── fix-rls-security.sql # Endurece CRUD: escritura solo para staff/admin
└── astro.config.mjs
```

---

## Requisitos previos

1. **Node 22+** (el build usa SSR con el adaptador de Vercel).
2. Un proyecto de **Supabase** con credenciales listas (ver siguiente sección).

## Configuración local

```sh
# 1. Instalar dependencias
npm install

# 2. Crear .env en la raíz con tus credenciales de Supabase
echo "PUBLIC_SUPABASE_URL=https://TU-PROYECTO.supabase.co"        > .env
echo "PUBLIC_SUPABASE_PUBLISHABLE_KEY=TU_CLAVE_PUBLICA_ANON"     >> ./.env

# 3. Levantar el dev server
npm run dev        # http://localhost:4321
```

> La app lanza un error claro en consola si falta alguna de las dos variables públicas. Solo se usan claves **publishable/anon**: nunca pongas la `service_role` en el navegador.

#### Variables de entorno

| Variable | Obligatoria | Dónde |
| :--- | :--- | :--- |
| `PUBLIC_SUPABASE_URL` | ✅ | `.env` local y *Environment Variables* de Vercel |
| `PUBLIC_SUPABASE_PUBLISHABLE_KEY` | ✅ | Idem (clave `anon`/publishable del proyecto Supabase) |

## Base de datos (Supabase)

Ejecutar SQL en el **SQL Editor** del proyecto, en orden:

1. `supabase/schema.sql` — crea las tablas y RLS base.
2. `supabase/fix-rls-security.sql` — crea `profiles` con rol (`admin`/`staff`/`customer`), el helper `mi_rol()` y restringe **toda escritura del catálogo a staff/admin** (además habilita UPDATE/DELETE que el panel necesita).

#### Modelo de datos

| Tabla | Contenido | Escritura |
| :--- | :--- | :--- |
| `categories` | Categorías del menú (`slug`, `display_order`…) | Lectura pública · CRUD solo staff |
| `products` | Productos (nombre, precio, `ingredients`, `image_url`, disponibilidad) | Idem |
| `branches` | Sucursales (dirección, horario, teléfono, estatus, WiFi, pet-friendly, Maps) | Idem |
| `promos` | Novedades/cupones (badge de descuento, código, vigencia) | Idem |
| `comentarios` | Comentarios de visitantes | Lectura pública · INSERT abierto |
| `avisos` | Avisos del staff | Lectura pública · INSERT solo staff |
| `profiles` | Perfil por usuario con `role` (permite el helper `mi_rol()`) | Auto-creado en signup |

**Storage:** bucket `product-images` (público) para las fotos del menú — el panel sube ahí una imagen por producto y guarda la URL resultante en `products.image_url`, con campo de URL manual como respaldo.

#### Seguridad (resumen)

- **RLS en todas las tablas**: lectura pública vía `FOR SELECT USING (true)`; escritura de catálogo limitada a `admin`/`staff` según `profiles.role`.
- **Sesión en cookies httpOnly** (`src/middleware.ts`): el middleware de Astro refresca el access token vencido con `@supabase/ssr`; el JS del navegador no puede leer los tokens y `/admin` valida la sesión de lado del servidor. La autorización real de los datos la hace RLS.
- **Anti-XSS en render**: todo texto viniendo de la DB pasa por `esc()` (`src/lib/esc.js`) antes de interpolarse en plantillas HTML del navegador.
- `/admin` nunca muestra registro: solo login de staff.

---

## Landing pública (`/`)

Las secciones, en orden de scroll:

1. **Hero** — portada con marca y eslóganes.
2. **Vitrina 2.5D** (`ParallaxSection`) — el Bubble Waffle flotando en un escenario oscuro: escala, inclinación y sombra animadas por scroll, con `prefers-reduced-motion` respetado.
3. **Transición poema** — versos intermedios de marca.
4. **Menú** — chips por categoría, tarjetas de producto con estado *Disponible/Agotado* y `<dialog>` de detalle (retrato del producto, precio, y desglose _"¿Qué lleva?"_ con los ingredientes separados por coma).
5. **Promos** — cupones tipo ticket; el botón *Copiar* copia el código al portapapeles.
6. **Sucursales** — tarjetas por local: estatus (Abierta/Próximamente/Cerrada), teléfono clicable, WiFi/pet-friendly, **mapa de Google embebido** y botón _Cómo llegar_ (deeplink de Maps).
7. **Footer** + botón FAB que abre `AdminModal` (gestión rápida desde el landing para staff logueado).

## Panel de administración (`/admin`)

Panel SSR (no prerender) rediseñado según `DISENO_Admin_AmorAmorCafe.md`: sidebar rojo, header sticky con buscador, KPIs, toasts y modales `<dialog>` con animación.

- **Login staff** (email + contraseña vía Supabase Auth; la pantalla previa si no hay sesión).
- **Pestañas de CRUD** — *Novedades (promos)*, *Menú (products)*, *Categorías* y *Sucursales*: alta, edición inline, baja y búsqueda en tiempo real.
- **Subida de imágenes** al bucket `product-images` de Storage; si la política falla, cae al campo de URL manual.
- Acceso por `feat(admin)` — solo cuenta con rol `admin`/`staff` en `profiles`.

---

## Diseño y marca

- **Paleta** (tokens Tailwind en `src/styles/global.css`): *Rojo Pasión* `#DC2626` como único acento rojo, fondos *Cream* `#FFFDF9` / *Warm Ivory* `#F9F6F0`, tipografía *Chocolate* `#3A1E19`, acentos *Caramel/Gold*, escenario oscuro `#120907` para la vitrina 2.5D, y tokens propios del panel admin (`choc`/`ivory`). Referencias: `especificaciones_de_dise_o_e_implementaci_n.md` y `DISENO_Admin_AmorAmorCafe.md`.
- **Tipografías**: Playfair Display (titulares), Plus Jakarta Sans (cuerpo), Caveat (poesía) vía Google Fonts; Kaushan Script autohospedada para el wordmark del logo.
- **Accesibilidad y pulido**: `prefers-reduced-motion` (desactiva animación de modales y escala al presionar), `prefers-reduced-transparency` (modales opacos) y `prefers-contrast: more` (fondos sólidos + borde grueso).

## Scripts

| Comando | Acción |
| :--- | :--- |
| `npm run dev` | Dev server en `localhost:4321` |
| `npm run build` | Build de producción SSR a `.vercel/output` (adaptador Vercel) |
| `npm run preview` | Previsualiza el build localmente |

## Branching model

- **GitHub Flow**: una rama por funcionalidad `feat/<tema>`, `fix/<tema>`, `chore/<tema>` o `docs/<tema>`; se integra a `main` con merge commit (`--no-ff`) y build green verificado rama por rama.
- **Commits atómicos** con [Conventional Commits](https://www.conventionalcommits.org/es/) (`feat:`, `fix:`, `chore:`, `docs:`), un solo tema por commit.
- `main` siempre publicable: nunca se mergea algo sin build local verde.

## Despliegue (Vercel)

1. Importar el repo en Vercel — el framework es auto-detectado (Astro + `@astrojs/vercel`).
2. Configurar en *Project Settings → Environment Variables*: `PUBLIC_SUPABASE_URL` y `PUBLIC_SUPABASE_PUBLISHABLE_KEY` (en preview y production).
3. Deploy a partir de `main` (página `/` prerenderizada; `/admin` y el middleware corren como funciones on-demand).

---

## Roadmap

- [ ] CI/CD con **GitHub Actions** (install → build → deploy a Vercel u otra plataforma en cada push a `main`).
- [ ] Comentarios de visitantes (`comentarios`) expuestos en el landing.
- [ ] Galería de productos con imágenes reales subidas por el staff.

---

_Hecho con 🤎 y una gota de amor — Amor Amor Café._
