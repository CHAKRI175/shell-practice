AMI_ID="ami-0220d79f3f480ecf5"
SG_ID="sg-092464f7c3ff76b0c"

for instance in $@ 
do
    IP$=(aws ec2 run-instances \
        --image-id $AMI_ID \
        --instance-type t3.micro \
        --security-group-ids $SG_ID \
        --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" \
        --query 'Instances[*].[InstanceId, PublicIpAddress]' \
        --output text
        )
    if [ $instance = "frontend" ]; then 
        echo "Frontend instance launched with Instance ID and Public IP: $IP"

    else
        echo "IP adress of $instance : $IP"
    fi


done