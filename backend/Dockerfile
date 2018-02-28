FROM ruby:2.5.0
LABEL maintainer="filipe.kalicki@gmail.com"

# Install extras
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Variables
# ENV RAILS_ENV=production
ENV BACKEND /app

# Create directory & set working
RUN mkdir $BACKEND
WORKDIR $BACKEND

# Copy local machine to container
ADD Gemfile $BACKEND/Gemfile
ADD Gemfile.lock $BACKEND/Gemfile.lock

# Install dependencies
RUN bundle install

# Add everything from current directory to directory in container
ADD . $BACKEND