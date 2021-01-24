FROM alpine:latest

# set version label
ARG BUILD_DATE
ARG VERSION

RUN \
echo "**** Installing Packages ****" && \
apk add --no-cache curl openssl samba avahi

#RUN \
#mkdir -p /etc/unbound/unbound.conf.d
#RUN \
#printf '%s\n\t' 'server:' '    auto-trust-anchor-file: "/etc/unbound/root.key"' > /etc/unbound/unbound.conf.d/root-auto-trust-anchor-file.conf && \
#ln -s /extra /etc/unbound/extra && \
echo "**** Cleaning up ****" && \
rm -rf /tmp/*


COPY Files/ /

RUN \
echo "**** Setting Cron Job every Day for Sorted Scan ****" && \
echo '1 0 * * * /root/sortscan.sh' >> /var/spool/cron/crontabs/root
# Copying local files, Modify Executables and actualize Data

RUN \
chmod +x /root/start.sh && \
chmod +x /root/sortscan.sh

# ports and volumes
VOLUME /scan /backup
EXPOSE 137 138 139 445

CMD ["/root/start.sh"]
