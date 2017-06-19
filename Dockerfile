FROM debian:stretch

RUN apt-get -y update \
 && apt-get -y install \
		android-sdk \
		android-sdk-platform-23 \
		git \
		gradle \
		lib32gcc1 \
		lib32ncurses5 \
		lib32z1 \
		libarchive-tools \
		libc6-i386 \
		libgradle-android-plugin-java \
		maven \
		sudo \
		tree \
		wget \
 && wget -q --show-progress -O /tmp/android-sdk-helper.deb http://cdn-fastly.deb.debian.org/debian/pool/main/a/android-sdk-helper/android-sdk-helper_0.1_all.deb \
 && dpkg -i /tmp/android-sdk-helper.deb \
 && rm /tmp/android-sdk-helper.deb \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp/

# install android support constraint library 1.0.2
RUN mkdir -p /usr/lib/android-sdk/extras/android /usr/lib/android-sdk/licenses
ADD m2repository.tar.xz /usr/lib/android-sdk/extras/

# install android support repositovery 47
RUN wget -q --show-progress https://dl-ssl.google.com/android/repository/android_m2repository_r47.zip \
 && bsdtar xf android_m2repository_r47.zip m2repository/NOTICE.txt m2repository/source.properties m2repository/com/android/databinding */23.4.0 */multidex* \
 && rm -f android_m2repository_r47.zip \
 && mv m2repository /usr/lib/android-sdk/extras/android/
 
ENV ANDROID_HOME /usr/lib/android-sdk/
ENV ANDROID_SDK  /usr/lib/android-sdk/

WORKDIR /usr/lib/android-sdk/licenses
ADD android-sdk-license ./
ADD android-sdk-preview-license ./

RUN useradd -m -d /home/user user \
 && echo 'user ALL=(ALL) NOPASSWD: ALL' >/etc/sudoers.d/user
USER user
ENV HOME=/home/user
WORKDIR /home/user
RUN mkdir -p .m2 && echo '<settings><localRepository>/usr/share/maven-repo</localRepository></settings>' >.m2/settings.xml

CMD ["/bin/bash"]
