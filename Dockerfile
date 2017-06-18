FROM debian:stretch

RUN apt-get -y update \
 && apt-get -y install \
		android-sdk \
		git \
		gradle \
		libarchive-tools \
		sudo \
		tree \
 && rm -rf /var/lib/apt/lists/*

ADD m2repository.tar.xz /tmp/
RUN mkdir -p /usr/lib/android-sdk/{extras,licenses} \
 && mv /tmp/m2repository /usr/lib/android-sdk/extras
ENV ANDROID_HOME=/usr/lib/android-sdk/

WORKDIR /usr/lib/android-sdk/licenses
ADD android-sdk-license ./
ADD android-sdk-preview-license ./

RUN useradd -m -d /home/user user \
 && echo 'user ALL=(ALL) NOPASSWD: ALL' >/etc/sudoers.d/user
USER user
ENV HOME=/home/user
WORKDIR /home/user

CMD ["/bin/bash"]
