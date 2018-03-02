FROM node:alpine
LABEL maintainer="filipe.kalicki@gmail.com"

# Variables
# ENV NODE_ENV=production
ENV FRONTEND /app

# Create directory & set working
RUN mkdir $FRONTEND
WORKDIR $FRONTEND

# install serve by zeit
RUN yarn global add serve 
# Start node serveer
CMD ["serve", "-s", ".", "-p", "8080"]
# Tell Docker about the port we'll run on.
EXPOSE 8080

# Install modules
ADD package.json yarn.lock $APP_HOME/

# Add everything from current directory to directory in container
ADD . $FRONTEND

# Run yarn
RUN [ "yarn", "start" ]


