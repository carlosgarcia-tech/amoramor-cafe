# Sistema de Diseño · Admin Panel — Amor Amor Café

Documento de especificaciones visuales extraído de `admin_moderno.html`.
Stack: HTML + Tailwind CSS (CDN) + JavaScript vanilla + Google Fonts. Backend opcional: Supabase (REST).

---

## 1. Concepto y personalidad

- **Marca:** cafetería de waffles, crepas japonesas, waffles coreanos y frappés.
- **Tono visual:** romántico, cálido, artesanal, de cafetería. Mezcla una sans geométrica muy pesada (energía moderna) con una serif itálica (calidez y poesía).
- **Motivo recurrente:** el **corazón** (SVG) en logo divider, tarjetas, cupones y marcas de agua.
- **Regla de oro de color:** **un solo rojo en todo el panel** (`#DC2626`). Nunca introducir otro rojo, rosa o variante.
- **Mensajes de marca (copy):**
  - "La esencia del café, con una gota de lo nuestro."
  - "Crujiente por fuera, tierno en su centro, como el amor verdadero que nace por dentro."
  - "Preparado con amor, servido con pasión."
  - "Gracias por ser parte de nuestra dulce tradición."
- **Idioma:** español (`lang="es"`), localización `es-MX`, moneda MXN.

---

## 2. Paleta de colores

| Token Tailwind | Nombre | HEX | Uso |
|---|---|---|---|
| `brand-red` | Rojo Pasión (único rojo) | `#DC2626` | Sidebar, CTA, badges activos, acentos de título, iconos de cupón, tarjeta principal de KPI, cita final |
| `brand-cream` | Crema Marfil | `#FFFDF9` | Fondo general de página, header, modal, texto sobre rojo/chocolate, "muescas" del cupón |
| `brand-ivory` | Blanco cálido | `#FAF4E8` | Fondo de tarjetas, inputs, buscador, botones secundarios, cupón activo |
| `brand-choc` | Chocolate Oscuro | `#451A03` | Color de texto base, KPI oscuro, toast, sombras, bordes (con opacidad) |
| `brand-gold` | Dorado Miel | `#D97706` | Eyebrows/kickers, bordes de cupón activo, marco del menú, precios/píldoras, estrellas, fecha de vencimiento |
| — | Scrollbar thumb | `#E9DCC4` | Barra de scroll (borde 3px `#FFFDF9`) |
| — | Blanco | `#FFFFFF` | Texto sobre rojo/dorado |

### Uso de opacidades (patrón)
- Texto secundario sobre claro: `brand-choc/75` (serif itálica), `/70`, `/60` (labels de KPI), `/55` (inactivos), `/45` (placeholder).
- Bordes sobre claro: `brand-choc/10` (tarjetas), `/15` (inputs, botones), `/20` (inputs modal), `/25` (cupón expirado).
- Texto sobre rojo: `white`, separadores `white/40`, marcas de agua corazón `white/15`.
- Texto sobre chocolate: `brand-cream`, secundario `/85` y `/70`.
- Dorado: bordes `gold/60` y `gold/70`, fondo `gold/15` (chip "En línea").
- Selección de texto: fondo `brand-red`, texto `white`.

### Estados semánticos
| Estado | Estilo |
|---|---|
| Activo | Fondo `brand-ivory`, borde dashed dorado, badge rojo con texto blanco, icono rojo |
| Expirado | Fondo `brand-cream`, borde dashed `choc/25`, texto `choc/50–55`, badge `choc/10`, icono gris |
| En línea | Chip dorado: borde `gold`, fondo `gold/15`, texto `gold`, punto con `animate-pulse` |

---

## 3. Tipografía

### Familias (Google Fonts)
```html
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800;900&family=Playfair+Display:ital,wght@0,600;1,400;1,500;1,600&display=swap" rel="stylesheet">
```
- **Sans (principal):** `Montserrat`, fallback `Inter, system-ui, sans-serif`
- **Serif (acento):** `Playfair Display` (**siempre en cursiva**), fallback `Merriweather, Georgia, serif`
- Suavizado: `-webkit-font-smoothing: antialiased`.
- Números de KPI y precios: `tabular-nums`.
- Código de cupón en formulario: `font-mono`, `uppercase`, `tracking-wider`.

