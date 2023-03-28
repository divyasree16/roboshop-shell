source common.sh

print_head "Setup mongodb repository"
cp ${code_dir}configs/mongodb.repo /etc/yum.repos.d/mongo.repo &>>${log_file}

print_head "Intsall mongoDB"
yum install mongodb-org -y &>>${log_file}

print_head "Update MongoDB Listen Address"
sed -i -e 's/127.0.0.0/0.0.0.0' /etc/mongod.conf &>>${log_file}

print_head "enable mongoDB"
systemctl enable mongod &>>${log_file}

print_head "Start mongoDB service"
systemctl start mongod &>>${log_file}

