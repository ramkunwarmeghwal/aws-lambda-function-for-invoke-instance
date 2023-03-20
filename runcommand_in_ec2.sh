import boto3

def lambda_handler(event, context):
    instance_id = 'xyz' # ID of the EC2 instance to run the command on
    command = 'sudo sh /root/run.sh'
    ssm_client = boto3.client('ssm')
    response = ssm_client.send_command(
        InstanceIds=[instance_id],
        DocumentName='AWS-RunShellScript',
        Parameters={
            'commands': [command],
        },
    )

    command_id = response['Command']['CommandId']
    return f'Sent command {command_id} to instance {instance_id}'
