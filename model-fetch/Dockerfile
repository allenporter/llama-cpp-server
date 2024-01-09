FROM busybox:1.36.1

COPY ./model-fetch.sh /cmd/model-fetch.sh
RUN chmod +x /cmd/model-fetch.sh

CMD [ "/cmd/model-fetch.sh" ]
