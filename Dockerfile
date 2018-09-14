FROM thenets/parsoid:0.9.0

MAINTAINER loverszhao@gmail.com

COPY run-parsoid.sh /run-parsoid.sh
RUN chmod -v +x /run-parsoid.sh

EXPOSE 8000
CMD ["/run-parsoid.sh"]
