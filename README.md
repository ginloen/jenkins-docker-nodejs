**Install Docker Engine on Ubuntu 20.04**

1. Update the apt package index
```
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
```
2. Add Docker's official GPG key:
```
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
```
3. Set up the repository
```
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```
4. Update the apt package index
```
sudo apt-get update
```
5. Install Docker Engine, containerd and Docker Compose
```
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

Run docker without sudo

1. Add user to docker group (re-login required)
```
sudo usermod -aG docker $USER
```

**Install Jenkins LTS - Part 1**

1. Add Jenkins into package index
```
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
```

2. Install OpenJDK 17
```
sudo apt install openjdk-17-jre
```

3. Install Jenkins
```
sudo apt-get install jenkins
```

4. Add jenkins user to docker group
```
sudo usermod -aG docker jenkins
```

5. Start Jenkins
```
sudo systemctl enable jenkins
sudo systemctl start jenkins
```

6. Get initial Admin Password
```
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

6. Install Generic Webhook Trigger plugin
_Manage Jenkins > Plugins > Available plugins > Generic Webhook Trigger Plugin_

**Run GitLab container (must be install in another VM or webhook will have issues)**

1. Setup docker volume location
```
export GITLAB_HOME=/srv/gitlab
```

2. Install GitLab using Docker Engine (start up will take a while)
```
sudo docker run --detach \
  --hostname localhost \
  --publish 5000:80 \
  --name gitlab \
  --restart always \
  --volume $GITLAB_HOME/config:/etc/gitlab \
  --volume $GITLAB_HOME/logs:/var/log/gitlab \
  --volume $GITLAB_HOME/data:/var/opt/gitlab \
  --shm-size 256m \
  gitlab/gitlab-ee:latest
```

3. Get root password
```
sudo docker exec -it gitlab grep 'Password:' /etc/gitlab/initial_root_password
```
