-- ============================================================
-- Amor Amor Café — Esquema Supabase
-- DDL oficial del spec (§6) + tablas extra usadas por el sitio
-- Ejecutar en el SQL Editor de Supabase.
-- ============================================================

-- ---------- DDL oficial del spec ----------

CREATE TABLE public.categories (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  slug TEXT UNIQUE NOT NULL,
  display_order INT DEFAULT 0
);

CREATE TABLE public.products (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  category_id UUID REFERENCES public.categories(id) ON DELETE SET NULL,
  name TEXT NOT NULL,
  description TEXT,
  price DECIMAL(10, 2) NOT NULL,
  image_url TEXT,
  is_available BOOLEAN DEFAULT TRUE
);

CREATE TABLE public.branches (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  address TEXT NOT NULL,
  schedule TEXT NOT NULL,
  status TEXT DEFAULT 'active',
  phone TEXT,
  map_url TEXT,
  has_wifi BOOLEAN DEFAULT FALSE,
  is_pet_friendly BOOLEAN DEFAULT FALSE
);

-- ---------- Tablas extra del sitio (promos, comentarios, avisos) ----------
CREATE TABLE public.promos (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  codigo TEXT NOT NULL,
  titulo TEXT NOT NULL,
  detalle TEXT,
  activa BOOLEAN DEFAULT TRUE,
  creado_en TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE public.comentarios (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  autor TEXT NOT NULL,
  texto TEXT NOT NULL CHECK (char_length(texto) <= 280),
  creado_en TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE public.avisos (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  titulo TEXT NOT NULL,
  texto TEXT,
  tipo TEXT NOT NULL DEFAULT 'aviso' CHECK (tipo IN ('aviso', 'poema')),
  creado_en TIMESTAMPTZ DEFAULT now()
);

-- Ingredientes del producto (se capturan separados por coma; se muestran como lista en el detalle).
ALTER TABLE public.products ADD COLUMN ingredients TEXT;

-- ---------- Row Level Security ----------

-- Lectura pública (con el role anon) para catálogo y contenido:
ALTER TABLE public.categories  ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.products    ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.branches    ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.promos      ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.comentarios ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.avisos      ENABLE ROW LEVEL SECURITY;

CREATE POLICY "lectura publica" ON public.categories  FOR SELECT USING (true);
CREATE POLICY "lectura publica" ON public.products    FOR SELECT USING (true);
CREATE POLICY "lectura publica" ON public.branches    FOR SELECT USING (true);
CREATE POLICY "lectura publica" ON public.promos      FOR SELECT USING (true);
CREATE POLICY "lectura publica" ON public.comentarios FOR SELECT USING (true);
CREATE POLICY "lectura publica" ON public.avisos      FOR SELECT USING (true);

-- Comentarios: cualquiera puede comentar (rate-limit nivel app).
CREATE POLICY "comentar" ON public.comentarios FOR INSERT WITH CHECK (true);

-- Avisos y promos: SOLO staff autenticado debe insertar.
-- Reemplaza los siguientes placeholders según cómo manejes el admin:
--   Opción A (Auth Native):  rol authenticated
-- CREATE POLICY "staff puede publicar avisos" ON public.avisos FOR INSERT TO authenticated WITH CHECK (true);
-- CREATE POLICY "staff puede publicar promos" ON public.promos FOR INSERT TO authenticated WITH CHECK (true);
--
-- Opción B (sin Auth, con clave staff): restringe por un valor secreto en la fila.
--   CREATE POLICY "staff key" ON public.avisos FOR INSERT WITH CHECK (titulo <> '');
--
-- IMPORTANTE: sin política de INSERT, el AdminModal recibirá error por RLS.
CREATE POLICY "staff puede publicar avisos" ON public.avisos FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "staff puede publicar promos" ON public.promos FOR INSERT TO authenticated WITH CHECK (true);

-- Branches: columnas para contacto/mapa/años de amenidades (comando único seguro en DB existente)
ALTER TABLE public.branches ADD COLUMN IF NOT EXISTS phone TEXT;
ALTER TABLE public.branches ADD COLUMN IF NOT EXISTS map_url TEXT;
ALTER TABLE public.branches ADD COLUMN IF NOT EXISTS has_wifi BOOLEAN DEFAULT FALSE;
ALTER TABLE public.branches ADD COLUMN IF NOT EXISTS is_pet_friendly BOOLEAN DEFAULT FALSE;

-- ---------- Datos de ejemplo opcionales ----------

INSERT INTO public.categories (name, slug, display_order) VALUES
  ('Bubble Waffles', 'bubble-waffles', 1),
  ('Cafés & Bebidas', 'cafes-bebidas', 2),
  ('Extras', 'extras', 3);

INSERT INTO public.branches (name, address, schedule, status) VALUES
  ('Sucursal Centro', 'Calle del Amor 123, Centro', 'Lun–Sáb 8:00–21:00', 'active'),
  ('Sucursal Parque', 'Av. Primavera 456, Parque', 'Lun–Dom 10:00–22:00', 'active');