### Escala tipográfica

| Elemento | Fuente | Tamaño | Peso | Extras |
|---|---|---|---|---|
| Fecha (kicker del header) | Montserrat | 11px | 700 | mayúsculas, `tracking .22em`, color dorado |
| Saludo H1 | Montserrat | 30px móvil / 40px desktop | 900 | `tracking-tight`, "equipo" en rojo |
| Subtítulo del header | Playfair itálica | 17px | 400 | `choc/75`, max-w 2xl |
| "Admin Panel" (sidebar) | Playfair itálica | 24px (`text-2xl`) | 400 | centrado |
| Lema del sidebar | Playfair itálica | 19px / lh 24px | 400 | centrado |
| Items de navegación | Montserrat | 14px | 700 activo / 600 inactivo | |
| Label de KPI | Montserrat | 11px | 700 | mayúsculas, `tracking .18em` |
| Número de KPI | Montserrat | 56px, lh 1 | 900 | `tabular-nums` |
| Subtexto KPI | Playfair itálica | 18px | 400 | |
| H2 de sección | Montserrat | 30px / 36px | 900 | `tracking-tight` |
| Descripción de sección | Playfair itálica | 19px | 400 | `choc/75` |
| Eyebrow de menú ("Esta semana") | Montserrat | 11px | 700 | mayúsculas, `tracking .3em`, dorado |
| Código de cupón | Montserrat | 26px / 30px, lh 1 | 900 | `tracking-tight`, `break-all` |
| Descripción de cupón | Montserrat | 15px | 500 | |
| Vencimiento | Playfair itálica | 18px | 400 | dorado (activo) |
| Badge de estado | Montserrat | 12px | 700 | píldora |
| Botón primario | Montserrat | 14px | 700 | |
| Producto (menú) | Montserrat | 18px | 800 | |
| Descripción de producto | Playfair itálica | 15px, lh 16px | 400 | `choc/70` |
| Precio/cantidad (píldora) | Montserrat | 14px | 700 | `tabular-nums` |
| Cita de marca | Playfair itálica | 28px, lh 1.2 | 400 | blanco |
| Footer | Playfair itálica | 20px | 400 | `choc/75` |
| Toast | Montserrat | 14px | 600 | |

---

## 4. Espaciado, radios y sombras

### Radios (muy redondeados — sello del diseño)
| Elemento | Radio |
|---|---|
| Tarjetas grandes / KPI / cupón / modal | `28px` |
| Marco interior dorado del menú | `20px` |
| Logo contenedor | `28px` |
| Inputs del modal | `rounded-2xl` (16px) |
| Botones, chips, buscador, nav, badges, avatar | `rounded-full` |

### Sombras
| Token | Valor | Uso |
|---|---|---|
| `shadow-card` | `0 12px 30px -18px rgba(69,26,3,.35)` | Tarjetas ivory/chocolate, logo, toast |
| `shadow-red` | `0 12px 26px -10px rgba(220,38,38,.5)` | Elementos rojos: KPI principal, CTA, tarjeta de cita, botón guardar |
| Hover cupón | `0 18px 34px -20px rgba(69,26,3,.45)` | Cupón al pasar el mouse |
| Modal | `shadow-2xl` | Diálogo |

### Espaciado clave
- Contenido: `px-5` móvil / `px-10` desktop, `py-9`, separación entre secciones `space-y-12` (48px), ancho máx. `1400px`.
- Grid de KPI: gap `16px` móvil / `24px` desktop. Padding de tarjeta: `24px`.
- Grid de cupones: gap `24px`.
- Sidebar: padding `px-7 py-9`.
- Header: padding `px-5 sm:px-10 py-5`.

---

## 5. Layout general

