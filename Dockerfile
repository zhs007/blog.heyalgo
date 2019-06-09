FROM node:latest

RUN npm i hexo-cli -g

COPY ./package*.json /home/blog.heyalgo/

RUN cd /home/blog.heyalgo \
    && npm i -d

COPY . /home/blog.heyalgo

WORKDIR /home/blog.heyalgo

CMD ["hexo", "server"]