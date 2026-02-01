owner=($(id -u))

if [ $owner -ne 0 ]; then
    echo "Please run this script as root."
    exit 1
fi
hobs(){

    if [ $1 -ne 0 ]; then
        echo $2 installed sucessfully."
        exit 1
    else
        echo "$2 installation failed."
    fi
}

dnf install nginx -y
hobs $? "nginx"

dnf install mysql-server -y
hobs $? "mysql-server"