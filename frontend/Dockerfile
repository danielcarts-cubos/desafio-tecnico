# FROM nginx:1.25.4-alpine3.18
FROM nginx@sha256:cb0953165f59b5cf2227ae979a49a2284956d997fad4ed7a338eebc6aef3e70b

LABEL maintainer="dcsouza@dcc.ufrj.br"

COPY index.html /usr/share/nginx/html/index.html
COPY web.conf /etc/nginx/conf.d/