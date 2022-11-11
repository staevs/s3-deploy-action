FROM amazon/aws-cli:2.8.11

RUN yum -y install gzip

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
