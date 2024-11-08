from pydantic import BaseModel
from typing import List
from datetime import date

class Work(BaseModel):
    id: int
    title: str
    author: str
    nchapters: int
    words: int
    language: str
    status: str
    date_published: date
    url: str

class Chapter(BaseModel):
    id: int
    title: str
    number: int
    summary: str
    words: int
    url: str

class User(BaseModel):
    id: int
    username: str
    works: List[Work]