import { createClient } from '@supabase/supabase-js';

/**
 * Cliente de Supabase.
 *
 * Requiere en `.env` (raíz del proyecto):
 *   PUBLIC_SUPABASE_URL=https://TU-PROYECTO.supabase.co
 *   PUBLIC_SUPABASE_PUBLISHABLE_KEY=sb_publishable_XXXX
 *
 * Se usa la publishable key (formato nuevo de Supabase —
 * la clave legacy está deprecada y debe eliminarse de todos lados).
 */
const supabaseUrl = import.meta.env.PUBLIC_SUPABASE_URL;
const supabasePublishableKey = import.meta.env.PUBLIC_SUPABASE_PUBLISHABLE_KEY;

if (!supabaseUrl || !supabasePublishableKey) {
  throw new Error(
    'Faltan las variables de entorno PUBLIC_SUPABASE_URL y/o PUBLIC_SUPABASE_PUBLISHABLE_KEY. ' +
      'Defínelas en el archivo .env de la raíz del proyecto.'
  );
}

export const supabase = createClient(supabaseUrl, supabasePublishableKey);