```
┌───────────────┬──────────────────────────────────────────┐
│ SIDEBAR rojo  │ HEADER sticky (crema, borde inferior)    │
│ 280px (md+)   ├──────────────────────────────────────────┤
│               │ Nav móvil (solo < md)                    │
│ Logo          │ 4 KPI cards                              │
│ Admin Panel   │ Últimas promociones (cupones 2 cols)     │
│ ── ♥ ──       │ Lo más pedido (3/5) + Cita roja (2/5)    │
│ Nav           │ Footer                                   │
│ Lema + estado │                                          │
└───────────────┴──────────────────────────────────────────┘
```

- `body`: `h-[100dvh] overflow-hidden flex`, fondo `#FFFDF9`, color `#451A03`.
- `main`: `flex-1 min-w-0 overflow-y-auto` (el scroll ocurre solo en el contenido).
- **Breakpoints Tailwind:** `sm` 640 · `md` 768 (aparece sidebar) · `lg` 1024 · `xl` 1280 (4 KPIs y 2 columnas de cupones).

---

## 6. Componentes

### 6.1 Sidebar
- Ancho `17.5rem` (280px), `shrink-0`, **oculto bajo `md`**. Fondo `brand-red`, texto blanco, `z-20`.
- Distribución vertical `justify-between`: bloque superior (logo + nav) y bloque inferior (lema + estado).
- **Logo:** enlace centrado, `w-44` (176px), fondo `brand-cream`, `rounded-[28px]`, `p-4`, `shadow-card`. Hover: `opacity-80` + `scale-105` (300ms). Imagen PNG embebida en base64, `alt="Amor Amor Café"`.
- Texto "Admin Panel": serif itálica 24px centrada, `mt-5`.
- **Divisor:** línea 1px `white/40` – corazón (14px, con animación `beat`) – línea 1px `white/40`; margen vertical 24px.
- **Navegación** (`space-y-2`): Dashboard, Novedades, Menú, Sucursales.
  - Item: `flex gap-3.5`, `rounded-full`, `px-5 py-3`, texto 14px, icono 18×18 de trazo (stroke 2, sin relleno, `currentColor`).
  - Inactivo: `opacity .9`, peso 600. Hover: `opacity 1` + `translateX(6px)`.
  - **Activo:** fondo `#FFFDF9`, texto `#DC2626`, peso 700.
  - Transición 250ms en transform, opacity, background-color y color.
- **Pie:** lema en serif itálica 19px centrado; debajo, píldora de estado: borde `white/40`, `px-4 py-2.5`, texto 12px 600, punto blanco 8px + texto ("Modo demo" / "Supabase conectado").

### 6.2 Header (sticky)
- `sticky top-0 z-10`, fondo `brand-cream`, borde inferior `choc/10`.
- Izquierda: fecha (kicker dorado, `toLocaleDateString('es-MX',{weekday,day,month})`), H1 con saludo dinámico (Buenos días < 12h, Buenas tardes < 19h, Buenas noches después) + "equipo" en rojo, y subtítulo serif.
- Derecha (gap 12px):
  - **Buscador** (solo ≥ sm): píldora `bg-ivory`, borde `choc/15`, `px-4 py-2.5`; en `focus-within` borde rojo. Icono lupa 16px `choc/60`, input transparente `w-36`, placeholder `choc/45`.
  - **Notificaciones:** botón circular 44×44, fondo ivory, borde `choc/15` (hover rojo), icono campana 20px; punto rojo 10px arriba-derecha con `ring-2 ring-brand-cream`.
  - **Avatar:** círculo 44×44 rojo, texto blanco "AA" 14px 900.

### 6.3 Navegación móvil (< md)
Fila horizontal scrollable (`overflow-x-auto`), gap 8px. Chips `rounded-full px-4 py-2` 14px 700. Activo: rojo/blanco. Inactivos: ivory con borde `choc/15`.

### 6.4 Tarjetas de métricas (KPI)
Grid `2 cols` → `xl: 4 cols`. Todas `rounded-[28px] p-6`, animación `rise` escalonada (0, .08, .16, .24s).

