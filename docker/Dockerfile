# 指明制作当前镜像将基于的基础镜像
FROM alpine:3.18.2

# 指明制作当前镜像将基于的基础镜像
MAINTAINER sunsky "15872360904@163.com"

# 指定容器运行时的默认工作目录(没有会自动创建)，不指定则会使用FROM基础镜像指定的默认工作目录
WORKDIR /usr/local

# 从镜像构建上下文目录里添加需要的文件到容器镜像的指定目录(这里使用了与WORKDIR相同的目录，但不是必须这样)，
# 添加分ADD和COPY两种，ADD会复制并解压(这里添加的文件将影响镜像的大小，多文件COPY目的目录要以/结尾)
ADD openjdk-17+35_linux-x64_bin.tar.gz /usr/local
# COPY jdk-8 /usr/local/jdk-8
COPY glibc* /usr/local/

# 更换安装过程中的工具包下载源(否则下载后面的工具会非常的慢)
RUN echo http://mirrors.aliyun.com/alpine/v3.18/main/ > /etc/apk/repositories \
	&& echo http://mirrors.aliyun.com/alpine/v3.18/community/ >> /etc/apk/repositories \
	&& apk update && apk upgrade

# 安装必要工具、下载alpine-pkgs.sgerrand公钥、安装必要的依赖
# Alpine linux为了精简本身并没有安装太多的常用软件,apk类似于ubuntu的apt-get，
# 用来安装一些常用软V件，其语法如下：apk add bash wget curl git make vim docker
# wget是linux下的ftp/http传输工具，没安装会报错“/bin/sh:  wget: not found” 
# ca-certificates证书服务，是安装glibc前置依赖
# 清理缓存和容器镜像里不再要的包，保留JDK解压目录即可(没指定明确路径的都是相对于容器运行时的默认工作目录)
# 设置时区(和普通操作系统一样需要对齐服务器时区，跑在上面的应用拿到的时间才不会乱)

RUN apk --no-cache add ca-certificates wget \
	&& wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
	&& apk add glibc-2.35-r1.apk glibc-bin-2.35-r1.apk glibc-i18n-2.35-r1.apk \
	&& rm -rf /var/cache/apk/* glibc-2.35-r1.apk glibc-bin-2.35-r1.apk glibc-i18n-2.35-r1.apk \
	&& ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone

# 配置环境变量
ENV JAVA_HOME=/usr/local/jdk-17
# ENV JAVA_HOME=/usr/local/java-se-8u43-ri
ENV CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV PATH=$JAVA_HOME/bin:$PATH


# COPY spring.jar /tmp/app.jar

# EXPOSE 80

CMD ["java","-version"]

# ENTRYPOINT java -jar /tmp/app.jar

