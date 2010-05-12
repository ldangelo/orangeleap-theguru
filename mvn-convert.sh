rm -rf src/main
rm -rf src/test
mkdir src/main
mkdir src/test
mkdir src/main/resources
mkdir src/main/config
mkdir src/main/java
mkdir src/main/webapp
mkdir src/test/resources
mkdir src/test/java
mkdir src/test/config
mkdir src/main/config/jetty-local
mkdir db-scripts/src
mkdir db-scripts/src/main
mkdir db-scripts/src/main/resources
cp war/WEB-INF/classes/ws-securityPolicy.xml src/main/resources
cp theguru.properties src/main/config/jetty-local/
cp theguru.properties src/test/resources
cp -R src/com src/main/java/com
cp -R test/com src/test/java/com
cp -R war/* src/main/webapp
cp -R config/mpx src/main/config
#cp src/META-INF/persistence-container.xml src/main/resources/persistence.xml
sed -e "s/@@DIALECT@@/org.hibernate.dialect.MySQLInnoDBDialect/g" src/META-INF/persistence-container.xml > src/main/resources/persistence.xml
#cp src/META-INF/persistence-container.xml src/main/config/mpx/persistence.xml 
sed -e "s/@@DIALECT@@/org.hibernate.dialect.SQLServerDialect/g" src/META-INF/persistence-container.xml > src/main/config/mpx/persistence.xml
#cp -R config/* src/main/resources
cp config/jasperreport.dtd src/main/resources
cp -R db db-scripts/src/main/resources
cp test/applicationContext.xml src/test/resources
cp test/testng.xml src/test/resources
cp test/META-INF/persistence.xml src/test/resources