| # | Variante | Fondo / borde | Contenido |
|---|---|---|---|
| 1 | **Roja (principal)** | `brand-red`, texto blanco, `shadow-red`, corazón 128px `white/15` posicionado `-right-5 -bottom-6` | Cupones activos · **12** · "listos para enamorar" |
| 2 | Ivory | `brand-ivory` + borde `choc/10` + `shadow-card` | Productos en menú · **45** · "waffles, crepas y frappés" |
| 3 | Ivory | igual | Comentarios nuevos · **8** · 5 estrellas doradas 20px |
| 4 | **Chocolate** | `brand-choc`, texto crema, `shadow-card` | Sucursales abiertas · **3** + chip "En línea" (dorado, con punto pulsante) · "con las puertas abiertas" |

IDs dinámicos: `k-activos`, `k-productos`, `k-sucursales`.

### 6.5 Cupón (ticket)
Cuadrícula `1 col` → `xl: 2 cols`, gap 24px. Cada cupón:
- `rounded-[28px]`, borde **1.5px dashed**, `p-6`.
  - Activo: borde `brand-gold`, fondo `brand-ivory`.
  - Expirado: borde `choc/25`, fondo `brand-cream`.
- **Fila superior:** círculo 48px con corazón (activo: fondo rojo, texto blanco, animación `beat`; expirado: `choc/10`, icono `choc/40`) + código (26–30px, 900) + descripción (15px 500) · a la derecha badge "Activo"/"Expirado".
- **Línea de corte (perforación):** separador `border-t-2 border-dashed` (dorado/70 o `choc/20`) con **dos semicírculos de 22px** en los extremos (`-left/-right 11px`), fondo crema y borde dashed 1.5px — simula el troquel de un ticket.
- **Fila inferior:** "vence el 30 oct 2026" (serif itálica 18px, dorado) o "este cupón ya venció" (`choc/55`) + enlace "Editar" (rojo, 14px 700, subrayado `underline-offset-4`, decoración 2px, hover `opacity-70`).
- Hover: `translateY(-4px)` + sombra ampliada (300ms).
- Fecha formateada `es-MX` (`day numeric, month short, year numeric`, sin puntos).
- Atributo `data-q` con "CÓDIGO DESCRIPCIÓN" en mayúsculas para el filtro del buscador.
- **Estado vacío:** "Ningún cupón coincide con tu búsqueda." serif itálica 24px `choc/60`, centrado.

### 6.6 Botón primario ("Nuevo cupón")
`rounded-full bg-brand-red text-white px-6 py-3 text-sm font-bold shadow-red`, icono "+" 16px (stroke 3). Hover: `-translate-y-0.5`. Active: `scale-95`.

### 6.7 Sección "Lo más pedido" (menú estilo carta)
- Grid `lg: 5 columnas`: menú ocupa **3**, cita roja ocupa **2** (`gap-6`).
- Tarjeta menú: `rounded-[28px]` ivory, borde `choc/10`, `shadow-card`, padding 28/36px. **Marco interior** decorativo: `inset-3`, `rounded-[20px]`, borde 1px `gold/60`.
- Encabezado centrado: eyebrow dorado, H2 "Lo más pedido", serif itálica, divisor (línea dorada 56px – corazón rojo 16px – línea dorada).
- **Fila de producto** (`flex items-baseline gap-3`): nombre (18px 800) + descripción serif; **línea punteada** `flex-1 border-b-2 border-dotted border-gold/60`; **píldora dorada** (`bg-gold`, blanca, `px-3.5 py-1`, 14px 700) con la cantidad.
- Productos de ejemplo: Bubble Waffle Kinder (128), Frappés (112), Crepas Japonesas (96), Waffles Coreanos (74).
- Nota al pie serif itálica 16px `choc/55`: "datos de ejemplo · conéctalo a tus pedidos en Supabase".

### 6.8 Tarjeta de cita (roja)
`rounded-[28px]`, `bg-brand-red`, texto blanco, `shadow-red`, `p-8`, `flex-col justify-between`, `overflow-hidden`. Corazón 176px `white/15` abajo-derecha. Contiene kicker "AMOR AMOR CAFÉ" (11px, `tracking .3em`), blockquote serif itálica 28px "Preparado con amor, servido con pasión." y línea de agradecimiento 18px.

