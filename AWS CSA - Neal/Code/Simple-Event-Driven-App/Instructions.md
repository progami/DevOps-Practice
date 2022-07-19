## SQS - Lambda - DynamoDB Table ##

Set region:
    Region: us-east-1

Note your AWS account number: *ACCOUNT NUMBER*

Create DDB Table:
	Name: ProductVisits
	Partition key: ProductVisitKey
	
Create SQS Queue:
	Name: ProductVisitsDataQueue
	Type: Standard
	
Note the Queue URL: *QUEUE URL*

Go to AWS Lambda and create function
	Name: productVisitsDataHandler
	Runtime: Node.js 12.x
	Role: create new role from templates
	Role name: lambdaRoleForSQSPermissions
	Add policy templates: "Simple microservice permissions" and "Amazon SQS poller permissions"
	
From actions menu in front of function code heading upload a zip file (DCTProductVisitsTracking.zip)

Go back to SQS and open "ProductVisitsDataQueue"

Configure Lambda function trigger and specify Lambda function:
    Name: productVisitsDataHandler

Go to AWS CLI and send messages:
    AWS CLI Command: `aws sqs send-message --queue-url *QUEUE URL* --message-body file://message-body-1.json`
    Modify: Queue name and file name
    File location: Code/build-a-serverless-app/part-1

