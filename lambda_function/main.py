import json
import boto3

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('InventoryTable')

def handler(event, context):
    # Process the event
    print("Received event: " + json.dumps(event, indent=2))
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
