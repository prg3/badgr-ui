FROM node:8.11.2-alpine as node

RUN apk update && \
	apk add git

RUN git clone https://github.com/concentricsky/badgr-ui.git /badgr-ui && \
	cd /badgr-ui && \
	git checkout release/bob

COPY environment.prod.ts /badgr-ui/src/environments

RUN	cd /badgr-ui && \
	npm install && \
	npm run build 

RUN ls -l /badgr-ui

# Stage 2
FROM nginx:1.13.12-alpine

COPY --from=node /badgr-ui/dist /usr/share/nginx/html
