AMI_ID="ami-0220d79f3f480ecf5"
SG_ID="sg-092464f7c3ff76b0c"
HOSTED_ZONE_ID="Z005220126JCOLLY8L5ZO"
DOMAIN_NAME="chakri.sbs"

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
        RECORD_NAME="$DOMAIN_NAME"

    else 

         IP=$(aws ec2 describe-instances \
        --instance-ids $instance_id \
        --query 'Reservations[].Instances[].PrivateIpAddress' \
        --output text \
        )
        echo "Private IP adress of $instance : $IP"   
        RECORD_NAME="$instance.$DOMAIN_NAME"

    fi
        aws route53 change-resource-record-sets \
    --hosted-zone-id "$HOSTED_ZONE_ID" \
    --change-batch '{
        "Comment": "Updating record via script",
        "Changes": [
            {
                "Action": "UPSERT",
                "ResourceRecordSet": {
                    "Name": "'"$RECORD_NAME"'",
                    "Type": "A",
                    "TTL": 1,
                    "ResourceRecords": [
                        {
                            "Value": "'$IP'"
                        }
                    ]
                }
            }
        ]
    }'
    echo "DNS record created for $instance"


done