source common.sh

print_head "Configure NodeJS Repo"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}


print_head "Install NodeJS"
yum install nodejs -y &>>${log_file}


print_head "Create Roboshop User"
useradd roboshop &>>${log_file}


print_head "Create Application Directory"
mkdir /app &>>${log_file}


print_head "Delete old content"
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${log_file}
cd /app &>>${log_file}


print_head "Extracting App Content"
unzip /tmp/catalogue.zip &>>${log_file}


print_head "Installing NoseJS Dependencies"
npm install &>>${log_file}


print_head "Copy SystemD Service"
cp ${code_dir}/configs/catalogue.service /etc/systemd/system/catalogue.service &>>${log_file}


print_head "Reload SystemD"
systemctl daemon-reload &>>${log_file}


print_head "Enable Catalogue service"
systemctl enable catalogue &>>${log_file}


print_head "Start Catalogue service"
systemctl start catalogue &>>${log_file}


print_head "Copy mongodb repo file"
cp ${code_dir}/configs/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${log_file}


print_head "Imstall Mongo Client"
yum install mongodb-org-shell -y &>>${log_file}


print_head "Load Schema"
mongo --host mongodb-dev.devops161997.online </app/schema/catalogue.js &>>${log_file}
