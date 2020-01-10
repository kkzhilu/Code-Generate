<?xml version="1.0" encoding="UTF-8"?>
<configuration>
	<include resource="org/springframework/boot/logging/logback/defaults.xml"/>
	<jmxConfigurator />
	<property name="app" value="${genConfig.projectName}" />

	<!-- 输出到控制台 -->
	<appender name="CONSOLE" class="ch.qos.logback.core.ConsoleAppender">
		<encoder class="ch.qos.logback.classic.encoder.PatternLayoutEncoder">
			<charset>UTF-8</charset>
			<pattern>%yellow(%date{yyyy-MM-dd HH:mm:ss}) |%highlight(%-5level) |%blue(%thread) |%blue(%file:%line) |%cyan(%msg%n)</pattern>
		</encoder>
	</appender>
	<!-- 输出到日志文件 -->
	<appender name="FILE" class="ch.qos.logback.core.rolling.RollingFileAppender">
		<encoder class="ch.qos.logback.classic.encoder.PatternLayoutEncoder">
			<charset>UTF-8</charset>
			<pattern>%d [%thread] %-5level %logger{36} %line - %msg%n</pattern>
		</encoder>
		<rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
			<FileNamePattern>/var/log/${genConfig.projectName}/${genConfig.projectName}.%d{yyyyMMdd}.log</FileNamePattern>
			<MaxHistory>10</MaxHistory>
		</rollingPolicy>
	</appender>
	<logger name="com.apache.ibatis" level="DEBUG"/>
	<logger name="java.sql.Connection" level="DEBUG"/>
	<logger name="java.sql.Statement" level="DEBUG"/>
	<logger name="java.sql.PreparedStatement" level="DEBUG"/>
	<root level="INFO">
		<appender-ref ref="CONSOLE"/>
		<appender-ref ref="FILE"/>
	</root>
</configuration>