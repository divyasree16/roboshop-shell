source common.sh

print_head "Installing nginx"
yum install nginx -y &>>${log_file}
status_check $?

print_head "Removing old content"
rm -rf /usr/share/nginx/html/* &>>${log_file}
status_check $?

print_head "Downloading frontend content"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${log_file}
status_check $?

print_head "Extracting downloaded frontend content"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>${log_file}
status_check $?

print_head "Copying nginix config for Roboshop"
cp ${code_dir}/configs/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${log_file}
status_check $?

print_head "Enabling nginx"
systemctl enable nginx &>>${log_file}
status_check $?

print_head "Starting nginx"
systemctl restart nginx &>>${log_file}
status_check $?

##roboshop config is not copied because the servers are not ready

