# 🌹 Especificación Maestra de Arquitectura, Diseño e Integración Backend

## Proyecto: Cafeteria Amor Amor — "La Esencia del Café"

---

## 1. Visión General y Concepto de Marca

**Cafeteria Amor Amor** es una experiencia gastronómica y digital cálida, romántica e inmersiva. Combina alta repostería (Bubble Waffles, Crepas Japonesas, Waffles Coreanos, Frappés) con la calidez de la literatura poética y una experiencia interactiva moderna en la web.

### 1.1 Slogan Oficial & Tono

- **Slogan Principal:** _"La esencia del café, con una gota de lo nuestro."_
- **Slogan Secundario:** _"Donde el café se encuentra con el corazón."_
- **Tono de Comunicación:** Cálido, poético, cercano, elegante, romántico y artesanal.

---

## 2. Identidad Visual, Paleta de Colores y Logotipo

### 2.1 Paleta de Colores Oficial (Warm Romantic Palette)

| Nombre del Color   | Código Hex | TailWind Class      | Aplicación / Uso                                               |
| :----------------- | :--------- | :------------------ | :------------------------------------------------------------- |
| **Pasión Red**     | `#DC2626`  | `brand-red`         | Botones primarios, llamados a la acción (CTA), badges, acentos |
| **Dark Heart Red** | `#991B1B`  | `brand-darkRed`     | Hover states de botones, encabezados oscuros                   |
| **Warm Rose**      | `#FCA5A5`  | `brand-rose`        | Bordes finos, fondos de cupones, brillos sutiles               |
| **Cream Ivory**    | `#FFFDF9`  | `brand-cream`       | Fondo principal de la página (remplaza al blanco puro `#FFF`)  |
| **Warm Ivory**     | `#F9F6F0`  | `brand-warmIvory`   | Fondos de tarjetas, secciones secundarias                      |
| **Rich Chocolate** | `#3A1E19`  | `brand-chocolate`   | Tipografía principal, títulos oscuros, pie de página           |
| **Caramel Gold**   | `#D97706`  | `brand-caramel`     | Subtítulos, acentos de poesía, etiquetas de precio             |
| **Golden Honey**   | `#F59E0B`  | `brand-gold`        | Estrellas de valoración, bordes de promociones                 |
| **Deep Velvet**    | `#120907`  | `--background-dark` | Fondo exclusivo para la experiencia 2.5D Parallax              |

### 2.2 Variables CSS Globales & Configuración Tailwind

```css
:root {
  --brand-red: #dc2626;
  --brand-dark-red: #991b1b;
  --brand-rose: #fca5a5;
  --brand-cream: #fffdf9;
  --brand-warm-ivory: #f9f6f0;
  --brand-chocolate: #3a1e19;
  --brand-caramel: #d97706;
  --brand-gold: #f59e0b;
  --background-dark: #120907;
}
```

```javascript
// tailwind.config.js
module.exports = {
  theme: {
    extend: {
      colors: {
        brand: {
          red: "#DC2626",
          darkRed: "#991B1B",
          rose: "#FCA5A5",
          cream: "#FFFDF9",
          warmIvory: "#F9F6F0",
          chocolate: "#3A1E19",
          caramel: "#D97706",
          gold: "#F59E0B",
        },
      },
      fontFamily: {
        sans: ['"Plus Jakarta Sans"', "sans-serif"],
        serif: ['"Playfair Display"', "serif"],
        cursive: ['"Caveat"', "cursive"],
      },
    },
  },
};
```

### 2.3 Sistema Tipográfico

1. **Títulos Principales & Encabezados:** `Playfair Display` (Serif elegante, transmite sofisticación y romance).
2. **Cuerpo de Texto y Menú:** `Plus Jakarta Sans` (Sans-serif moderno, legible y limpio).
3. **Versos, Poemas y Frases:** `Caveat` (Cursiva orgánica tipo manuscrito para sensaciones personales).

### 2.4 Integración y Espacio del Logotipo (Logo Container)

El logotipo oficial debe situarse en la esquina superior izquierda de la barra de navegación y en el footer.

- **Requisitos del Contenedor de Logo:**
  - **Ubicación Principal:** Navbar (`Header`).
  - **Dimensiones Recomendadas:** 48px x 48px (móvil) o 56px x 56px (escritorio) para la versión isotipo; o ancho máximo de 180px para imagotipo horizontal.
  - **Formato Esperado:** SVG o PNG transparente (`logo.png` / `logo.svg`).
  - **Estructura HTML de Integración:**

