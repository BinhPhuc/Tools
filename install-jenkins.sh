#!/bin/bash

# 1. Dọn dẹp sạch sẽ các tệp cấu hình và key cũ gây xung đột
sudo rm -f /etc/apt/sources.list.d/jenkins.list
sudo rm -f /usr/share/keyrings/jenkins-keyring.asc
sudo rm -f /etc/apt/keyrings/jenkins-keyring.asc

# 2. Tạo thư mục lưu trữ key chuẩn mới nhất của Ubuntu/Debian
sudo mkdir -p /etc/apt/keyrings

# 3. Tải ĐÚNG khóa GPG 2026 (chứa mã 7198F4B714ABFC68)
# Sử dụng curl -fsSL an toàn hơn wget vì nó sẽ không tạo ra file rác nếu tải lỗi
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key | sudo tee /etc/apt/keyrings/jenkins-keyring.asc > /dev/null

# 4. Thêm kho lưu trữ Jenkins và trỏ đích danh vào khóa 2026 vừa tải
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# 5. Cập nhật lại apt và cài đặt Jenkins
sudo apt update
sudo apt install fontconfig openjdk-17-jre jenkins -y

# 6. Khởi động dịch vụ và cấu hình tường lửa
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo ufw allow 8080
sudo ufw status
