FROM java:jre-alpine

ENV PREARGS -mx4g
ENV SUBARGS ""
ENV SERVER_PROPERTIES ""

RUN apk add --update --no-cache \
	 unzip \
	 wget

RUN wget http://nlp.stanford.edu/software/stanford-corenlp-4.0.0.zip
RUN unzip stanford-corenlp-4.0.0.zip && \
	rm stanford-corenlp-4.0.0.zip

WORKDIR stanford-corenlp-4.0.0

RUN export CLASSPATH="`find . -name '*.jar'`"

ENV PORT 9000

EXPOSE $PORT

CMD printf "${SERVER_PROPERTIES}" > default.properties;printf "\nstartup command:\njava -cp "*" ${PREARGS} edu.stanford.nlp.pipeline.StanfordCoreNLPServer ${SUBARGS}\n\n";printf "server properties:\n${SERVER_PROPERTIES}\n\n";java -cp "*" ${PREARGS} edu.stanford.nlp.pipeline.StanfordCoreNLPServer ${SUBARGS}
