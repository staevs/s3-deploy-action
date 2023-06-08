FROM amazon/aws-cli:2.11.26

RUN yum -y install gzip

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
