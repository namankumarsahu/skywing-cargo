# DevFlow injects PORT at runtime (default 3000); this is only a fallback.
ENV PORT=3000
 
# nginx config written inline, so this Dockerfile is the only extra file needed.
# The nginx entrypoint substitutes ${PORT} in this template at container start.
RUN printf '%s\n' \
  'server {' \
  '  listen ${PORT};' \
  '  server_name _;' \
  '  root /usr/share/nginx/html;' \
  '  index index.html;' \
  '  gzip on;' \
  '  gzip_types text/css application/javascript image/svg+xml;' \
  '  location ~ /\. { deny all; }' \
  '  location / { try_files $uri $uri/ /index.html; }' \
  '  location /assets/ { expires 7d; add_header Cache-Control "public"; }' \
  '}' > /etc/nginx/templates/default.conf.template
 
# Site files (only what the site needs, so Dockerfile/README are not served)
COPY index.html styles.css script.js /usr/share/nginx/html/
COPY assets /usr/share/nginx/html/assets
 
EXPOSE 3000
 