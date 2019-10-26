title: 在colab上用fasttext训练
date: 2019-10-07 09:12:09
tags: [colab, fasttext, 文本分类, NLP]
keywords: colab, fasttext, 文本分类, NLP
description: 如何在colab上用fasttext训练
---

去年折腾BERT的时候，特地租了一台GPU的阿里云服务器，当时Jarvis功能还不够完善，所以最终也是装了个``jupyter notebook``环境，这样远程操作省事点。  
如果对算力要求不是很大，试验性质的，其实直接用``colab``也挺好的。  

因为前面是自己的服务器，所以我把环境的配置全写在``Dockerfile``里面了，这样在``jupyter``里只需要简单的编码就行了，这次用``colab``，就需要自己在notebook里搭环境了，下面简单列一下前几天安装fasttext的流程吧。

### 安装

我们直接从github来安装fasttext吧，记住下载完成以后，还需要编译。

```sh
!git clone https://github.com/facebookresearch/fastText.git
%cd fastText
%mkdir build
%cd build
!cmake ..
!make
!make install
%cd ..
!pip install .
```

这个分别用c++和python安装了。

在colab下，可执行程序需要用!开头，shell命令则需要用%开头。

下面是安装的输出，看起来一切正常。

```
Cloning into 'fastText'...
remote: Enumerating objects: 40, done.
remote: Counting objects: 100% (40/40), done.
remote: Compressing objects: 100% (28/28), done.
remote: Total 3523 (delta 12), reused 26 (delta 8), pack-reused 3483
Receiving objects: 100% (3523/3523), 8.04 MiB | 17.04 MiB/s, done.
Resolving deltas: 100% (2205/2205), done.
/content/fastText/build/fastText/build/fastText
/content/fastText/build/fastText/build/fastText/build
-- The C compiler identification is GNU 7.4.0
-- The CXX compiler identification is GNU 7.4.0
-- Check for working C compiler: /usr/bin/cc
-- Check for working C compiler: /usr/bin/cc -- works
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Detecting C compile features
-- Detecting C compile features - done
-- Check for working CXX compiler: /usr/bin/c++
-- Check for working CXX compiler: /usr/bin/c++ -- works
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Detecting CXX compile features
-- Detecting CXX compile features - done
-- Configuring done
-- Generating done
-- Build files have been written to: /content/fastText/build/fastText/build/fastText/build
Scanning dependencies of target fasttext-static_pic
[  2%] Building CXX object CMakeFiles/fasttext-static_pic.dir/src/args.cc.o
[  4%] Building CXX object CMakeFiles/fasttext-static_pic.dir/src/autotune.cc.o
[  6%] Building CXX object CMakeFiles/fasttext-static_pic.dir/src/densematrix.cc.o
[  8%] Building CXX object CMakeFiles/fasttext-static_pic.dir/src/dictionary.cc.o
[ 10%] Building CXX object CMakeFiles/fasttext-static_pic.dir/src/fasttext.cc.o
[ 12%] Building CXX object CMakeFiles/fasttext-static_pic.dir/src/loss.cc.o
[ 14%] Building CXX object CMakeFiles/fasttext-static_pic.dir/src/main.cc.o
[ 17%] Building CXX object CMakeFiles/fasttext-static_pic.dir/src/matrix.cc.o
[ 19%] Building CXX object CMakeFiles/fasttext-static_pic.dir/src/meter.cc.o
[ 21%] Building CXX object CMakeFiles/fasttext-static_pic.dir/src/model.cc.o
[ 23%] Building CXX object CMakeFiles/fasttext-static_pic.dir/src/productquantizer.cc.o
[ 25%] Building CXX object CMakeFiles/fasttext-static_pic.dir/src/quantmatrix.cc.o
[ 27%] Building CXX object CMakeFiles/fasttext-static_pic.dir/src/utils.cc.o
[ 29%] Building CXX object CMakeFiles/fasttext-static_pic.dir/src/vector.cc.o
[ 31%] Linking CXX static library libfasttext_pic.a
[ 31%] Built target fasttext-static_pic
Scanning dependencies of target fasttext-static
[ 34%] Building CXX object CMakeFiles/fasttext-static.dir/src/args.cc.o
[ 36%] Building CXX object CMakeFiles/fasttext-static.dir/src/autotune.cc.o
[ 38%] Building CXX object CMakeFiles/fasttext-static.dir/src/densematrix.cc.o
[ 40%] Building CXX object CMakeFiles/fasttext-static.dir/src/dictionary.cc.o
[ 42%] Building CXX object CMakeFiles/fasttext-static.dir/src/fasttext.cc.o
[ 44%] Building CXX object CMakeFiles/fasttext-static.dir/src/loss.cc.o
[ 46%] Building CXX object CMakeFiles/fasttext-static.dir/src/main.cc.o
[ 48%] Building CXX object CMakeFiles/fasttext-static.dir/src/matrix.cc.o
[ 51%] Building CXX object CMakeFiles/fasttext-static.dir/src/meter.cc.o
[ 53%] Building CXX object CMakeFiles/fasttext-static.dir/src/model.cc.o
[ 55%] Building CXX object CMakeFiles/fasttext-static.dir/src/productquantizer.cc.o
[ 57%] Building CXX object CMakeFiles/fasttext-static.dir/src/quantmatrix.cc.o
[ 59%] Building CXX object CMakeFiles/fasttext-static.dir/src/utils.cc.o
[ 61%] Building CXX object CMakeFiles/fasttext-static.dir/src/vector.cc.o
[ 63%] Linking CXX static library libfasttext.a
[ 63%] Built target fasttext-static
Scanning dependencies of target fasttext-bin
[ 65%] Building CXX object CMakeFiles/fasttext-bin.dir/src/main.cc.o
[ 68%] Linking CXX executable fasttext
[ 68%] Built target fasttext-bin
Scanning dependencies of target fasttext-shared
[ 70%] Building CXX object CMakeFiles/fasttext-shared.dir/src/args.cc.o
[ 72%] Building CXX object CMakeFiles/fasttext-shared.dir/src/autotune.cc.o
[ 74%] Building CXX object CMakeFiles/fasttext-shared.dir/src/densematrix.cc.o
[ 76%] Building CXX object CMakeFiles/fasttext-shared.dir/src/dictionary.cc.o
[ 78%] Building CXX object CMakeFiles/fasttext-shared.dir/src/fasttext.cc.o
[ 80%] Building CXX object CMakeFiles/fasttext-shared.dir/src/loss.cc.o
[ 82%] Building CXX object CMakeFiles/fasttext-shared.dir/src/main.cc.o
[ 85%] Building CXX object CMakeFiles/fasttext-shared.dir/src/matrix.cc.o
[ 87%] Building CXX object CMakeFiles/fasttext-shared.dir/src/meter.cc.o
[ 89%] Building CXX object CMakeFiles/fasttext-shared.dir/src/model.cc.o
[ 91%] Building CXX object CMakeFiles/fasttext-shared.dir/src/productquantizer.cc.o
[ 93%] Building CXX object CMakeFiles/fasttext-shared.dir/src/quantmatrix.cc.o
[ 95%] Building CXX object CMakeFiles/fasttext-shared.dir/src/utils.cc.o
[ 97%] Building CXX object CMakeFiles/fasttext-shared.dir/src/vector.cc.o
[100%] Linking CXX shared library libfasttext.so
[100%] Built target fasttext-shared
[ 31%] Built target fasttext-static_pic
[ 63%] Built target fasttext-static
[ 68%] Built target fasttext-bin
[100%] Built target fasttext-shared
Install the project...
-- Install configuration: ""
-- Installing: /usr/local/lib/libfasttext.so
-- Installing: /usr/local/lib/libfasttext.a
-- Installing: /usr/local/lib/libfasttext_pic.a
-- Installing: /usr/local/bin/fasttext
-- Installing: /usr/local/include/fasttext/args.h
-- Installing: /usr/local/include/fasttext/autotune.h
-- Installing: /usr/local/include/fasttext/densematrix.h
-- Installing: /usr/local/include/fasttext/dictionary.h
-- Installing: /usr/local/include/fasttext/fasttext.h
-- Installing: /usr/local/include/fasttext/loss.h
-- Installing: /usr/local/include/fasttext/matrix.h
-- Installing: /usr/local/include/fasttext/meter.h
-- Installing: /usr/local/include/fasttext/model.h
-- Installing: /usr/local/include/fasttext/productquantizer.h
-- Installing: /usr/local/include/fasttext/quantmatrix.h
-- Installing: /usr/local/include/fasttext/real.h
-- Installing: /usr/local/include/fasttext/utils.h
-- Installing: /usr/local/include/fasttext/vector.h
/content/fastText/build/fastText/build/fastText
Processing /content/fastText/build/fastText/build/fastText
Requirement already satisfied: pybind11>=2.2 in /usr/local/lib/python3.6/dist-packages (from fasttext==0.9.1) (2.4.2)
Requirement already satisfied: setuptools>=0.7.0 in /usr/local/lib/python3.6/dist-packages (from fasttext==0.9.1) (41.2.0)
Requirement already satisfied: numpy in /usr/local/lib/python3.6/dist-packages (from fasttext==0.9.1) (1.16.5)
Building wheels for collected packages: fasttext
  Building wheel for fasttext (setup.py) ... done
  Created wheel for fasttext: filename=fasttext-0.9.1-cp36-cp36m-linux_x86_64.whl size=2824673 sha256=6393ff136377be637c4590dcb6d302c3341b9e4b5a92dcb005abcf3c63fc5412
  Stored in directory: /tmp/pip-ephem-wheel-cache-rzzpknne/wheels/94/8b/e0/630938be2d5f9e4c18ba9a2ceb0e0237ede3a66199d0527c7b
Successfully built fasttext
Installing collected packages: fasttext
Successfully installed fasttext-0.9.1
```