```html
<a
  href="#"
  class="flex items-center gap-3 group"
  aria-label="Cafeteria Amor Amor Inicio"
>
  <div
    class="relative w-12 h-12 flex items-center justify-center overflow-hidden rounded-full bg-brand-warmIvory border border-brand-rose/40 shadow-sm group-hover:scale-105 transition-transform"
  >
    <!-- ESPACIO PARA EL LOGO DEL CLIENTE -->
    <img
      src="/logo.png"
      alt="Cafeteria Amor Amor Logotipo"
      class="w-full h-full object-contain p-1"
      onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';"
    />
    <!-- Fallback si la imagen de logo aún no carga -->
    <div
      class="hidden w-full h-full bg-brand-red text-white items-center justify-center font-bold"
    >
      <i class="fa-solid fa-heart text-xl animate-pulse"></i>
    </div>
  </div>
  <div>
    <span
      class="font-serif text-2xl font-extrabold tracking-tight text-brand-chocolate block leading-none"
    >
      Amor Amor <span class="text-brand-red">Café</span>
    </span>
    <span
      class="font-cursive text-brand-caramel text-base leading-none block -mt-0.5"
    >
      La esencia del café, con una gota de lo nuestro
    </span>
  </div>
</a>
```

---

## 3. Antología Poética Integrada (Copywriting Romántico)

El agente de IA debe integrar automáticamente estos poemas en las secciones especificadas:

1. **Sección Hero (Banner Principal):**

   > _"Tomemos un café y dejemos que el tiempo entienda que el amor no lleva prisa."_

2. **Sección 2.5D Parallax Showcase:**

   > _"Hay amores que nacen de un suspiro y otros que se hornean burbuja a burbuja."_

3. **Separador de Transición (Poetry Break):**

   > _"Si vas a querer a alguien, quiérele con café por las mañanas, waffles por las tardes y poemas en el corazón a cada hora."_

4. **Sección de Menú:**

   > _"Cada receta guarda un secreto: una pizca de canela, un toque de dulzura y toda la dedicación de nuestras manos."_

5. **Pie de Página (Footer):**
   > _"Donde el café se encuentra con el corazón."_

---

## 4. Especificación Matemática de la Animación 2.5D Parallax

La animación 2.5D convierte una imagen 2D con fondo transparente (Bubble Waffle `bubblewaffle.png`) en una experiencia tridimensional inmersiva accionada por el desplazamiento del usuario (`window.scrollY`).

### 4.1 Algoritmo en JavaScript Vanilla / Astro

```javascript
(() => {
  const section = document.getElementById("parallax-experience");
  const product = document.getElementById("productWrap");
  const shadow = document.getElementById("productShadow");
  const title = document.getElementById("productTitle");
  const subtitle = document.getElementById("productSubtitle");

  const reduceMotion = window.matchMedia("(prefers-reduced-motion: reduce)");
  let ticking = false;

  // Funciones Matemáticas de Interpolación
  const clamp01 = (value) => Math.max(0, Math.min(1, value));
  const lerp = (start, end, progress) => start + (end - start) * progress;
  const smoothstep = (value) => value * value * (3 - 2 * value);

  function render() {
    ticking = false;

    if (reduceMotion.matches) {
      product.style.transform = "translate3d(-50%, -50%, 0) scale(1)";
      shadow.style.transform = "translate3d(-50%, 0, 0) scale(1)";
      shadow.style.opacity = "0.6";
      return;
    }

    const rect = section.getBoundingClientRect();
    const scrollableDistance = section.offsetHeight - window.innerHeight;
    const rawProgress =
      scrollableDistance > 0 ? clamp01(-rect.top / scrollableDistance) : 0;

    // Aplicar curva de aceleración suave
    const p = smoothstep(rawProgress);

    const isMobile = window.matchMedia("(max-width: 650px)").matches;

    // Matriz de Transformación Parallax
    const startX = isMobile ? 0 : -22;
    const endX = isMobile ? 0 : 28;
    const startY = isMobile ? 18 : 32;
    const endY = isMobile ? -16 : -38;

    const scale = lerp(0.86, 1.12, p);
    const rotation = lerp(-5, 5, p);
    const x = lerp(startX, endX, p);
    const y = lerp(startY, endY, p);

    // Aplicar transformación 3D mediante hardware acceleration
    product.style.transform = `translate3d(calc(-50% + ${x}px), calc(-50% + ${y}px), 0) scale(${scale}) rotate(${rotation}deg)`;

    // Sombra Elíptica Reactiva
    const shadowScale = lerp(0.72, 1.12, p);
    const shadowOpacity = lerp(0.4, 0.75, p);
    const shadowY = lerp(12, -4, p);
    shadow.style.transform = `translate3d(-50%, ${shadowY}px, 0) scale(${shadowScale})`;
    shadow.style.opacity = String(shadowOpacity);
    shadow.style.filter = `blur(${lerp(26, 18, p)}px)`;

    // Parallax Multi-plano en textos
    if (title)
      title.style.transform = `translate3d(${lerp(-10, 20, p)}px, ${lerp(12, -18, p)}px, 0)`;
    if (subtitle)
      subtitle.style.transform = `translate3d(${lerp(8, -14, p)}px, ${lerp(16, -10, p)}px, 0)`;
  }

  function requestRender() {
    if (!ticking) {
      ticking = true;
      window.requestAnimationFrame(render);
    }
  }

  window.addEventListener("scroll", requestRender, { passive: true });
  window.addEventListener("resize", requestRender);
  render();
})();
```

