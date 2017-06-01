FROM openjdk:8-jre
MAINTAINER Welbster Oliveira <welbsterhansi@gmail.com>


RUN apt-get update && apt-get install vim wget -y
RUN echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" >> /etc/apt/source.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367 && apt-get update
RUN apt-get install ansible -y

RUN echo '[local]\n127.0.0.1' > /etc/ansible/hosts
ADD ./tomcat /etc/ansible/roles/tomcat
RUN ansible-playbook -c local /etc/ansible/roles/tomcat/site.yml

ENV CATALINA_HOME /opt/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH

EXPOSE 8080
CMD ["catalina.sh", "run"]
