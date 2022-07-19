
# CloudFormation Stack

Go to CloudFormation main page
Create CloudFormation stack
Choose upload template file
Select YAML file from local drive
Optional - click View in Designer if want to see AWSstack in designer
Click Next
Acknowledge and click Create Stack
Stack creation in progress
Stack created

# S3 Bucket

Create S3 bucket named "item-frontend-static-hosting". This bucket's URL has to be specified in the backend API CORS configuration for allowed origins. And later in bucket's own CORS configuration. Choose appropriate region as well as allow Public access
Enable Static website hosting on this bucket
Check Enable, Host Static Website. And specify index.html as index document

Edit Bucket Policy: use the following code. Make sure the bucket name is correctly specified and save
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::items-frontend-static-hosting/*"
        }
    ]
}

Edit bucket CORS configuration. Use the following code and save
[
    {
        "AllowedHeaders": [
            "*"
        ],
        "AllowedMethods": [
            "GET"
        ],
        "AllowedOrigins": [
            "*"
        ],
        "ExposeHeaders": []
    }
]

# API Gateway Configuration

Go to API Gateway section to check API created as part of CF stack. items-api is created
Need to copy Invoke URL to be configured in frontend config
Need to modify four things: Routes, Integrations, Stages, CORS and then Deploy
Click Stage on left navigation. Then Click Create
New stage name "prod". Click Create at bottom
Go to Integrations
Manage Integrations tab. A default integration exists but we click Create to create a new one
Specify integration type, AWS region and Lambda function. This Lambda function is also created as part of CF stack. Click Create at bottom
New integration is ready. Note integration ID
Now need to create 6 routes: /items (OPTIONS, GET, PUT) and /items/{id} (OPTIONS, DELETE, GET)
    GET /items
    PUT /items
    GET /items/{id}
    DELETE(/items/{id}
    OPTIONS /items
    OPTIONS /items/{id}
Attach the NEW integration to the Lambda function to each of the 6 routes. Click Route. Then click Attach integration.
Select correct integration matching integration ID. Click Attach integration 
Repeat for all 6 routes
Configure CORS. All 6 fields should be configured:
    The bucket URL (for N.Virgina buckets) should be: https://YOURBUCKETNAME.s3.amazonaws.com
    "Access-Control-Allow-Origin" has to be specified after creating the S3 bucket as its name is used in the URL. Click Save. 
Now click Deploy at top right and select prod Stage for deployment

* Invoke URL: 

* Integration ID: 

# client-side code

# Make sure Nodejs version 12.x is installed on local computer

The invoke URL's apiId must be configured in the frontend config (frontend path: client\src\config.ts)
For example, if invoke URL for API is "https://0zf6cghiv8.execute-api.us-east-1.amazonaws.com/prod" then apiId is first part after "https://" i.e. 0zf6cghiv8

From a command prompt, go to client folder and install all dependencies by running "npm install"
Now run "npm run build" to create a production build in "build" subfolder
Upload the build subfolder content for the frontend client application into the bucket under Objects tab
Under "build" there is "static" folder which itself has three subfolders "css", "js" and "media". Make sure the proper structure is created in S3 and Files are uploaded into respective folders on the local machine
After all uploading is done. open index.html at the root of S3 bucket. Inside it shows an HTTPS URL. Use that to access the frontend application.

The frontend application by default opens a dashboard page which shows the Items link where at the top, a form allows you to add new items by specifying a unique ID, name and price. And below that a grid shows the items that have been added. Items can be deleted. But can't be updated.
