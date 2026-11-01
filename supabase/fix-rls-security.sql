-- ============================================================
-- FIX DE SEGURIDAD (run en SQL Editor de Supabase).
-- 1) Solo admin/staff (profiles.role) pueden escribir en el catálogo.
-- 2) UPDATE/DELETE de catálogo para staff — el panel admin los necesita.
-- Antes: cualquier usuario autenticado podía insertar productos/promos,
-- y nadie podía editar/eliminar (las políticas solo permitían SELECT/INSERT).
-- ============================================================

-- Perfil con rol (si aún no existe la tabla aquí va por si las dos:
-- ajústala a la que ya tienes en tu proyecto si difiere).
CREATE TABLE IF NOT EXISTS public.profiles (
  id UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
  full_name TEXT,
  role TEXT NOT NULL DEFAULT 'customer'  -- 'admin' | 'staff' | 'customer'
);
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
-- cada usuario lee solo su perfil (el panel lo usa para su rol)
CREATE POLICY "leer propio perfil" ON public.profiles
  FOR SELECT USING (auth.uid() = id);
-- signup crea perfil: cualquiera se crea el propio
CREATE POLICY "crear propio perfil" ON public.profiles
  FOR INSERT TO authenticated WITH CHECK (auth.uid() = id);

-- Helper del rol actual
CREATE OR REPLACE FUNCTION public.mi_rol() RETURNS TEXT
LANGUAGE sql SECURITY DEFINER SET search_path = public STABLE AS $$
  SELECT role FROM public.profiles WHERE id = auth.uid();
$$;

-- ---------- Escritura de catálogo SOLO staff/admin ----------
DROP POLICY IF EXISTS "staff puede publicar promos" ON public.promos;
CREATE POLICY "staff promos" ON public.promos
  FOR INSERT TO authenticated WITH CHECK (public.mi_rol() IN ('admin','staff'));

DROP POLICY IF EXISTS "staff puede publicar avisos" ON public.avisos;
CREATE POLICY "staff avisos" ON public.avisos
  FOR INSERT TO authenticated WITH CHECK (public.mi_rol() IN ('admin','staff'));

-- Products / posts / categories: insert + update + delete de staff
CREATE POLICY "staff insert products" ON public.products
  FOR INSERT TO authenticated WITH CHECK (public.mi_rol() IN ('admin','staff'));
CREATE POLICY "staff update products" ON public.products
  FOR UPDATE TO authenticated USING (public.mi_rol() IN ('admin','staff'));
CREATE POLICY "staff delete products" ON public.products
  FOR DELETE TO authenticated USING (public.mi_rol() IN ('admin','staff'));

CREATE POLICY "staff insert posts" ON public.posts
  FOR INSERT TO authenticated WITH CHECK (public.mi_rol() IN ('admin','staff'));
CREATE POLICY "staff update posts" ON public.posts
  FOR UPDATE TO authenticated USING (public.mi_rol() IN ('admin','staff'));
CREATE POLICY "staff delete posts" ON public.posts
  FOR DELETE TO authenticated USING (public.mi_rol() IN ('admin','staff'));

CREATE POLICY "staff insert categories" ON public.categories
  FOR INSERT TO authenticated WITH CHECK (public.mi_rol() IN ('admin','staff'));
CREATE POLICY "staff update categories" ON public.categories
  FOR UPDATE TO authenticated USING (public.mi_rol() IN ('admin','staff'));
CREATE POLICY "staff delete categories" ON public.categories
  FOR DELETE TO authenticated USING (public.mi_rol() IN ('admin','staff'));

-- Branches: solo admin puede cambiarlas, lecturas siguen públicas
CREATE POLICY "admin insert branches" ON public.branches
  FOR INSERT TO authenticated WITH CHECK (public.mi_rol() = 'admin');
CREATE POLICY "admin update branches" ON public.branches
  FOR UPDATE TO authenticated USING (public.mi_rol() = 'admin');
CREATE POLICY "admin delete branches" ON public.branches
  FOR DELETE TO authenticated USING (public.mi_rol() = 'admin');

-- ---------- Sanitizado: no trappear escalada con usuarios customer ----------
-- Cualquier INSERT por tabla de catálogo ya exige rol staff/admin arriba;
-- el resto de tablas (promos/posts antiguos) quedan cubiertas por sus policies.
-- Los datos existentes no se tocan.
