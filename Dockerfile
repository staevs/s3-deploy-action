FROM amazon/aws-cli:2.10.0

RUN yum -y install gzip

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
