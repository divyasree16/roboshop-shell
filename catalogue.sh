source common.sh

print_head "configure NodeJS Repo"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}

print_head "Install NodeJS"
yum install nodejs -y &>>${log_file}

print_head "Creating Roboshop user"
useradd roboshop &>>${log_file}

print_head "Create application directory"
mkdir /app &>>${log_file}

print_head "Delete old content"
rm -rf /app/* &>>${log_file}

print_head "Downloading app content"
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${log_file}
cd /app

print_head "Extracting App content"
unzip /tmp/catalogue.zip &>>${log_file}
cd /app

print_head "Installing NodeJS Dependencies"
npm install &>>${log_file}

print_head "Copy SystemD Service File"
cp ${code_dir}/configs/catalogue.service /etc/systemd/system/catalogue.service &>>${log_file}

print_head "Reload systemD"
systemctl daemon-reload &>>${log_file}

print_head "Enable catalogue service"
systemctl enable catalogue &>>${log_file}

print_head "Strat Ctalogue Service"
systemctl start catalogue &>>${log_file}

print_head "Copy MongoDB Repo file"
cp ${code_dir}/configs/mongodb.rep /etc/yum.repos.d/mongo.repo &>>${log_file}

print_head "Install Mongo Client"
yum install mongodb-org-shell -y &>>${log_file}

print_head "Load schema"
mongo --host mongodb-dev.devops161997.online </app/schema/catalogue.js &>>${log_file}

