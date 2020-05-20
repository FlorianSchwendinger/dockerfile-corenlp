FROM java:jre-alpine

ENV PREARGS -mx4g
ENV SUBARGS ""
ENV SERVER_PROPERTIES ""

RUN apk add --update --no-cache \
	 unzip \
	 wget

RUN wget http://nlp.stanford.edu/software/stanford-corenlp-4.0.0.zip
RUN unzip stanford-corenlp-4.0.0.zip && rm stanford-corenlp-4.0.0.zip 
RUN [ -d "stanford-corenlp-full-2020-04-20" ] && mv stanford-corenlp-full-2020-04-20 stanford-corenlp-4.0.0

WORKDIR stanford-corenlp-4.0.0

RUN for file in `find . -name "*.jar"`; do export; CLASSPATH="$CLASSPATH:`realpath $file`"; done

ENV PORT 9000

EXPOSE $PORT

CMD printf "${SERVER_PROPERTIES}" > default.properties;printf "\nstartup command:\njava -cp "./*" ${PREARGS} edu.stanford.nlp.pipeline.StanfordCoreNLPServer ${SUBARGS}\n\n";printf "server properties:\n${SERVER_PROPERTIES}\n\n";java -cp "*" ${PREARGS} edu.stanford.nlp.pipeline.StanfordCoreNLPServer ${SUBARGS}
