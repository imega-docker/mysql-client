# mysql-client

This is docker image to run a MySQL client.

[![](https://images.microbadger.com/badges/version/imega/mysql-client.svg)](https://microbadger.com/images/imega/mysql-client "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/imega/mysql-client.svg)](http://microbadger.com/images/imega/mysql-client "Get your own image badge on microbadger.com") [![CircleCI](https://circleci.com/gh/imega-docker/mysql-client.svg?style=svg)](https://circleci.com/gh/imega-docker/mysql-client) [![GitHub stars](https://img.shields.io/github/stars/badges/shields.svg?style=social&label=Star&maxAge=2592000)](https://github.com/imega-docker/mysql-client)

From image: alpine:3.10

## Usage

You make [container with MySQL server](http://imega.club/2015/04/30/docker-image-mysql).

Mysql console

```
$ docker run --rm \
    mysql-client \
    mysql --host=example.com --user=root --password=123321 --database=test --execute='show tables;'
```

```
$ docker run -it -v /path/to/dumps:/data \
    --link mysqlsrv:mysqlsrv \
    imega/mysql-client \
    mysql --host=example.com --user=root --password=123321 --database=mydb --execute='show tables;'
```

If the connection cannot be established, wait and retry instead of aborting.

```
$ docker run --rm \
    --link mysqlsrv:mysqlsrv \
    imega/mysql-client \
    mysqladmin --silent --host=mysqlsrv --wait=5 ping
```

## The MIT License (MIT)

Copyright © 2020 iMega <info@imega.ru>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
