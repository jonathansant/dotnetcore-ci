FROM microsoft/dotnet:2.1-sdk as build-env

#setup docker
RUN apt-get update
RUN apt-get install apt-transport-https ca-certificates curl gnupg2 bzip2 libfontconfig software-properties-common -y
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
	"deb [arch=amd64] https://download.docker.com/linux/debian \
	$(lsb_release -cs) \
	stable"
RUN apt-get update
RUN apt-get install docker-ce -y
RUN apt-get update && apt-get install -y sudo && rm -rf /var/lib/apt/lists/*

#setup node
ENV NODE_VERSION 9.10.1
ENV NODE_DOWNLOAD_SHA 43242c84ec4c266b986c51fa00c28ad8f3eb7740a9894d39e63a83196ed5b291

RUN curl -SL "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.gz" --output nodejs.tar.gz \
	&& echo "$NODE_DOWNLOAD_SHA nodejs.tar.gz" | sha256sum -c - \
	&& tar -xzf "nodejs.tar.gz" -C /usr/local --strip-components=1 \
	&& rm nodejs.tar.gz \
	&& ln -s /usr/local/bin/node /usr/local/bin/nodejs

RUN npm i -g phantomjs-prebuilt node-sass ts-node --unsafe-perm
RUN npm rebuild node-sass

RUN echo node version: $(node -v)
RUN echo npm version: $(npm -v)
RUN echo docker version: $(docker -v)
