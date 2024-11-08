from pydantic import BaseModel
from typing import Optional, Union


class Sexo(BaseModel):
    id: Optional[int] = ""
    nombre: str

class Humano(BaseModel):
    id: Optional[str] = ""
    nombre: str
    id_sexo: Union[int, Sexo]
    tipo_sangre: str
    edad: int

