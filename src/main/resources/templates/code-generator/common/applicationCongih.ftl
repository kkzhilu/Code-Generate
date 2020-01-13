# 服务端口
server.port=8080

# slf4j配置输出mybatis-dao相关的操作为DEBUG级别, 数据库日志会打印到debug文件中
logging.level.${genConfig.packageName}.dao=DEBUG
logging.config=classpath:logback-spring.xml
logging.file=/log/${genConfig.projectName}

# mybaits配置文件
mybatis.mapper-locations = classpath:mapper/*Mapper.xml
mybatis.type-aliases-package = ${genConfig.packageName}.entity

# mysql配置
spring.datasource.driverClassName=${genConfig.driver}
spring.datasource.url=jdbc:mysql://${genConfig.ip}:${genConfig.port}/${genConfig.dataBase}?characterEncoding=${genConfig.encoding}
spring.datasource.username=${genConfig.loginName}
spring.datasource.password=${genConfig.passWord}