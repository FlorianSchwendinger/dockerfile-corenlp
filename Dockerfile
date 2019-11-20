FROM java:jre-alpine

ENV MEMORY 4g
ENV PORT 9000
ENV STATUS_PORT 9000
ENV TIMEOUT TODO
ENV QUIET TODO
ENV SSL TODO
ENV KEY TODO
ENV USERNAME  TODO
ENV PASSWORD TODO
ENV ANNOTATORS TODO
ENV PRELOAD TODO
ENV SERVER_PROPERTIES TODO

RUN apk add --update --no-cache \
	 unzip \
	 wget

RUN wget http://nlp.stanford.edu/software/stanford-corenlp-full-2018-10-05.zip
RUN unzip stanford-corenlp-full-2018-10-05.zip && \
	rm stanford-corenlp-full-2018-10-05.zip

WORKDIR stanford-corenlp-full-2018-10-05

RUN export CLASSPATH="`find . -name '*.jar'`"

ENV PORT 9000

EXPOSE $PORT

CMD java -cp "*" -mx${MEMORY} edu.stanford.nlp.pipeline.StanfordCoreNLPServer
