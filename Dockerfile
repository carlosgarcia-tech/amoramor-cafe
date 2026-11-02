# syntax=docker/dockerfile:1

# La imagen corre SSR con @astrojs/node (astro.config activa DOCKER=1 en build).
# Nota: PUBLIC_SUPABASE_* se incrustan en el bundle del navegador en el build;
# el .env del runtime solo controla variables server-side (sesión en middleware).
FROM node:22-alpine AS build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
# Vienen como repo variables en CI (claves publishable, no secrets).
ARG PUBLIC_SUPABASE_URL
ARG PUBLIC_SUPABASE_PUBLISHABLE_KEY
ENV DOCKER=1 PUBLIC_SUPABASE_URL=$PUBLIC_SUPABASE_URL PUBLIC_SUPABASE_PUBLISHABLE_KEY=$PUBLIC_SUPABASE_PUBLISHABLE_KEY
RUN npm run build

FROM node:22-alpine
WORKDIR /app
ENV NODE_ENV=production HOST=0.0.0.0 PORT=4321
COPY package.json ./
COPY --from=build /app/dist ./dist
EXPOSE 4321
CMD ["node", "./dist/server/entry.mjs"]
