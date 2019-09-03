############################################
# version : birdben/nginx:v1
# desc : 当前版本安装的nginx
############################################
# 设置继承自我们创建的 tools 镜像
FROM busybox

# 下面是一些创建者的基本信息
MAINTAINER birdben (191654006@163.com)

# 设置环境变量，所有操作都是非交互式的
ENV DEBIAN_FRONTEND noninteractive

COPY run.sh /opt/

# 执行run.sh文件
# CMD ["/run.sh"]
# 执行supervisord来同时执行多个命令，使用 supervisord 的可执行路径启动服务。
CMD /opt/run.sh
