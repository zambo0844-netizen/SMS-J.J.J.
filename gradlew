Gradle start up script for UN*X
##############################################################################
Add default JVM options here. You can also use JAVA_OPTS and GRADLE_OPTS to pass JVM options to this script.
DEFAULT_JVM_OPTS=""
APP_NAME="Gradle" APP_BASE_NAME=basename "$0"
Resolve links - $0 may be a link
PRG="$0"
while [ -h "$PRG" ] ; do ls=ls -ld "$PRG" link=expr "$ls" : '.*-> \(.*\)$' if expr "$link" : '/.*' > /dev/null; then PRG="$link" else PRG=dirname "$PRG"/"$link" fi done
DIRNAME=dirname "$PRG"
Make it fully qualified
PRGDIR=cd "$DIRNAME" && pwd
Setup JAVA_HOME if not set
if [ -z "$JAVA_HOME" ]; then if [ -x /usr/libexec/java_home ]; then JAVA_HOME=/usr/libexec/java_home fi fi
if [ -z "$JAVA_HOME" ]; then
Try common locations
if [ -d "/usr/lib/jvm/default-java" ]; then JAVA_HOME="/usr/lib/jvm/default-java" fi fi
if [ -z "$JAVA_HOME" ]; then echo "WARNING: JAVA_HOME is not set. Gradle requires a Java JDK to run." fi
GRADLE_HOME="$PRGDIR/gradle/wrapper"
CLASSPATH="$GRADLE_HOME/gradle-wrapper.jar"
if [ ! -f "$CLASSPATH" ]; then echo "ERROR: gradle-wrapper.jar not found in $GRADLE_HOME" echo "Please add gradle/wrapper/gradle-wrapper.jar to the repository or generate the wrapper locally (gradle wrapper)." exit 127 fi
Allow user defined JVM options
if [ -n "$GRADLE_OPTS" ]; then DEFAULT_JVM_OPTS="$DEFAULT_JVM_OPTS $GRADLE_OPTS" fi
Find java executable
if [ -n "$JAVA_HOME" ]; then JAVA="$JAVA_HOME/bin/java" else JAVA="java" fi
exec " J A V A " $ D E F A U L T J V M O P T S − c l a s s p a t h " CLASSPATH" org.gradle.wrapper.GradleWrapperMain "$@"
Archivo: gradlew.bat (guárdalo en la raíz) @echo off rem ---------------------------------------------------------------------- rem Gradle startup script for Windows rem ----------------------------------------------------------------------
if "%JAVA_HOME%"=="" goto noJavaHome set DEFAULT_JVM_OPTS= set APP_BASE_NAME=%~n0 set DIRNAME=%~dp0 set GRADLE_HOME=%DIRNAME%gradle\wrapper set CLASSPATH=%GRADLE_HOME%\gradle-wrapper.jar
if not exist "%CLASSPATH%" ( echo ERROR: gradle-wrapper.jar not found in %GRADLE_HOME% echo Please add gradle\wrapper\gradle-wrapper.jar to the repository or generate the wrapper locally (gradle wrapper). exit /b 127 )
if defined JAVA_HOME ( set JAVA_EXE=%JAVA_HOME%\bin\java.exe ) else ( set JAVA_EXE=java )
"%JAVA_EXE%" %DEFAULT_JVM_OPTS% -classpath "%CLASSPATH%" org.gradle.wrapper.GradleWrapperMain %*
Archivo: gradle/wrapper/gradle-wrapper.properties (crea carpeta gradle/wrapper y pon este archivo dentro) #Wed Jun 19 00:00:00 UTC 2026 distributionBase=GRADLE_USER_HOME distributionPath=wrapper/dists zipStoreBase=GRADLE_USER_HOME zipStorePath=wrapper/dists
