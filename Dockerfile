FROM mattrayner/lamp:latest-1804

RUN rm -f /etc/service/sshd/down
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN service ssh restart

RUN groupadd ciscn
RUN useradd -g ciscn ciscn -m
RUN password=$(openssl passwd -1 -salt 'c7CT0EgV' 'W1rk8yZe')
RUN sed -i "s#ciscn:\!#ciscn:"$password"#g" /etc/shadow

COPY ./source /app
COPY ./users.sql /tmp

COPY ./flag.txt /flag
RUN chown root:root /flag
RUN chmod 644 /flag

COPY ./start.sh /
RUN chmod +x /start.sh
CMD /start.sh