---

## 5. Especificación del Backend Supabase (Estándar Actualizado 2026)

> ⚠️ **REGLA CRÍTICA DE AUTENTICACIÓN Y LLAVES SUPABASE:**
> **NO UTILIZAR `SUPABASE_ANON_KEY` (SISTEMA LEGACY OSOLETO).**
> A partir de las versiones recientes de Supabase, las claves públicas client-side se identifican como **`Publishable Key`** (`sbp_...` o `pk_...`).
> Las variables de entorno obligatorias a utilizar son:
>
> - `NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY` (para Next.js)
> - `PUBLIC_SUPABASE_PUBLISHABLE_KEY` (para Astro / Vite)

### 5.1 Estructura de Variables de Entorno (`.env`)

```env
# URL de la instancia Supabase
PUBLIC_SUPABASE_URL=https://<tu-proyecto-id>.supabase.co

# CLAVE PÚBLICA (NUEVO ESTÁNDAR 2026 - PUBLISHABLE KEY)
PUBLIC_SUPABASE_PUBLISHABLE_KEY=sbp_live_examplekey1234567890abcdefghijklmn

# CLAVE PRIVADA (SOLO PARA AMBIENTES SERVER-SIDE / ADMIN API)
SUPABASE_SECRET_ROLE_KEY=sb_secret_examplekey1234567890
```

### 5.2 Inicialización del Cliente Supabase JS

```javascript
// src/lib/supabase.js
import { createClient } from "@supabase/supabase-js";

const supabaseUrl = import.meta.env.PUBLIC_SUPABASE_URL;
const supabasePublishableKey = import.meta.env.PUBLIC_SUPABASE_PUBLISHABLE_KEY;

if (!supabaseUrl || !supabasePublishableKey) {
  throw new Error(
    "Faltan las variables de entorno de Supabase (URL o Publishable Key).",
  );
}

export const supabase = createClient(supabaseUrl, supabasePublishableKey);
```

---

## 6. Esquema de Base de Datos SQL (DDL) & Contratos API

El backend espera y retorna estructuras JSON estrictas. A continuación se define el esquema completo y los contratos de respuesta.

