owner=($(id -u))

if [ $owner -ne 0 ]; then
    echo "Please run this script as root."
    exit 1
fi

dnf install nginx -y

if [ $? -ne 0]; then
    echo "Failed to install nginx."
    exit 1
else
    echo "nginx installed successfully."
fi

dnf install mysql-server -y
if [ $? -ne 0]; then
    echo "Failed to install mysql-server."
    exit 1
else
    echo "mysql-server installed successfully."
fi