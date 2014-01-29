start the following AWS instance:
```
aic13-team3-group2_Twitter_Small
```
assign the elastic IP ```54.204.29.207``` to the instance ```aic13-team3-group2_Twitter_Small```.

use ssh to access this machine.

 1. type ```mongo```
 2. type ```show dbs```
 3. if there is a database called twitter with about 17gb go to 6.
 4. if not type ```use admin```
 5. type ```db.shutdownServer()```
 6. type ```mongod --setParameter textSearchEnabled=true --dbpath /home/ubuntu/aic13_twitter_sentiment/nodejs/mongodb/ --fork --logpath /home/ubuntu/aic13_twitter_sentiment/nodejs/mongodb/mongodb.log```
 7. now a twitter database should be present.
 8. ```forever aic13_twitter_sentiment/nodejs/collectTwitterData.js start``` 
 

Requires [Apache Maven](http://maven.apache.org) 3.0 or greater, and JDK 6+ in order to run.

 ``` mvn install:install-file -DgroupId=com.aliasi -DartifactId=lingpipe -Dversion=4.1.0 -Dpackaging=jar -DgeneratePom=true -Dfile=lib/lingpipe-4.1.0.jar ```

To build, run

    mvn package

To start the app just run the command.

    mvn appengine:devserver

For deployment, download the appengine-java-sdk. 

    ./appengine-java-sdk-1.8.8/bin/appcfg.sh update <web-app-directory>
