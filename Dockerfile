FROM mikygus/base-ubuntu:1.1

USER root

RUN apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -qq \
		cron \
		curl \
	&& chmod o+w /etc/environment \
	&& echo root > /etc/cron.d/cron.allow \
	&& echo non-priv >> /etc/cron.d/cron.allow \
	&& chmod u+s /usr/sbin/cron \
	&& mkdir -m 700 /opt/duckdns \
	&& chown non-priv /opt/duckdns
WORKDIR /opt/duckdns
COPY duck.sh entrypoint.sh .
RUN touch duckdns.log \
	&& chown non-priv duckdns.log duck.sh entrypoint.sh \
	&& chmod 600 duckdns.log \
	&& chmod 500 duck.sh entrypoint.sh

USER non-priv
ENTRYPOINT ["./entrypoint.sh"]
