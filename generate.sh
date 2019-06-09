docker build -t blog.heyalgo .

mkdir ./public
docker run --rm \
  -v $PWD/public:/home/blog.heyalgo/public \
  blog.heyalgo hexo generate