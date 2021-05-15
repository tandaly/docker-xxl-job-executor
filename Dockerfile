FROM rysinal86/xxl-job-executor-sample-springboot:2.2.0
MAINTAINER tandaly <tandaly@qq.com>

ENV TZ=Asia/Shanghai

RUN ln -sf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#先添加163源
RUN tee /etc/apt/sources.list << EOF
    deb http://mirrors.163.com/debian/ jessie main non-ffree contrib
    deb http://mirrirs.163.com/debian/ jessie-updates main non-free contrib
    EOF

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    easy-rsa \
    dnsutils \
    iptables \
    netmask \
    mawk \
    rsync \
    openssl \
    openvpn \
    python-kerberos \
    python-ldap \
    python-paramiko \
    python-requests \
    wget \
    curl \
    inetutils-ping \
    && apt-get clean



COPY bin/* /usr/local/bin/
RUN chmod 744 /usr/local/bin/*.sh && \
    chown root:root /usr/local/bin/*.sh

CMD ["/usr/local/bin/entry.sh"]
