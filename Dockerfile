FROM microsoft/dotnet:2.1-sdk as build-env

#setup node
ENV NODE_VERSION 10.10.0
ENV NODE_DOWNLOAD_SHA 789994b9ad5d2b274e949c268480a197d2af8861cb00911fc1d2ce4a01631e0d

RUN curl -SL "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.gz" --output nodejs.tar.gz \
	&& echo "$NODE_DOWNLOAD_SHA nodejs.tar.gz" | sha256sum -c - \
	&& tar -xzf "nodejs.tar.gz" -C /usr/local --strip-components=1 \
	&& rm nodejs.tar.gz \
	&& ln -s /usr/local/bin/node /usr/local/bin/nodejs

RUN npm i -g node-sass ts-node --unsafe-perm
RUN npm rebuild node-sass

RUN echo node version: $(node -v)
RUN echo npm version: $(npm -v)