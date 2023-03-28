source common.sh

print_head "Setup mongodb repository"
cp ${code_dir}configs/mongodb.repo /etc/yum.repos.d/mongo.repo

print_head "Intsall mongoDB"
yum install mongodb-org -y

print_head "enable mongoDB"
systemctl enable mongod

print_head "Start mongoDB service"
systemctl start mongod

#update /etc/mongodb.conf from 127.0.0.1 to 0.0.0.0
