FROM iflavoursbv/sbt-openjdk-8-alpine

ENV APP_HOME /home/app
ENV APP_JARS $APP_HOME/jars
ENV APP_NAME boiler-scala
ENV APP_VERSION "0.1"

ADD ./project $APP_HOME/project
ADD ./build.sbt $APP_HOME/build.sbt

WORKDIR $APP_HOME

RUN mkdir $APP_JARS
RUN sbt assemblyPackageDependency
RUN cp "target/scala-2.12/$APP_NAME-assembly-$APP_VERSION-deps.jar" $APP_JARS

ADD . $APP_HOME

RUN sbt assembly
RUN cp "target/scala-2.12/$APP_NAME-assembly-$APP_VERSION.jar" $APP_JARS
RUN sbt clean

CMD java -XX:+UnlockExperimentalVMOptions \
    -XX:+UseCGroupMemoryLimitForHeap \
    -XX:MaxRAMFraction=1 \
    -cp "$APP_JARS/$APP_NAME-assembly-$APP_VERSION.jar:$APP_JARS/$APP_NAME-assembly-$APP_VERSION-deps.jar" \
    App
