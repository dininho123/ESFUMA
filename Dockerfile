FROM tomcat:10.1-jdk21-temurin

# MySQL JDBC driver
RUN curl -L https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/9.0.0/mysql-connector-j-9.0.0.jar \
    -o /usr/local/tomcat/lib/mysql-connector-j.jar

# Remove as aplicações padrão do Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copia o site para a raiz do Tomcat (acessível em / sem /ESFUMA/)
COPY . /usr/local/tomcat/webapps/ROOT/

EXPOSE 8080

CMD ["catalina.sh", "run"]
