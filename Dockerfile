FROM java:jre-alpine

ENV PREARGS -mx4g
ENV SUBARGS ""
ENV SERVER_PROPERTIES ""

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

CMD echo > SERVER_PROPERTIES;java -cp "*" ${PREARGS} edu.stanford.nlp.pipeline.StanfordCoreNLPServer -serverProperties default.properties ${SUBARGS}
