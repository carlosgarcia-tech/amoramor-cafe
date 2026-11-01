<div align="center">
  <img src="public/logo.png" width="120" alt="Amor Amor Café">

  # Amor Amor Café

  *Bubble waffles, crepas japonesas y frappés — servidos con poemas*

</div>

---

Landing pública y panel de administración de **Amor Amor Café**. La web muestra en vivo Bubble waffles, promociones y sucursales desde una base de datos Supabase, con una vitrina de producto en efecto 2.5D; el staff gestiona todo el contenido desde un panel protegido por sesión de servidor.

**Slogan:** *"La esencia del café, con una gota de lo nuestro."*

## Stack técnico

| Tecnología | Rol |
| :--- | :--- |
| [Astro 7](https://docs.astro.build) | Framework web, con SSR bajo demanda (`output: 'server'`) |
| [Tailwind CSS 4](https://tailwindcss.com) | Estilos con tokens de marca definidos en `@theme` |
| [Supabase](https://supabase.com) | PostgreSQL con RLS, Autenticación y Almacenamiento |
| [@supabase/ssr](https://www.npmjs.com/package/@supabase/ssr) | Sesión del staff en cookies httpOnly |
| [Vercel](https://vercel.com) | Despliegue mediante el adaptador `@astrojs/vercel` |

> [!NOTE]
> Se requiere **Node.js >= 22.23.4** (ver `engines` en `package.json`).

## Estructura del proyecto

```text
/
├── public/
│   ├── logo.png                    # Marca
│   ├── favicon.svg
│   └── fonts/KaushanScript-Regular.woff2   # Fuente de marca (autohospedada, licencia OFL)
├── src/
│   ├── components/
│   │   ├── Navbar.astro            # Barra fija
│   │   ├── Hero.astro              # Portada
│   │   ├── ParallaxSection.astro   # Vitrina 2.5D del Bubble Waffle (controlada por scroll)
│   │   ├── TransicionPoema.astro   # Versos intermedios de la marca
│   │   ├── MenuSection.astro       # Menú: categorías, productos y modal de detalle
│   │   ├── PromosSection.astro     # Novedades y cupones con código
│   │   ├── BranchesSection.astro   # Sucursales con mapa y "cómo llegar"
│   │   ├── Footer.astro
│   │   └── AdminModal.astro        # Gestión rápida desde el landing (staff)
│   ├── layouts/Layout.astro        # HTML global: fuentes, meta y estilos
│   ├── lib/
│   │   ├── supabase.js             # Cliente de navegador (sesión por cookies)
│   │   └── esc.js                  # Helper anti-XSS para textos de la base de datos
│   ├── middleware.ts               # Actualización de la sesión de Supabase + cookies httpOnly
│   ├── pages/
│   │   ├── index.astro             # Landing (estática / prerender)
│   │   └── admin.astro             # Panel de administración (SSR, requiere sesión)
│   └── styles/global.css           # Paleta, tipografía y utilidades de accesibilidad
├── supabase/
│   ├── schema.sql                  # Tablas y políticas RLS base
│   └── fix-rls-security.sql        # Endurece las reglas: escritura solo para staff/admin
└── astro.config.mjs
```

## Puesta en marcha

```sh
# 1. Dependencias
git clone https://github.com/carlosgarcia-tech/amoramor-cafe.git
cd amoramor-cafe
npm install

# 2. Variables de entorno (.env en la raíz)
echo "PUBLIC_SUPABASE_URL=https://TU-PROYECTO.supabase.co"      > .env
echo "PUBLIC_SUPABASE_PUBLISHABLE_KEY=TU_CLAVE_ANON_PUBLICA"   >> ./.env

# 3. Levantar
npm run dev        # http://localhost:4321
```

> [!IMPORTANT]
> La aplicación valida su presencia al arrancar y lanza un error explícito si falta una de las dos variables públicas. Utilice únicamente claves del tipo *publishable/anon*: nunca la clave `service_role` en el lado del navegador.

| Variable | Obligatoria | ¿Dónde? |
| :--- | :--- | :--- |
| `PUBLIC_SUPABASE_URL` | Sí | `.env` local y variables de entorno de Vercel |
| `PUBLIC_SUPABASE_PUBLISHABLE_KEY` | Sí | Idem — clave `anon`/publishable del proyecto Supabase |

## Base de datos

Ejecutar en el **SQL Editor** de Supabase, en este orden:

1. `supabase/schema.sql` — crea tablas y RLS base.
2. `supabase/fix-rls-security.sql` — crea `profiles` (roles `admin` / `staff` / `customer`), el helper `mi_rol()` y restringe toda escritura del catálogo al staff, además de habilitar el `UPDATE`/`DELETE` que el panel necesita.

| Tabla | Contenido | Permisos |
| :--- | :--- | :--- |
| `categories` | Categorías del menú | Lectura pública · escritura para staff |
| `products` | Productos: precio, `ingredients`, imagen, disponibilidad | Idem |
| `branches` | Sucursales: dirección, horario, estatus, WiFi, pet-friendly, Maps | Idem |
| `promos` | Novedades y cupones con código y vigencia | Idem |
| `comentarios` | Comentarios de visitantes | Lectura pública · inserción abierta |
| `avisos` | Avisos del staff | Lectura pública · inserción solo para staff |
| `profiles` | Perfil por usuario con `role` (base del helper `mi_rol()`) | Propio perfil |

**Almacenamiento:** bucket `product-images` (público) para las fotos del menú. El panel sube una imagen por producto y guarda la URL resultante en `products.image_url`, con un campo de URL manual como alternativa.

### Modelo de seguridad

- **RLS en todas las tablas**: lectura pública general; escritura del catálogo limitada a los roles `admin`/`staff` según `profiles.role`.
- **Sesión en cookies httpOnly** (`src/middleware.ts`): el middleware actualiza el token vencido con `@supabase/ssr`; el JavaScript del navegador no puede leer los tokens y `/admin` valida la sesión del lado del servidor. La autorización real de los datos la aplica RLS.
- **Anti-XSS en render**: todo texto proveniente de la base de datos pasa por `esc()` antes de interpolarse en las plantillas HTML.
- `/admin` no ofrece registro: solo inicio de sesión para el staff.

## Página de inicio

Secciones, en orden de desplazamiento (scroll):

1. **Hero** — portada con marca y eslóganes.
2. **Vitrina 2.5D** — el Bubble Waffle flotando en un escenario oscuro: escala, inclinación y sombra animadas conforme al scroll, con respeto a `prefers-reduced-motion`.
3. **Transición poema** — versos intermedios de la marca.
4. **Menú** — chips por categoría, estado *Disponible/Agotado* y modal de detalle con el desglose _"¿Qué lleva?"_ de los ingredientes separados por coma.
5. **Promos** — cupones con botón de copiado del código.
6. **Sucursales** — tarjetas por local con estatus, teléfono, mapa de Google integrado (embed) y botón de _Cómo llegar_.
7. **Footer** — y botón flotante que abre `AdminModal` para el staff conectado.

## Panel de administración (`/admin`)

Panel SSR (no *prerender*), rediseñado según `DISENO_Admin_AmorAmorCafe.md`: barra lateral roja, cabecera fija con búsqueda, KPIs, toasts y modales `<dialog>` con animación.

- **Inicio de sesión de staff** (email + contraseña vía Supabase Auth).
- **Pestañas de CRUD**: *Novedades (promos)*, *Menú (products)*, *Categorías* y *Sucursales* — alta, edición, baja y búsqueda en tiempo real.
- **Subida de imágenes** al bucket `product-images`; si falla la política de Storage, retrocede al campo de URL manual.
- Solo es accesible para cuentas con rol `admin`/`staff` en `profiles`.

## Identidad visual

- **Paleta** (tokens en `src/styles/global.css`): *Rojo Pasión* `#DC2626` como único acento rojo, fondos *Cream* `#FFFDF9` / *Warm Ivory* `#F9F6F0`, tipografía *Chocolate* `#3A1E19`, escenario oscuro `#120907` para la vitrina 2.5D. Referencias: `especificaciones_de_dise_o_e_implementaci_n.md` y `DISENO_Admin_AmorAmorCafe.md`.
- **Tipografía**: Playfair Display (titulares), Plus Jakarta Sans (cuerpo), Caveat (poesía) vía Google Fonts; Kaushan Script autohospedada para el logotipo.
- **Accesibilidad**: soporte de `prefers-reduced-motion`, `prefers-reduced-transparency` y `prefers-contrast: more`.

## Comandos

| Comando | Acción |
| :--- | :--- |
| `npm run dev` | Servidor de desarrollo en `localhost:4321` |
| `npm run build` | Compilación SSR de producción (`@astrojs/vercel`) |
| `npm run preview` | Previsualización del compilado |

## Desarrollo e integración

- **Modelo de ramas**: GitHub Flow — una rama por tema (`feat/…`, `fix/…`, `chore/…`, `docs/…`), integrada a `main` con un commit de merge (`--no-ff`) tras verificar la compilación.
- **Commits atómicos** siguiendo [Conventional Commits](https://www.conventionalcommits.org/es/).
- Regla del proyecto: `main` siempre compilable — no se integran cambios sin que el compilado esté limpio localmente.

## Despliegue

1. Importar el repositorio en Vercel (Astro y el adaptador son detectados y configurados automáticamente).
2. Configurar en *Project Settings → Environment Variables*: `PUBLIC_SUPABASE_URL` y `PUBLIC_SUPABASE_PUBLISHABLE_KEY` (en *preview* y *production*).
3. Desplegar desde `main`: la página `/` se prerenderiza; `/admin` y el middleware se ejecutan como funciones bajo demanda.

---

Hecho por el equipo de **Amor Amor Café**.
