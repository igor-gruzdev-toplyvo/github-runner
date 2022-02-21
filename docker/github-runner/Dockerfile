ARG UBUNTU_VERSION

FROM ubuntu:$UBUNTU_VERSION

RUN apt update && apt upgrade -y

RUN apt install curl gpg tar haveged \
    iptables lsb-release git sudo -y

RUN ln -fs /usr/share/zoneinfo/Europe/Kiev /etc/localtime \
    && apt install tzdata -y \
    && dpkg-reconfigure --frontend noninteractive tzdata

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg --yes \ 
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
    https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN apt update && apt install docker-ce-cli docker-ce containerd.io -y

RUN curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose \
    && ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

RUN useradd -m runner -s /bin/bash && usermod -G "sudo,docker" -a runner

RUN printf "\nrunner ALL = NOPASSWD: ALL\n" >> /etc/sudoers

COPY docker-entrypoint.sh /usr/local/bin/

USER runner

ENTRYPOINT [ "/bin/bash" ]

CMD [ "/home/runner/actions-runner/run.sh" ]
