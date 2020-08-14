aws ec2 describe-fleets |grep FleetId | awk  '{print $2}' | awk -F '"' '{print $2}'  | while read line; do
echo $line
    # ... more code ... #
    aws ec2 delete-fleets --fleet-ids $line --terminate-instances
done