```sql
-- Habilitar extensión UUID
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 1. Tabla de Categorías
CREATE TABLE public.categories (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  slug VARCHAR(100) UNIQUE NOT NULL,
  display_order INT DEFAULT 0,
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. Tabla de Productos
CREATE TABLE public.products (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  category_id UUID REFERENCES public.categories(id) ON DELETE SET NULL,
  name VARCHAR(150) NOT NULL,
  description TEXT NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  image_url TEXT,
  badge_label VARCHAR(50), -- Ej: 'Popular', 'Nuevo', 'Recomendado'
  is_available BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 3. Tabla de Sucursales
CREATE TABLE public.branches (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  address TEXT NOT NULL,
  schedule VARCHAR(100) NOT NULL,
  map_url TEXT,
  status VARCHAR(20) DEFAULT 'active' CHECK (status IN ('active', 'upcoming', 'closed')),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 4. Tabla de Anuncios y Cupones
CREATE TABLE public.promotions (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  title VARCHAR(150) NOT NULL,
  code VARCHAR(50) UNIQUE NOT NULL, -- Ej: 'AMOR2X1'
  description TEXT NOT NULL,
  discount_percentage INT,
  valid_until DATE,
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### 6.1 Contratos de Entrada y Salida (API Payloads)

#### A. Obtener Menú Completo (`GET /rest/v1/products?select=*,categories(*)`)

**Respuesta Esperada del Backend (HTTP 200 OK):**

```json
[
  {
    "id": "e3a41b22-8239-4d91-a128-403d981a8001",
    "category_id": "c1a41b22-8239-4d91-a128-403d981a8000",
    "name": "Bubble Waffle Kinder Bueno",
    "description": "Crujiente cono de burbujas, helado de vainilla artesanal, galleta Kinder, toppings de nuez y fudge caliente.",
    "price": 125.0,
    "image_url": "https://<tu-proyecto-id>.supabase.co/storage/v1/object/public/product-images/bubblewaffle.png",
    "badge_label": "Popular",
    "is_available": true,
    "categories": {
      "id": "c1a41b22-8239-4d91-a128-403d981a8000",
      "name": "Bubble Waffles",
      "slug": "bubble-waffle"
    }
  },
  {
    "id": "e3a41b22-8239-4d91-a128-403d981a8002",
    "category_id": "c2b41b22-8239-4d91-a128-403d981a8000",
    "name": "Crepa Japonesa 'Amor Mío'",
    "description": "Enrollada en cono estilo Tokio, rellena de fresas frescas, crema batida y Nutella.",
    "price": 98.0,
    "image_url": "https://<tu-proyecto-id>.supabase.co/storage/v1/object/public/product-images/crepa.png",
    "badge_label": "Dulce Romance",
    "is_available": true,
    "categories": {
      "id": "c2b41b22-8239-4d91-a128-403d981a8000",
      "name": "Crepas Japonesas",
      "slug": "crepas"
    }
  }
]
```

#### B. Obtener Cupones Activos (`GET /rest/v1/promotions?is_active=eq.true`)

**Respuesta Esperada del Backend (HTTP 200 OK):**

```json
[
  {
    "id": "p1a41b22-8239-4d91-a128-403d981a9001",
    "title": "2x1 Parejas",
    "code": "AMOR2X1",
    "description": "2x1 en todos los Bubble Waffles los días martes y miércoles de 3 PM a 7 PM.",
    "discount_percentage": 50,
    "valid_until": "2026-12-31",
    "is_active": true
  },
  {
    "id": "p1a41b22-8239-4d91-a128-403d981a9002",
    "title": "Descuento Especial Enamorados",
    "code": "DULCEBESO",
    "description": "15% de descuento en tu cuenta total presentando la aplicación en caja.",
    "discount_percentage": 15,
    "valid_until": "2026-12-31",
    "is_active": true
  }
]
```

#### C. Crear / Actualizar Producto desde Panel Admin (`POST /rest/v1/products`)

**Payload que la app enviará al Backend (Request Body):**

```json
{
  "category_id": "c1a41b22-8239-4d91-a128-403d981a8000",
  "name": "Frappé Red Velvet Heart",
  "description": "Base cremosa de pastel Red Velvet, toque de espresso y topping de chantilly.",
  "price": 85.0,
  "image_url": "https://<tu-proyecto-id>.supabase.co/storage/v1/object/public/product-images/frappe-red-velvet.png",
  "badge_label": "Frío & Cremoso",
  "is_available": true
}
```

---

## 7. Directivas para el Agente de IA Generador

Al procesar esta especificación, la IA debe garantizar:

1. **Fidelidad Estética:** Mantener el fondo cálido `#FFFDF9`, el color rojo pasión `#DC2626` en acciones clave, los acentos dorado/caramelo y los textos en tipografía `Playfair Display` y `Caveat`.
2. **Espacio reservado para Logo:** Incluir el contenedor `<img>` para `logo.png` con fallback automático a un ícono de corazón estilizado en caso de ausencia.
3. **Animación 2.5D Fluida:** Integrar sin modificaciones el bloque del script de animación con `smoothstep` y `lerp`, vinculado al ID `parallax-experience`.
4. **Cero Claves Legacy:** Verificar que en ningún archivo exista la cadena `ANON_KEY` o `anon_key`. Todas las llamadas client-side deben utilizar `PUBLISHABLE_KEY`.
5. **Composición de Menú:** Incluir filtrado interactivo por categorías (`Bubble Waffles`, `Crepas Japonesas`, `Frappés`, `Waffles Coreanos`) y modales desple
