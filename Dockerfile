FROM amazon/aws-cli:2.8.9

COPY entrypoint.sh entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
