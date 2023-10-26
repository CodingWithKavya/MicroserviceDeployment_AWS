#!/bin/bash
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
echo"Installing Maridb"
sudo dnf update
sudo dnf install mariadb105-server -y
sudo systemctl start mariadb
sudo systemctl enable mariadb
yum install -y java-1.8.0-amazon-corretto-devel
curl -o /home/ec2-user/couponservice-0.0.1-SNAPSHOT.jar https://codebucket-tus.s3.eu-north-1.amazonaws.com/couponservice-0.0.1-SNAPSHOT.jar
curl -o /etc/systemd/system/java-app.service https://raw.githubusercontent.com/CodingWithKavya/MicroserviceDeployment_AWS/main/app.service
systemctl enable java-app
systemctl start java-app
mysql -u root <<-EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY 'test1234';
FLUSH PRIVILEGES;
CREATE DATABASE servicedb;
USE servicedb;
CREATE TABLE product(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20),
    description VARCHAR(100),
    price DECIMAL(8,3) 
);
CREATE TABLE coupon(
    id INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(20) UNIQUE,
    discount DECIMAL(8,3),
    exp_date VARCHAR(100) 
);
EOF