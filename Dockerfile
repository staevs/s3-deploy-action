FROM amazon/aws-cli:2.15.40

RUN yum -y install gzip

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
