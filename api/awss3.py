import boto3
from botocore.exceptions import NoCredentialsError

ACCESS_KEY =  "AKIAYSBHAVBGAWOYIY4L"
SECRET_KEY = "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"


def upload_to_aws(local_file, bucket, s3_file):
    s3 = boto3.client('s3', aws_access_key_id=ACCESS_KEY,
                      aws_secret_access_key=SECRET_KEY)

    try:
        s3.upload_file(local_file, bucket, s3_file)
        print("Upload Successful")
        return True
    except FileNotFoundError:
        print("The file was not found")
        return False
    except NoCredentialsError:
        print("Credentials not available")
        return False


uploaded = upload_to_aws('./test1.txt', 'recycler20211008', '%s/%s' % ('test','test1.txt'))