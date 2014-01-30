###deploying
start the following AWS instance in region ```Ireland```:
```
aic13-team3-group2_Twitter_Small
```
astart the following AWS instances:
```
aic13-team3-group2_ActiveMQ
aic13-team3-group2_Twitter_Small
```

assign the elastic IP ```54.246.86.65``` to the instance ```aic13-team3-group2_Twitter_Small```.

 
 

Requires [Apache Maven](http://maven.apache.org) 3.0 or greater, and JDK 6+ in order to run.

 ``` mvn install:install-file -DgroupId=com.aliasi -DartifactId=lingpipe -Dversion=4.1.0 -Dpackaging=jar -DgeneratePom=true -Dfile=lib/lingpipe-4.1.0.jar ```

To build, run

    mvn package

To start the app just run the command.

    mvn appengine:devserver

For deployment, download the appengine-java-sdk. 

    ./appengine-java-sdk-1.8.8/bin/appcfg.sh update <web-app-directory>

Also the deployed version is available at:

    http://twitter-sentiment-aic.appspot.com/

###usage

usage is pretty simple. Type in the search text and add a date range.
Since our tweets are in a very short range (<1day) please insert a range from 2010 to 2014
