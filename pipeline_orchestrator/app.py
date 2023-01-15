def lambda_handler(event, context):
    print(event)
    message = 'Hello user, orchestrator has been invoked with:  S3://{}/{}!'.format(event['Records'][0]['s3']['bucket']['name'], event['Records'][0]['s3']['object']['key'])  
    print(message)
    return { 
        'message' : message
    }

