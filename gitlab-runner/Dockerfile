FROM gitlab/gitlab-runner:v15.9.1
RUN apt update
RUN curl -fsSL https://get.docker.com -o get-docker.sh
RUN sh get-docker.sh
RUN apt install vim -y
RUN apt install iputils-ping telnet -y
RUN curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash