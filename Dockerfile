FROM jenkins/jenkins:lts

### Disable jenkins2 wizard
RUN echo jenkins2 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state
RUN echo jenkins2 > /usr/share/jenkins/ref/jenkins.install.InstallUtil.lastExecVersion

### configure a list of plugins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

# In order to run some commands in the masterside
USER root
RUN apt-get install -y curl python git

USER jenkins