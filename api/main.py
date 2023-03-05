from fastapi      import FastAPI, HTTPException
from pydantic     import BaseModel
from google.cloud import storage

import requests

app = FastAPI()

class Params(BaseModel):
    url: str
    bucket_name: str
    output_file_prefix: str

def get_data(url):
    """  Function used to download data """

    response = requests.get(url)

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
