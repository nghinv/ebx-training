# ebx-training

works with ebx5.7.1 & tomcat9 & jre11

EBX Module builds with Maven

## requirement

have maven and be able to run mvn commands

## maven build commands

when i build i use jdk8

```
cd app && mvn clean install && cd .. && cp app/target/ebx-training-0.1.war ebx-training.war
```

## Docker build

```
docker build --build-arg EBX_VERSION=5.7.1.1034-0058 -t ebx-training:0.1-ebx5.7.1-tomcat9.0.12-jre11 .
```

## Docker run

```
put your ebxLicense in ~/.profile
export EBXLICENSE=XXXXX-XXXXX-XXXXX-XXXXX
source ~/.profile

docker run --rm -p 9090:8080 --mount type=volume,src=ebx571,dst=/data/app/ebx -e "CATALINA_OPTS=-DebxLicense=$EBXLICENSE" --name ebx1 ebx-training:0.1-ebx5.7.1-tomcat9.0.12-jre11
```

```open http://localhost:9090/ebx```

```
cd app && mvn clean install && cd .. && cp app/target/ebx-training-0.1.war ebx-training.war \
&& docker build --build-arg EBX_VERSION=5.7.1.1034-0058 -t ebx-training:0.1-ebx5.7.1-tomcat9.0.12-jre11 . \
&& docker run --rm -p 9090:8080 --mount type=volume,src=ebx571,dst=/data/app/ebx -e "CATALINA_OPTS=-DebxLicense=$EBXLICENSE" --name ebx1 ebx-training:0.1-ebx5.7.1-tomcat9.0.12-jre11
```

## connect to running container

```
docker exec -it ebx1 /bin/bash
```

## export docker files

```
docker cp ebx1:/data/app/ebx/ebxLog ebxLog/
docker cp ebx1:/usr/local/tomcat/lib/ebx.jar .
```
