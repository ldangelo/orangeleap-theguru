(jde-project-file-version "1.0")
(jde-set-variables
 ;; Set here default parameter for make program
 ;; '(jde-make-args "jar")
 ;; What should be put as java file header
 '(jde-gen-buffer-boilerplate
   (quote
    ("/*"
     " * Clementine - opensource reporting wizard"
     " * http://www.orangeleap.com "
     " * (C) 2009, Orange Leap"
     " *"
     " * This library is free software; you can redistribute it and/or"
     " * modify it under the terms of the GNU Lesser General Public"
     " * License as published by the Free Software Foundation;"
     " * version 2.1 of the License."
     " *"
     " * This library is distributed in the hope that it will be useful,"
     " * but WITHOUT ANY WARRANTY; without even the implied warranty of"
     " * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU"
     " * Lesser General Public License for more details."
     " *"
     " */")))
 ;; Sometimes JDEE prints useful messages, but if everything works well
 ;; you will be not using this.
 '(jde-log-max 5000)
 ;; Must be on to improve your coding: you write: "if " and JDEE generates
 ;; templeate code for "if" statement.
 '(jde-enable-abbrev-mode t)
 ;; set the debug port for connecting to tomcat
 '(jde-db-option-connect-socket (quote (nil "8000")))

 ;; Path to source files for automatic loading
 '(jde-sourcepath
   (quote
    (
     "~/Development/Clementine/src/"
     "/Users/ldangelo/Development/Clementine/lib/war/source/DynamicJasper-2.1.0-sources.jar"
     )))
 ;; Classpath for browsing files and generates code templates
 '(jde-global-classpath
   (quote
    (
     "~/Development/Clementine/src/"
     "~/Development/Clementine/lib/war/bin/DynamicJasper-2.1.0.jar"
    "~/Development/Clementine/lib/war/bin/activateion.jar"
    "~/Development/Clementine/lib/war/bin/antlr-2.7.6.jar"
    "~/Development/Clementine/lib/war/bin/antlr-runtime.jar"
    "~/Development/Clementine/lib/war/bin/asm-attrs.jar"
    "~/Development/Clementine/lib/war/bin/asm.jar"
    "~/Development/Clementine/lib/war/bin/aspectjweaver.jar"
    "~/Development/Clementine/lib/war/bin/cglib-2.1.3.jar"
    "~/Development/Clementine/lib/war/bin/cglib-nodep-2.2.jar"
    "~/Development/Clementine/lib/war/bin/commons-beanutils-1.7.jar"
    "~/Development/Clementine/lib/war/bin/commons-codec.jar"
    "~/Development/Clementine/lib/war/bin/commons-collections.jar"
    "~/Development/Clementine/lib/war/bin/commons-digester-1.8.jar"
    "~/Development/Clementine/lib/war/bin/commons-httpclient.jar"
    "~/Development/Clementine/lib/war/bin/commons-io-1.2.jar"
    "~/Development/Clementine/lib/war/bin/commons-lang-2.3.jar"
    "~/Development/Clementine/lib/war/bin/commons-logging.jar"
    "~/Development/Clementine/lib/war/bin/commons-math-1.1.jar"
    "~/Development/Clementine/lib/war/bin/commons-validator-1.3.0.jar"
    "~/Development/Clementine/lib/war/bin/dom4j-1.6.1.jar"
    "~/Development/Clementine/lib/war/bin/drools-compiler.jar"
    "~/Development/Clementine/lib/war/bin/drools-core.jar"
    "~/Development/Clementine/lib/war/bin/dwr.jar"
    "~/Development/Clementine/lib/war/bin/ejb3-persistence.jar"
    "~/Development/Clementine/lib/war/bin/hibernate-annotations.jar"
    "~/Development/Clementine/lib/war/bin/hibernate-commons-annotations.jar"
    "~/Development/Clementine/lib/war/bin/hibernate-entitymanager.jar"
    "~/Development/Clementine/lib/war/bin/hibernate3.jar"
    "~/Development/Clementine/lib/war/bin/jasperreports-3.0.0.jar"
    "~/Development/Clementine/lib/war/bin/jasperserver-common-ws-3.0.0.jar"
    "~/Development/Clementine/lib/war/bin/jasperserver-ireport-plugin-3.0.0.jar"
    "~/Development/Clementine/lib/war/bin/javassist.jar"
    "~/Development/Clementine/lib/war/bin/jboss-archive-browsing.jar"
    "~/Development/Clementine/lib/war/bin/jfreechart-1.0.0.jar"
    "~/Development/Clementine/lib/war/bin/jstl.jar"
    "~/Development/Clementine/lib/war/bin/log4j-1.2.15.jar"
    "~/Development/Clementine/lib/war/bin/mail.jar"
    "~/Development/Clementine/lib/war/bin/mvel14.jar"
    "~/Development/Clementine/lib/war/bin/quartz-all-1.6.1-RC1.jar"
    "~/Development/Clementine/lib/war/bin/slf4j-api-1.5.0.jar"
    "~/Development/Clementine/lib/war/bin/slf4j-log4j`2-1.5.0.jar"
    "~/Development/Clementine/lib/war/bin/spring-ldap-1.2.1.jar"
    "~/Development/Clementine/lib/war/bin/spring-security-acl-2.0.3.jar"
    "~/Development/Clementine/lib/war/bin/spring-security-core-2.0.3.jar"
    "~/Development/Clementine/lib/war/bin/spring-security-core-tiger-2.0.3.jar"
    "~/Development/Clementine/lib/war/bin/spring-security-taglibs-2.0.3.jar"
    "~/Development/Clementine/lib/war/bin/spring-webmvc.jar"
    "~/Development/Clementine/lib/war/bin/spring.jar"
    "~/Development/Clementine/lib/war/bin/standard.jar"
    "~/Development/Clementine/lib/war/bin/tiles-api-2.0.5.jar"
    "~/Development/Clementine/lib/war/bin/tiles-core-2.0.5.jar"
    "~/Development/Clementine/lib/war/bin/tiles-jsp-2.0.5.jar"
    "/usr/local/tomcat/webapps/clementine/WEB-INF/lib/clementine.jar"
     "$JAVA_HOME/../Classes/classes.jar"
     "/usr/local/tomcat/lib/annotations-api.jar"
     "/usr/local/tomcat/lib/catalina-ant.jar"
     "/usr/local/tomcat/lib/catalina-ha.jar"
     "/usr/local/tomcat/lib/catalina-tribes.jar"
     "/usr/local/tomcat/lib/catalina.jar"
     "/usr/local/tomcat/lib/el-api.jar"
     "/usr/local/tomcat/lib/jasper-el.jar"
     "/usr/local/tomcat/lib/jasper-jdt.jar"
     "/usr/local/tomcat/lib/jasper.jar"
     "/usr/local/tomcat/lib/jsf-api.jar"
     "/usr/local/tomcat/lib/jsf-impl.jar"
     "/usr/local/tomcat/lib/jsp-api.jar"
     "/usr/local/tomcat/lib/jta.jar"
     "/usr/local/tomcat/lib/log4j-1.2.15.jar"
     "/usr/local/tomcat/lib/mysql-connector-ava-5.0.8-bin.jar"
     "/usr/local/tomcat/lib/servlet-api.jar"
     "/usr/local/tomcat/lib/sqljdbc.jar"
     "/usr/local/tomcat/lib/tomcat-coyote.jar"
     "/usr/local/tomcat/lib/tomcat-dbcp.jar"
     )))

 '(bsh-classpath
   (quote
    (
     "~/Development/Clementine/src/"
     "~/Development/Clementine/build/stage/clementine.jar"
     "~/Development/Clementine/lib/war/bin/DynamicJasper-2.1.0.jar"
     "~/Development/Clementine/lib/war/bin/jasperserver-ireport-plugin-3.0.0.jar"
     )))

 ;; If you want to run Java apps from within emacs for example for debuging
 ;; set default startup class for your project.
