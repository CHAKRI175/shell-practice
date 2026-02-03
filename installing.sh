owner=($(id -u))
logs_dir="/var/log/shell-practice.sh" 
log_file="/var/log/shell-practice/$0.log"
R="\e[31m"
G="\e[32m"
Y="\e[33m"
B="\e[34m"
NC="\e[0m"
if [ $owner -ne 0 ]; then
    echo "$R Please run this script as root. $NC" | tee -a $log_file
    exit 1
fi

mkdir -p /var/log/shell-practice
validate(){

    if [ $1 -ne 0 ]; then
        echo "$2 $R installation failed. $NC" | tee -a $log_file
        exit 1
    else
        echo "$2 $G installation successful. $NC" | tee -a $log_file
    fi
}

