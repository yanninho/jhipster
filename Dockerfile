FROM yanninho/devweb 

MAINTAINER	Yannick Saint Martino 

# install JHipster
RUN npm install -g generator-jhipster@1.2.2

# configure the "jhipster" users
RUN groupadd jhipster && useradd jhipster -s /bin/bash -m -g jhipster -G jhipster && adduser jhipster sudo
RUN echo 'jhipster:jhipster' |chpasswd

# install the sample app to download all Maven dependencies
RUN cd /home/jhipster && \
    wget https://github.com/jhipster/jhipster-sample-app/archive/v1.2.2.zip && \
    unzip v1.2.2.zip && \
    rm v1.2.2.zip
RUN cd /home/jhipster/jhipster-sample-app-1.2.2 && npm install
RUN cd /home && chown -R jhipster:jhipster /home/jhipster
RUN cd /home/jhipster/jhipster-sample-app-1.2.2 && sudo -u jhipster mvn dependency:go-offline

# expose the working directory, the Tomcat port, the Grunt server port 
VOLUME ["/jhipster"]
EXPOSE 8080
EXPOSE 9000


