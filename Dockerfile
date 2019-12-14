FROM moonbuggy2000/alpine-s6-nginx-php-fpm:php7.3

ARG BUILD=pgsql
ARG TT_DB_TYPE

ENV TT_DB_TYPE=${TT_DB_TYPE}

RUN pgsql_packages=' \
		php7-pdo_pgsql \
		php7-pgsql \
		postgresql-client' \
	&& mysql_packages=' \
		mysql-client \
		php7-mysqli \
		php7-pdo_mysql' \
	&& mkdir -p /etc/tt-rss/ \
	&& if [ ${BUILD} = "pgsql" ]; then \
			echo "Building for PostgreSQL.."; \
			extra_packages="${pgsql_packages}"; \
			echo 'SQL_TYPE="pgsql"' > /etc/tt-rss/sql-type; \
		elif [ ${BUILD} = "mysql" ]; then \
			echo "Building for MySQL.."; \
			extra_packages="${mysql_packages}"; \
			echo 'SQL_TYPE="mysql"' > /etc/tt-rss/sql-type; \
		else \
			echo "Building for PostgreSQL and MySQL.."; \
			extra_packages="${mysql_packages} ${pgsql_packages}"; \
		fi \
	&& apk --no-cache add \
		git \
		php7-curl \
		php7-dom \
		php7-fileinfo \
		php7-gd \
		php7-iconv \
		php7-intl \
		php7-json \
		php7-opcache \
		php7-mbstring \
		php7-pdo \
		php7-session \
		php7-soap \
		php7-xml \
		${extra_packages} \
	&& rm -rf ${WEB_ROOT}/* \
	&& git clone https://git.tt-rss.org/fox/tt-rss.git ${WEB_ROOT}/

COPY ./etc /etc/

VOLUME ${WEB_ROOT}
