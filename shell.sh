AMI_ID="ami-0220d79f3f480ecf5"
SG_ID="sg-092464f7c3ff76b0c"

for instance in $@ 
do
    instance_id=$(aws ec2 run-instances \
        --image-id $AMI_ID \
        --instance-type t3.micro \
        --security-group-ids $SG_ID \
        --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" \
        --query 'Instances[0].InstanceId' \
        --output text
        )
    if [ $instance = "frontend" ]; then 
        
        IP=$(aws ec2 describe-instances \
        --instance-ids $instance_id \
        --query 'Reservations[].Instances[].PublicIpAddress' \
        --output text \
        )
        echo "Public IP address of $instance : $IP"

    else 

         IP=$(aws ec2 describe-instances \
        --instance-ids $instance_id \
        --query 'Reservations[].Instances[].privateIpAddress' \
        --output text \
        )
        echo "Private IP adress of $instance : $IP"   

    fi


done