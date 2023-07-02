# imports 
from fastapi import FastAPI

from typing import Optional
from fastapi import FastAPI, Response, status, HTTPException
import httpx
from pydantic import BaseModel

from decouple import config

BASE_URL = config('BASE_URL')

app = FastAPI()

@app.get("/")
def insurances_by_id(id:str=58):
    '''
    Parameters
    ----------
    id : str
        insurance id
    '''
    response = httpx.get(f"{BASE_URL}/{id}").json()
    insurance_info = response["insurance"]
    return insurance_info
