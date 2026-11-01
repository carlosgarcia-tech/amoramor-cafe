/*
 Escapa texto de la DB antes de interpolarlo en HTML (anti-XSS).
 Sin esto, `<img src=x onerror=...>` en un nombre de producto ejecuta código
 en el navegador de cada visitante.
*/
export function esc(v) {
	return (v ?? '').replace(/[&<>"]/g, (ch) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[ch]));
}