### 6.9 Modal "Nuevo cupón"
- Elemento nativo `<dialog>`: `m-auto w-[92vw] max-w-md rounded-[28px]`, fondo crema, borde `choc/15`, `shadow-2xl`, `p-0`.
- **Backdrop:** `rgba(69,26,3,.55)` + `backdrop-filter: blur(3px)`.
- Formulario `p-8 space-y-5`. Título 30px 900: "Nuevo **cupón**" (palabra en rojo) + subtítulo serif "con una gota de lo nuestro".
- Campos (label 14px 700, input `mt-1.5 w-full rounded-2xl`, borde `choc/20`, fondo ivory, `px-4 py-3`, focus: borde rojo):
  - Código (`maxlength 16`, mono, mayúsculas, placeholder `WAFFLE50`)
  - Descuento (placeholder `$50 MXN en bebidas`)
  - Vencimiento (`type="date"`)
- Acciones a la derecha: "Cancelar" (texto, hover ivory) y "Guardar cupón" (rojo, `shadow-red`, hover `-translate-y-0.5`, active `scale-95`).

### 6.10 Toast
`fixed bottom-6 left-1/2 -translate-x-1/2 z-50`, `rounded-full`, fondo `brand-choc`, texto crema, `px-5 py-3`, 14px 600, `shadow-card`. Se oculta solo a los 3.5 s.

### 6.11 Footer
Centrado, serif itálica 20px, `choc/75`, `pb-10`: "Preparado con amor, servido con pasión. Gracias por ser parte de nuestra dulce tradición."

---

## 7. Iconografía

- **Estilo:** líneas (outline), `fill="none"`, `stroke="currentColor"`, `stroke-width` 1.9–2, viewBox 24×24, estilo Feather/Lucide.
- **Iconos:** Dashboard (4 rectángulos), Novedades (periódico), Menú (taza), Sucursales (pin de mapa), Buscar (lupa), Notificaciones (campana), Más (+).
- **Símbolos SVG reutilizables** (`<symbol>` en sprite oculto, uso con `<use href="#id">`):
  - `#heart` — corazón relleno (`currentColor`).
  - `#star` — estrella rellena (`currentColor`).
- Tamaños: nav 18px · header 16–20px · estrellas 20px · corazón en cupón 20px · marcas de agua 128–176px.

---

## 8. Animaciones y movimiento

| Nombre | Definición | Uso |
|---|---|---|
| `rise` | `opacity 0 → 1` + `translateY(14px → 0)`, **.6s** `cubic-bezier(.16,1,.3,1)`, `both` | Entrada de KPIs, secciones y cupones |
| Delays | `.d1 .08s` · `.d2 .16s` · `.d3 .24s`; cupones: `index × 80ms` | Cascada |
| `beat` | Latido del corazón: escala 1 → 1.14 (14%) → 1 (28%) → 1.1 (42%) → 1 (70%), **2.6s** `ease-in-out` infinito | Corazón del divisor y de cupones activos |
| Nav hover | `translateX(6px)` + opacidad, 250ms | Items del sidebar |
| Cupón hover | `translateY(-4px)` + sombra, 300ms | Tickets |
| Logo hover | `scale-105` + `opacity-80`, 300ms | Logo |
| Botones | `hover:-translate-y-0.5`, `active:scale-95` | CTA |
| `animate-pulse` | Tailwind | Punto "En línea" |

**Accesibilidad:** `@media (prefers-reduced-motion: reduce)` desactiva `.rise` y `.beat`.

---

## 9. Configuración Tailwind (referencia)

```js
tailwind.config = { theme: { extend: {
  colors: { brand: {
    red:   '#DC2626',
    cream: '#FFFDF9',
    ivory: '#FAF4E8',
    choc:  '#451A03',
    gold:  '#D97706'
  }},
  fontFamily: {
    sans:  ['Montserrat','Inter','system-ui','sans-serif'],
    serif: ['"Playfair Display"','Merriweather','Georgia','serif'],
  },
  boxShadow: {
    card: '0 12px 30px -18px rgba(69,26,3,.35)',
    red:  '0 12px 26px -10px rgba(220,38,38,.5)'
  }
}}}
```

