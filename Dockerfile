ARG EBX_VERSION
#ARG EBX_ADDONS_VERSION

FROM mickaelgermemont/ebx:${EBX_VERSION} as EbxRelease
#FROM mickaelgermemont/ebx-addons:${EBX_ADDONS_VERSION} as EbxAddonsRelease

FROM tomcat:9.0.12-jre11
ARG EBX_VERSION

ENV EBX_HOME /data/app/ebx
RUN mkdir -p ${EBX_HOME}

WORKDIR $CATALINA_HOME

RUN keytool -genkey -noprompt \
 -alias tomcat \
 -keyalg RSA \
 -dname "CN=helloworld, OU=ID, O=ON, L=OAuthSample, S=WithTomcat, C=US" \
 -keystore $CATALINA_HOME/.keystore \
 -storepass "ebx tomcat password" \
 -keypass "ebx tomcat password"

COPY tomcat_conf/context.xml ${CATALINA_HOME}/conf/
COPY tomcat_conf/logging.properties ${CATALINA_HOME}/conf/
COPY tomcat_conf/server.xml $CATALINA_HOME/conf/
COPY tomcat_conf/catalina.properties $CATALINA_HOME/conf/

COPY tomcat_conf/context/ebx.xml ${CATALINA_HOME}/conf/Catalina/localhost/

COPY --from=EbxRelease /data/ebx/libs/*.jar $CATALINA_HOME/lib/
COPY --from=EbxRelease /data/ebx/ebx.software/lib/*.jar $CATALINA_HOME/lib/
COPY --from=EbxRelease /data/ebx/ebx.software/lib/lib-h2/*.jar $CATALINA_HOME/lib/
COPY --from=EbxRelease /data/ebx/ebx.software/webapps/wars-packaging/*.war $CATALINA_HOME/webapps/

#COPY --from=EbxAddonsRelease /data/ebx/lib/ebx-addons.jar $CATALINA_HOME/lib/
#COPY --from=EbxAddonsRelease /data/ebx/wars/ebx-addon-common.war $CATALINA_HOME/webapps/
#COPY --from=EbxAddonsRelease /data/ebx/wars/ebx-addon-adix.war $CATALINA_HOME/webapps/

###
### PROJECT

ENV EBX_OPTS="-Debx.home=${EBX_HOME} -Debx.properties=/data/app/ebx.properties"

COPY app/target/deps/*.jar $CATALINA_HOME/lib/
COPY ebx-training.war $CATALINA_HOME/webapps/

COPY ebx.properties /data/app/ebx.properties

###
### startup parameters

ENV JAVA_OPTS="${EBX_OPTS} ${JAVA_OPTS}"
ENV CATALINA_OPTS ""

###
### SECURITY

RUN groupadd -g 1000 user \
   && useradd -u 1000 -g 1000 -m -s /bin/bash user \
   && chown -R 1000 /data /usr/local/tomcat
USER user

VOLUME ["/data/app/ebx"]

EXPOSE 8080
CMD ["catalina.sh", "run"]
