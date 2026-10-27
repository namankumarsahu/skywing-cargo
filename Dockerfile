FROM nginx:1.27-alpine

# DevFlow injects PORT (default 3000) at runtime; this is only a fallback.
ENV PORT=3000

# nginx's entrypoint runs envsubst on /etc/nginx/templates/*.template at startup,
# so the listen port follows $PORT.
COPY nginx.conf.template /etc/nginx/templates/default.conf.template

# Site files
COPY index.html styles.css script.js /usr/share/nginx/html/
COPY assets /usr/share/nginx/html/assets

EXPOSE 3000
