owner=($(id -u))
logs_dir="/var/log/shell-practice.sh" 
log_file="/var/log/shell-practice/$0.log"
if [ $owner -ne 0 ]; then
    echo "Please run this script as root."
    exit 1
fi

mkdir -p /var/log/shell-practice
hobs(){

    if [ $1 -ne 0 ]; then
        echo "$2 installation failed." | tee -a $log_file
        exit 1
    else
        echo "$2 installation successful." | tee -a $log_file
    fi
}

dnf install nginx -y  | tee -a $log_file 
hobs $? "nginx"

dnf install mysql-server -y | tee -a $log_file
hobs $? "mysql-server"