source common.sh

print_head "Setup mongodb repository"
cp ${code_dir}configs/mongodb.repo /etc/yum.repos.d/mongo.repo &>>{log_file}

print_head "Intsall mongoDB"
yum install mongodb-org -y &>>{log_file}

print_head "enable mongoDB"
systemctl enable mongod &>>{log_file}

print_head "Start mongoDB service"
systemctl start mongod &>>{log_file}

#update /etc/mongodb.conf from 127.0.0.1 to 0.0.0.0
