# 🐳 Inception

<div align="center">

![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![NGINX](https://img.shields.io/badge/NGINX-009639?style=for-the-badge&logo=nginx&logoColor=white)
![WordPress](https://img.shields.io/badge/WordPress-21759B?style=for-the-badge&logo=wordpress&logoColor=white)
![MariaDB](https://img.shields.io/badge/MariaDB-003545?style=for-the-badge&logo=mariadb&logoColor=white)

*A 42 School project by **agaroux***

</div>

---

## 📋 Description

**Inception** is a system administration project that dives deep into containerization using **Docker** and **Docker Compose**. 

The challenge? Build a fully functional web infrastructure with:
- 🌐 **NGINX** as a reverse proxy
- 🗄️ **MariaDB** as the database
- 📝 **WordPress** as the CMS

Each service runs in its own container, communicating through a custom Docker bridge network. The twist: **no pre-built images allowed** – we build everything from scratch starting with base OS images.

> *"This project aims to broaden your knowledge of system administration by using Docker. You will virtualize several Docker images, creating them in your new personal virtual machine."*

---

## 🚀 Quick Start

### Build the containers
```bash
make build
```

### Start all services
```bash
make up
```

### Access the website
Navigate to: **https://agaroux.42.fr**


### Access mariadb
```bash
docker exec -it mariadb mysql -u root -psuper_secret_root
SHOW DATABASES;
USE wordpress;
SHOW TABLES;
```

### Stop and clean up
```bash
make down
make clean
```

---

## 📚 Resources

### 📖 Essential Reading
- [The NGINX Handbook](https://www.freecodecamp.org/news/the-nginx-handbook/)
- [DevOps with Docker (MOOC)](https://courses.mooc.fi/org/uh-cs/courses/devops-with-docker)
- [Docker 101: Docker Compose](https://medium.com/dev-sec-ops/docker-101-docker-compose-db96ae884cda)
- [Docker 101: Volume & Bind Mounting](https://medium.com/dev-sec-ops/docker-101-volume-bind-mounting-8f200c14ca0)

### 🎓 Tutorials
- [Inception Tutorial (Grademe)](https://tuto.grademe.fr/inception/)

---

## 🧠 Key Concepts

### 🖥️ Virtual Machines vs Docker

**Virtual Machine:**
A Virtual Machine is a computer configuration that lives on top of an existing computer and will take a part of the host's resource. Both interfaces don't communicate with each other. The VM can have every possible OS, independently from the host.

**Docker Container:**
A Docker is a container, meaning it's a set of dependencies that are grouped together so that a program can work on different environments without issue. 

**The Difference:**
The difference is that a VM is a lot heavier and is virtually separated from the host machine. It's good to create a safe environment that won't affect the host machine in case of hack or wrong manipulation. A Docker on the other hand, is made for easy and fast testing and deployment. The key technical difference is that VMs run their own kernel while Docker containers share the host's kernel, which is why containers are much lighter and faster to start.

---

### 🔐 Secrets vs Environment Variables

**Secrets:**
Secrets are plaintext files that usually contain one or more secret credentials, such as a private key.

**Environment Variables:**
Environment variables enable you to customize a service's runtime behavior for different environments (such as development, staging, and production). They also protect you from committing secret credentials (such as API keys or database connection strings) to your application source.

---

### 🌐 Docker Network vs Host Network

**Docker Network:**
Docker Network is a network that enables different containers to communicate with each other thanks to a separate DNS resolution solution called docker bridge.

**Host Network:**
Host Network is the network of the host machine, which enables your computer to test on localhost or connect to other servers on internet.

**How They Work Together:**
Both work together, the host sending requests to specific ports, that are then forwarded by docker bridge on the docker network and allows the containers to work in an isolated environment.

---

### 💾 Docker Volumes vs Bind Mounts

**The Problem:**
What is important to understand is that containers are stateless, meaning that if a container is stopped nothing is stored. So how can we prevent that?

**Docker Volumes:**
We can do volume mounting with docker volumes, which is there to ensure that no data is lost in case of an unexpected stopping of the container. It allows us to start a container right away, with the last made changes.

**Bind Mounts:**
On the other hand, bind mounting is used to create persistent volume on the host machine and not in the docker host directory.

---

<div align="center">

**Made with ❤️ for 42**

</div>