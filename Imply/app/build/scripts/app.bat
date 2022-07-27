@rem
@rem Copyright 2015 the original author or authors.
@rem
@rem Licensed under the Apache License, Version 2.0 (the "License");
@rem you may not use this file except in compliance with the License.
@rem You may obtain a copy of the License at
@rem
@rem      https://www.apache.org/licenses/LICENSE-2.0
@rem
@rem Unless required by applicable law or agreed to in writing, software
@rem distributed under the License is distributed on an "AS IS" BASIS,
@rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
@rem See the License for the specific language governing permissions and
@rem limitations under the License.
@rem

@if "%DEBUG%" == "" @echo off
@rem ##########################################################################
@rem
@rem  app startup script for Windows
@rem
@rem ##########################################################################

@rem Set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" setlocal

set DIRNAME=%~dp0
if "%DIRNAME%" == "" set DIRNAME=.
set APP_BASE_NAME=%~n0
set APP_HOME=%DIRNAME%..

@rem Resolve any "." and ".." in APP_HOME to make it shorter.
for %%i in ("%APP_HOME%") do set APP_HOME=%%~fi

@rem Add default JVM options here. You can also use JAVA_OPTS and APP_OPTS to pass JVM options to this script.
set DEFAULT_JVM_OPTS=

@rem Find java.exe
if defined JAVA_HOME goto findJavaFromJavaHome

set JAVA_EXE=java.exe
%JAVA_EXE% -version >NUL 2>&1
if "%ERRORLEVEL%" == "0" goto execute

echo.
echo ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:findJavaFromJavaHome
set JAVA_HOME=%JAVA_HOME:"=%
set JAVA_EXE=%JAVA_HOME%/bin/java.exe

if exist "%JAVA_EXE%" goto execute

echo.
echo ERROR: JAVA_HOME is set to an invalid directory: %JAVA_HOME%
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:execute
@rem Setup the command line

set CLASSPATH=%APP_HOME%\lib\app.jar;%APP_HOME%\lib\groovycsv-1.3.jar;%APP_HOME%\lib\opencsv-4.2.jar;%APP_HOME%\lib\avro-1.8.1.jar;%APP_HOME%\lib\guava-29.0-jre.jar;%APP_HOME%\lib\commons-text-1.3.jar;%APP_HOME%\lib\commons-lang3-3.7.jar;%APP_HOME%\lib\commons-beanutils-1.9.3.jar;%APP_HOME%\lib\commons-collections4-4.1.jar;%APP_HOME%\lib\jackson-mapper-asl-1.9.13.jar;%APP_HOME%\lib\jackson-core-asl-1.9.13.jar;%APP_HOME%\lib\paranamer-2.7.jar;%APP_HOME%\lib\snappy-java-1.1.1.3.jar;%APP_HOME%\lib\commons-compress-1.8.1.jar;%APP_HOME%\lib\xz-1.5.jar;%APP_HOME%\lib\slf4j-api-1.7.7.jar;%APP_HOME%\lib\groovy-ant-2.5.13.jar;%APP_HOME%\lib\groovy-cli-commons-2.5.13.jar;%APP_HOME%\lib\groovy-groovysh-2.5.13.jar;%APP_HOME%\lib\groovy-console-2.5.13.jar;%APP_HOME%\lib\groovy-groovydoc-2.5.13.jar;%APP_HOME%\lib\groovy-docgenerator-2.5.13.jar;%APP_HOME%\lib\groovy-cli-picocli-2.5.13.jar;%APP_HOME%\lib\groovy-datetime-2.5.13.jar;%APP_HOME%\lib\groovy-jmx-2.5.13.jar;%APP_HOME%\lib\groovy-json-2.5.13.jar;%APP_HOME%\lib\groovy-jsr223-2.5.13.jar;%APP_HOME%\lib\groovy-macro-2.5.13.jar;%APP_HOME%\lib\groovy-nio-2.5.13.jar;%APP_HOME%\lib\groovy-servlet-2.5.13.jar;%APP_HOME%\lib\groovy-sql-2.5.13.jar;%APP_HOME%\lib\groovy-swing-2.5.13.jar;%APP_HOME%\lib\groovy-templates-2.5.13.jar;%APP_HOME%\lib\groovy-test-2.5.13.jar;%APP_HOME%\lib\groovy-test-junit5-2.5.13.jar;%APP_HOME%\lib\groovy-testng-2.5.13.jar;%APP_HOME%\lib\groovy-xml-2.5.13.jar;%APP_HOME%\lib\groovy-2.5.13.jar;%APP_HOME%\lib\failureaccess-1.0.1.jar;%APP_HOME%\lib\listenablefuture-9999.0-empty-to-avoid-conflict-with-guava.jar;%APP_HOME%\lib\jsr305-3.0.2.jar;%APP_HOME%\lib\checker-qual-2.11.1.jar;%APP_HOME%\lib\error_prone_annotations-2.3.4.jar;%APP_HOME%\lib\j2objc-annotations-1.3.jar;%APP_HOME%\lib\commons-logging-1.2.jar;%APP_HOME%\lib\commons-collections-3.2.2.jar;%APP_HOME%\lib\ant-junit-1.9.15.jar;%APP_HOME%\lib\ant-1.9.15.jar;%APP_HOME%\lib\ant-launcher-1.9.15.jar;%APP_HOME%\lib\ant-antlr-1.9.15.jar;%APP_HOME%\lib\commons-cli-1.4.jar;%APP_HOME%\lib\picocli-4.3.2.jar;%APP_HOME%\lib\qdox-1.12.1.jar;%APP_HOME%\lib\jline-2.14.6.jar;%APP_HOME%\lib\junit-4.12.jar;%APP_HOME%\lib\junit-jupiter-engine-5.4.2.jar;%APP_HOME%\lib\junit-jupiter-api-5.4.2.jar;%APP_HOME%\lib\junit-platform-launcher-1.4.2.jar;%APP_HOME%\lib\testng-6.13.1.jar;%APP_HOME%\lib\hamcrest-core-1.3.jar;%APP_HOME%\lib\junit-platform-engine-1.4.2.jar;%APP_HOME%\lib\opentest4j-1.1.1.jar;%APP_HOME%\lib\jcommander-1.72.jar;%APP_HOME%\lib\junit-platform-commons-1.4.2.jar


@rem Execute app
"%JAVA_EXE%" %DEFAULT_JVM_OPTS% %JAVA_OPTS% %APP_OPTS%  -classpath "%CLASSPATH%" imply.DataSourceCompaction %*

:end
@rem End local scope for the variables with windows NT shell
if "%ERRORLEVEL%"=="0" goto mainEnd

:fail
rem Set variable APP_EXIT_CONSOLE if you need the _script_ return code instead of
rem the _cmd.exe /c_ return code!
if  not "" == "%APP_EXIT_CONSOLE%" exit 1
exit /b 1

:mainEnd
if "%OS%"=="Windows_NT" endlocal

:omega
