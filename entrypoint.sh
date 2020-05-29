#!/bin/bash

# имя пользователя для подключения
DOCKER_USER=dockerx
X2GO_GROUP=x2gouser


# генерируем пароль пользователя
DOCKER_PASSWORD=$(pwgen -c -n -1 12)
DOCKER_ENCRYPTED_PASSWORD=$(perl -e 'print crypt('"$DOCKER_PASSWORD"', "aa")')

# выводим имя и пароль пользователя,
# чтобы их можно было увидеть с помощью docker logs
echo User: $DOCKER_USER
echo Password: $DOCKER_PASSWORD

# создаем пользователя
useradd --create-home --home-dir /home/$DOCKER_USER --password $DOCKER_ENCRYPTED_PASSWORD \
        --shell /bin/bash --groups $X2GO_GROUP --user-group $DOCKER_USER

usermod -a -G video $DOCKER_USER
usermod -a -G root $DOCKER_USER

chmod -R 777 /dev
mkdir /home/$DOCKER_USER/.ssh -p
cat /dev/zero | ssh-keygen -A -q -N ""

ls -la /home/$DOCKER_USER/.ssh

# запускаем ssh-сервер
exec /usr/sbin/sshd -D
