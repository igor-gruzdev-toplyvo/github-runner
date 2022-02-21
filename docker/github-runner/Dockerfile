ARG UBUNTU_VERSION

FROM ubuntu:$UBUNTU_VERSION

VOLUME [ "/var/lib/docker/btrfs" ]

RUN apt update && apt upgrade -y

RUN apt install curl gpg lsb-release iptables haveged git -y

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg --yes \ 
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
    https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN apt update \
    && echo "8" | apt install tzdata \ 
    && apt install docker-ce-cli docker-ce containerd.io -y

RUN curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose \
    && ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

RUN useradd -m runner && usermod -G "sudo,docker" -a runner

RUN printf "\nrunner ALL = NOPASSWD: ALL\n" >> /etc/sudoers