### 文本分类的例子

textfast安装好以后，可以直接运行里面的文本分类的例子，就是``classification-example.sh``。  
因为当前目录已经在``fastText``里了，所以不需要切换目录，直接运行即可。  
sh文件的运行，也是用!开头即可，不需要输入``sh classification-example.sh``。

```sh
!./classification-example.sh
```

输出如下：

```
--2019-10-06 11:39:30--  https://github.com/le-scientifique/torchDatasets/raw/master/dbpedia_csv.tar.gz
Resolving github.com (github.com)... 192.30.253.113
Connecting to github.com (github.com)|192.30.253.113|:443... connected.
HTTP request sent, awaiting response... 301 Moved Permanently
Location: https://github.com/srhrshr/torchDatasets/raw/master/dbpedia_csv.tar.gz [following]
--2019-10-06 11:39:30--  https://github.com/srhrshr/torchDatasets/raw/master/dbpedia_csv.tar.gz
Reusing existing connection to github.com:443.
HTTP request sent, awaiting response... 302 Found
Location: https://raw.githubusercontent.com/srhrshr/torchDatasets/master/dbpedia_csv.tar.gz [following]
--2019-10-06 11:39:31--  https://raw.githubusercontent.com/srhrshr/torchDatasets/master/dbpedia_csv.tar.gz
Resolving raw.githubusercontent.com (raw.githubusercontent.com)... 151.101.0.133, 151.101.64.133, 151.101.128.133, ...
Connecting to raw.githubusercontent.com (raw.githubusercontent.com)|151.101.0.133|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 68431223 (65M) [application/octet-stream]
Saving to: ‘data/dbpedia_csv.tar.gz’

data/dbpedia_csv.ta 100%[===================>]  65.26M   280MB/s    in 0.2s    

2019-10-06 11:39:32 (280 MB/s) - ‘data/dbpedia_csv.tar.gz’ saved [68431223/68431223]

dbpedia_csv/
dbpedia_csv/test.csv
dbpedia_csv/classes.txt
dbpedia_csv/train.csv
dbpedia_csv/readme.txt
c++ -pthread -std=c++11 -march=native -O3 -funroll-loops -DNDEBUG -c src/args.cc
c++ -pthread -std=c++11 -march=native -O3 -funroll-loops -DNDEBUG -c src/autotune.cc
c++ -pthread -std=c++11 -march=native -O3 -funroll-loops -DNDEBUG -c src/matrix.cc
c++ -pthread -std=c++11 -march=native -O3 -funroll-loops -DNDEBUG -c src/dictionary.cc
c++ -pthread -std=c++11 -march=native -O3 -funroll-loops -DNDEBUG -c src/loss.cc
c++ -pthread -std=c++11 -march=native -O3 -funroll-loops -DNDEBUG -c src/productquantizer.cc
c++ -pthread -std=c++11 -march=native -O3 -funroll-loops -DNDEBUG -c src/densematrix.cc
c++ -pthread -std=c++11 -march=native -O3 -funroll-loops -DNDEBUG -c src/quantmatrix.cc
c++ -pthread -std=c++11 -march=native -O3 -funroll-loops -DNDEBUG -c src/vector.cc
c++ -pthread -std=c++11 -march=native -O3 -funroll-loops -DNDEBUG -c src/model.cc
c++ -pthread -std=c++11 -march=native -O3 -funroll-loops -DNDEBUG -c src/utils.cc
c++ -pthread -std=c++11 -march=native -O3 -funroll-loops -DNDEBUG -c src/meter.cc
c++ -pthread -std=c++11 -march=native -O3 -funroll-loops -DNDEBUG -c src/fasttext.cc
c++ -pthread -std=c++11 -march=native -O3 -funroll-loops -DNDEBUG args.o autotune.o matrix.o dictionary.o loss.o productquantizer.o densematrix.o quantmatrix.o vector.o model.o utils.o meter.o fasttext.o src/main.cc -o fasttext
Read 32M words
Number of words:  803537
Number of labels: 14
Progress: 100.0% words/sec/thread: 1011063 lr:  0.000000 avg.loss:  0.098207 ETA:   0h 0m 0s
N	70000
P@1	0.985
R@1	0.985
```

接下来，我们可以换自己的数据实际的体验一下fasttext的威力了。