### CSS personalizado clave
```css
html,body{height:100%}
body{font-family:'Montserrat',system-ui,sans-serif;-webkit-font-smoothing:antialiased;background:#FFFDF9;color:#451A03}
@keyframes rise{from{opacity:0;transform:translateY(14px)}to{opacity:1;transform:none}}
.rise{animation:rise .6s cubic-bezier(.16,1,.3,1) both}
@keyframes beat{0%,100%{transform:scale(1)}14%{transform:scale(1.14)}28%{transform:scale(1)}42%{transform:scale(1.1)}70%{transform:scale(1)}}
.beat{animation:beat 2.6s ease-in-out infinite}
.nav-link.active{background:#FFFDF9;color:#DC2626}
dialog::backdrop{background:rgba(69,26,3,.55);backdrop-filter:blur(3px)}
::-webkit-scrollbar{width:10px}
::-webkit-scrollbar-thumb{background:#E9DCC4;border-radius:10px;border:3px solid #FFFDF9}
```

---

## 10. Comportamiento (UX / JavaScript)

- **Modo demo:** si `SUPABASE_URL` y `SUPABASE_PUBLISHABLE_KEY` están vacíos, muestra datos de ejemplo y el estado "Modo demo".
- **Modo conectado:** lee `posts`, `products`, `branches` por REST; el estado cambia a "Supabase conectado". Escritura requiere `ADMIN_JWT` (RLS).
- **Datos de ejemplo de cupones:** `BUBBLE80` ($80 MXN en waffles, vence 2026-10-30, activo) y `KINDER75` ($75 MXN en frappés, sin fecha → expirado).
- **Cálculo de activo:** `fecha + 'T23:59:59' >= ahora`.
- **Búsqueda en vivo:** filtra cupones por código + descripción (mayúsculas); muestra el estado vacío si no hay coincidencias.
- **Crear cupón:** guarda (`posts`: `title`, `content`, `promo_code`, `valid_until`), añade al inicio de la lista, incrementa el KPI de activos si corresponde, resetea el form.
- **Seguridad:** todo texto de usuario pasa por `esc()` (escape de `& < > "`).
- **Errores:** toast "No se pudo guardar. ¿Iniciaste sesión como admin?" / "No se pudo leer Supabase. Mostrando datos de ejemplo."
- **Navegación del sidebar:** solo cambia la clase `active` (maqueta; no hay otras vistas).

---

## 11. Reglas de uso (Do / Don't)

**Hacer**
- Usar siempre `#DC2626` como único rojo.
- Títulos en Montserrat 800–900 con `tracking-tight`; frases emotivas en Playfair itálica.
- Radios generosos (28px en tarjetas, píldoras en controles).
- Un corazón como detalle decorativo, con baja opacidad (`/15`) cuando es marca de agua.
- Sombras teñidas del color de la tarjeta (rojo para rojo, chocolate para neutros).
- Dorado solo como acento (kickers, precios, bordes, estrellas).

**Evitar**
- Negro puro, grises fríos o azules: el neutro es chocolate `#451A03`.
- Blanco puro de fondo: usar crema `#FFFDF9` / ivory `#FAF4E8`.
- Serif en peso normal (no itálica) o sans en pesos < 500 para títulos.
- Esquinas rectas o radios pequeños en tarjetas.
- Más de un color de acento fuerte por componente.

---

## 12. Checklist rápido para replicar el diseño

1. Importar Montserrat + Playfair Display (itálica) y configurar Tailwind con los 5 colores de marca.
2. Layout `flex` de pantalla completa: sidebar rojo 280px + `main` con scroll propio.
3. Header sticky crema con saludo dinámico, buscador, campana y avatar.
4. Cuatro KPIs (rojo, ivory, ivory, chocolate) con números de 56px.
5. Cupones tipo ticket: borde dashed, perforación con dos semicírculos, badge de estado, hover elevado.
6. Carta de menú con marco dorado, líneas punteadas y píldoras doradas + tarjeta roja de cita.
7. Modal nativo `<dialog>` con backdrop chocolate difuminado.
8. Animaciones `rise` y `beat`, respetando `prefers-reduced-motion`.
