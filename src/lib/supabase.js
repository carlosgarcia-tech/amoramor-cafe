import { createClient } from "@supabase/supabase-js";

const supabaseUrl = import.meta.env.PUBLIC_SUPABASE_URL;
const supabasePublishableKey = import.meta.env.PUBLIC_SUPABASE_PUBLISHABLE_KEY;

if (!supabaseUrl || !supabasePublishableKey) {
  throw new Error(
    "Faltan las variables de entorno PUBLIC_SUPABASE_URL y/o PUBLIC_SUPABASE_PUBLISHABLE_KEY. " +
      "Defínelas en el archivo .env de la raíz del proyecto.",
  );
}

export const supabase = createClient(supabaseUrl, supabasePublishableKey);
