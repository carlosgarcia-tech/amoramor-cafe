/**
 * Escapa los caracteres peligrosos de un texto antes de interpolarlo en HTML.
 * Sin esto, un `<img src=x onerror=…>` guardado como nombre de producto
 * podría ejecutarse en el navegador de cada visitante.
 * @param {string|null|undefined} v Texto crudo proveniente de la base de datos.
 * @returns {string} Texto seguro para insertar en plantillas HTML.
 */
export function esc(v) {
	return (v ?? '').replace(/[&<>"]/g, (ch) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[ch]));
}