;; '(jde-run-application-class "org.geotools.vpf.VPFDataBase")
 '(jde-run-working-directory "/Users/ldangelo/Development/Clementine")

 ;; Set name for your make program: ant or maybe maven?
 '(jde-build-function (quote (jde-ant-build)))

;;'(jde-ant-buildfile "/Users/ldangelo/Development/Clementine/build/build.xml")

 ;; For javadoc templates version tag can be customized
 '(jde-javadoc-version-tag-template "\"* @version $Id: prj.el,v 1.4 2003/04/23 14:28:25 kobit Exp $\"")

 ;; Defines bracket placement style - now it is set according to SUN standards
 '(jde-gen-k&r t)

 ;; Do you prefer to have java.io.* imports or separate import for each
 ;; used class - now it is set for importing classes separately
 '(jde-import-auto-collapse-imports nil)

 ;; You can define many JDKs and choose one for each project
 '(jde-compile-option-target (quote ("1.6")))
 '(jde-jdk (quote ("1.6")))

 ;; Nice feature sorting imports.
 '(jde-import-auto-sort t)

 ;; For syntax highlighting and basic syntax checking parse buffer
 ;; number of seconds from the time you changed the buffer.
 '(jde-auto-parse-buffer-interval 600)

 ;; Only for CygWin users it improves path resolving
;; '(jde-cygwin-path-converter (quote (jde-cygwin-path-converter-cygpath)))
 ;; You can set different user name and e-mail address for each project
 '(user-mail-address "ldangelo@orangeleap.com")
)
