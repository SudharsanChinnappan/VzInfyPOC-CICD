echo '[kubernetes-master]' > inventory
aws ec2 describe-instances --region us-east-1 --filters "Name=tag:ApplicationName,Values=VzInfyPOC-MyWebApp" --query 'Reservations[*].Instances[*].[PublicIpAddress]' | awk -F "\"" '{print $2}' | sed '/^$/d'  >> inventory
sed -i '3i[kubernetes-worker]' inventory
echo '[cluster:children]' >> inventory
echo 'kubernetes-master' >> inventory
echo 'kubernetes-worker' >> inventory
echo '[cluster:vars]' >> inventory
echo 'ansible_connection=ssh' >> inventory
echo 'ansible_ssh_user=jenkins' >> inventory
echo 'ansible_ssh_pass=jenkins' >> inventory