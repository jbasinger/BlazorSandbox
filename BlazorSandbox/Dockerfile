FROM mcr.microsoft.com/dotnet/sdk:5.0

#https://andresand.medium.com/android-emulator-on-docker-container-f20c49b129ef

RUN apt-get clean && \ 
    apt-get -y update && \
    curl -sL https://deb.nodesource.com/setup_14.x | sh - && \
    apt-get -y install nodejs && \
    npm install -g cordova

RUN mkdir -p /usr/share/man/man1 #https://stackoverflow.com/questions/58160597/docker-fails-with-sub-process-usr-bin-dpkg-returned-an-error-code-1
RUN apt-get -y install default-jre-headless default-jdk-headless
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/

RUN apt-get -y install android-sdk
ENV ANDROID_HOME=/usr/lib/android-sdk/

RUN wget https://dl.google.com/android/repository/commandlinetools-linux-6609375_latest.zip
RUN unzip commandlinetools-linux-6609375_latest.zip -d cmdline-tools && \
    mv cmdline-tools $ANDROID_HOME &&\
    rm commandlinetools-linux-6609375_latest.zip &&\
    mkdir -p ~/.android && touch ~/.android/repositories.cfg
    
RUN sdkmanager "platforms;android-30" "build-tools;30.0.3" "cmdline-tools;latest" "extras;google;m2repository" "extras;android;m2repository"

ENV PATH="${ANDROID_HOME}/cmdline-tools/tools/bin:${PATH}"