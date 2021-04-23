FROM mcr.microsoft.com/dotnet/sdk:5.0

# https://andresand.medium.com/android-emulator-on-docker-container-f20c49b129ef

# Node and Cordova
RUN apt-get clean && \ 
    apt-get -y update && \
    curl -sL https://deb.nodesource.com/setup_14.x | sh - && \
    apt-get -y install nodejs && \
    npm install -g cordova

# Java
RUN mkdir -p /usr/share/man/man1 # https://stackoverflow.com/questions/58160597/docker-fails-with-sub-process-usr-bin-dpkg-returned-an-error-code-1
RUN wget https://download.java.net/openjdk/jdk8u41/ri/openjdk-8u41-b04-linux-x64-14_jan_2020.tar.gz && \
    mkdir -p /usr/lib/jvm && \
    tar -xvzf openjdk-8u41-b04-linux-x64-14_jan_2020.tar.gz -C /usr/lib/jvm && \
    rm openjdk-8u41-b04-linux-x64-14_jan_2020.tar.gz

ENV JAVA_HOME=/usr/lib/jvm/java-se-8u41-ri
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# Android
RUN apt-get -y install android-sdk
ENV ANDROID_HOME=/usr/lib/android-sdk

RUN wget https://dl.google.com/android/repository/commandlinetools-linux-6609375_latest.zip
RUN unzip commandlinetools-linux-6609375_latest.zip -d cmdline-tools && \
    mv cmdline-tools $ANDROID_HOME &&\
    rm commandlinetools-linux-6609375_latest.zip &&\
    mkdir -p ~/.android && touch ~/.android/repositories.cfg

ENV PATH="${ANDROID_HOME}/cmdline-tools/tools/bin:${PATH}"
    
RUN yes | sdkmanager --no_https "platforms;android-29" "build-tools;30.0.3" "platform-tools" "cmdline-tools;latest" "extras;google;m2repository" "extras;android;m2repository"
RUN cp /etc/ssl/certs/java/cacerts /usr/lib/jvm/java-se-8u41-ri/jre/lib/security/
ENV ANDROID_SDK_ROOT=/usr/lib/android-sdk

# Gradle, I guess?

#RUN wget https://services.gradle.org/distributions/gradle-6.5-all.zip && \
#    unzip gradle-6.5-all.zip && \
#    mv gradle-6.5 /usr/lib/ && \
#    rm gradle-6.5-all.zip
#
#ENV PATH="/usr/lib/gradle-6.5/bin/:${PATH}"
#ENV GRADLE_HOME=/usr/lib/gradle-6.5/bin
#ENV GRADLE_USER_HOME=$GRADLE_HOME

# This is really dumb. For some reason cordova completely ignores any valid
# install of Gradle so I'm turning telemetry off, then creating and deleteing
# a project so it'll download the Gradle daemon and won't have to next time.
# Leaving the gradle install stuff commented out above in case it changes.
RUN cordova telemetry off
RUN cordova create dumb com.thisisreally.dumb dumb && \
    cd dumb && \
    cordova platform add android && \
    cordova compile && \
    cd / && \
    rm -rf dumb