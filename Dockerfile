FROM amazon/aws-cli:2.9.8

RUN yum -y install gzip

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
