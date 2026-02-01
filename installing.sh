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