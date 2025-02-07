FROM maven:3.9.9-eclipse-temurin-21

WORKDIR /workspace

COPY . .

RUN apt-get update && apt install nano -y && \
    rm -rf /var/lib/apt/lists/* && \
    chown -R 1000:1000 /workspace /usr/bin /usr/local/bin

USER 1000

RUN curl -sS https://starship.rs/install.sh | sh -s -- -y && \
    echo 'eval "$(starship init bash)"' >> ~/.bashrc && \
    echo "alias run!='PG_PASS=postgres mvn spring-boot:run -Dspring-boot.run.jvmArguments=-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005'" >> ~/.bashrc && \
    bash -c "source ~/.bashrc"

CMD ["bash", "-c", "run!"]
