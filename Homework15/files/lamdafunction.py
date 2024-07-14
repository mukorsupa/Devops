import boto3

def lambda_handler(event, context):
    ec2 = boto3.client('ec2')
    response = ec2.describe_instances(Filters=[{'Name': 'tag:YOUR_TAG_KEY', 'Values': ['YOUR_TAG_VALUE']}])

    for reservation in response['Reservations']:
        for instance in reservation['Instances']:
            instance_id = instance['InstanceId']
            ec2.stop_instances(InstanceIds=[instance_id])
            print(f'Stopped instance: {instance_id}')