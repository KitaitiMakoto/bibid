FROM ruby:2.5
LABEL maintainer="https://gitlab.com/KitaitiMakoto"
ENV RACK_ENV production
EXPOSE 3000
COPY . /bibid
COPY ./config/apps.sample.rb /bibid/config/apps.rb
WORKDIR /bibid
RUN wget https://deb.nodesource.com/setup_10.x && \
    bash setup_10.x && \
    rm setup_10.x && \
    apt install -y nodejs && \
    npm install -g bower && \
    bower --allow-root install && \
		bundle install --path=deps && \
    bundle exec rake assets lib:bower:bibi_preset
ENTRYPOINT ["bundle", "exec"]
CMD ["padrino", "start", "--host", "0.0.0.0"]
