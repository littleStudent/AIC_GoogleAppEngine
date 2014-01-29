App Engine Java SentimentAnalysis

Requires [Apache Maven](http://maven.apache.org) 3.0 or greater, and JDK 6+ in order to run.

 ``` mvn install:install-file -DgroupId=com.aliasi -DartifactId=lingpipe -Dversion=4.1.0 -Dpackaging=jar -DgeneratePom=true -Dfile=lib/lingpipe-4.1.0.jar ```

To build, run

    mvn package

To start the app just run the command.

    mvn appengine:devserver

For deployment, download the appengine-java-sdk. 

    ./appengine-java-sdk-1.8.8/bin/appcfg.sh update <web-app-directory>
