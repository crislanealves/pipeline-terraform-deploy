import uvicorn
import requests

from fastapi      import FastAPI, HTTPException
from pydantic     import BaseModel
from google.cloud import storage


app = FastAPI()

class Params(BaseModel):
    url: str
    bucket_name: str
    output_file_prefix: str

def put_file_to_gcs(output_file: str, bucket_name: str, content):
    """ Uploads the data to the Cloud Storage bucket """

    try:
        storage_client = storage.Client()
        bucket         = storage_client.bucket(bucket_name)
        blob           = bucket.blob(output_file)

        blob.upload_from_string(content)

        return 'OK'

    except Exception as ex:
        print(ex)

# Teste api 
@app.get('/')
async def read_root():
    return {"Hello": "World"}

def get_data(remote_url):
    """  Function used to download data """

    response = requests.get(remote_url)

    return response


@app.post("/download_data")
async def download_data(params: Params):
    try:

        data = get_data(params.url)

        put_file_to_gcs(
            bucket_name = params.bucket_name,
            output_file = params.output_file_prefix,
            content     = data.content)

        return {"Status": "OK", "Bucket_name": params.bucket_name, "url": params.url}

    except Exception as ex:
        raise HTTPException(status_code=ex.code, detail=f"{ex}")

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8080)