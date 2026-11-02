// La única lib con lógica que toca contenido de usuarios: si esc() deja pasar
// un <, la secciones públicas dejan inyectar HTML en cada visitante.
import { test } from 'node:test';
import assert from 'node:assert/strict';
import { esc } from '../src/lib/esc.js';

test('escapa & < > y comillas', () => {
	assert.equal(esc(`<img src=x onerror="alert(1)">`), '&lt;img src=x onerror=&quot;alert(1)&quot;&gt;');
	assert.equal(esc('tortilla & nutella'), 'tortilla &amp; nutella');
});

test('null/undefined se vuelven cadena vacía', () => {
	assert.equal(esc(null), '');
	assert.equal(esc(undefined), '');
});

test('los valores sanos no se tocan', () => {
	assert.equal(esc('Café Amor — $125'), 'Café Amor — $125');
});
