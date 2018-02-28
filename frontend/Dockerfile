FROM node:slim
LABEL maintainer="filipe.kalicki@gmail.com"

# Variables
# ENV NODE_ENV=production
ENV FRONTEND /app

# Create directory & set working
RUN mkdir $FRONTEND
WORKDIR $APPFRONTEND_HOME

# Install brunch.io
RUN npm install -g brunch

# Install node_modules with yarn
ADD package.json yarn.lock $APP_HOME/

# Execute yarn
RUN yarn

# Add everything from current directory to directory in container
ADD . $FRONTEND

# Boot the server
CMD [ "yarn", "start" ]
