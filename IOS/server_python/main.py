"""
Aqui vamos a realizar pruebas para hacer una api de conexion sencilla
"""

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from src.modelos import Humano, Sexo

from uuid import uuid4 as obtener_uuid

import sqlite3
direccion_base_datos = "humanos_venta.db"



app = FastAPI()

app.add_middleware(
        CORSMiddleware,
        allow_origins=["*"],
        allow_credentials=False,
        allow_methods=["*"],
        allow_headers=["*"],
        )

@app.get("/")
def obtener_raiz():
    conexion = sqlite3.connect(direccion_base_datos)
    cursor = conexion.cursor()

    respuesta = cursor.execute("select * from humanos")
    respuesta = respuesta.fetchall() #Aqui hacemos un shadowing

    humanos = []

    for humano in respuesta:
        humanos.append(Humano(
            id = humano[0],
            nombre = humano[1],
            id_sexo = humano[2],
            tipo_sangre = humano[3],
            edad = int(humano[4])
            ))

    return humanos


@app.get("/sexos/{id}")
def obtener_sexo(id):
    conexion = sqlite3.connect(direccion_base_datos)
    cursor = conexion.cursor()

    respuesta = cursor.execute(f"""select * from sexos where id = {id}""")
    respuesta = respuesta.fetchone() #Aqui hacemos un shadowing

    sexo = Sexo(
            id = respuesta[0],
            nombre = respuesta[1],
            )

    return sexo


@app.get("/humano/{id}")
def obtener_humano(id):
    conexion = sqlite3.connect(direccion_base_datos)
    cursor = conexion.cursor()

    respuesta = cursor.execute("select * from humanos where id = " + str(id))
    humano = respuesta.fetchone() #Aqui hacemos un shadowing

    sujeto = Humano(
            id = humano[0],
            nombre = humano[1],
            id_sexo = obtener_sexo(humano[2]),
            tipo_sangre = humano[3],
            edad = humano[4]
            )

    return sujeto

@app.get("/eliminar/humano/{id}")
def eliminar_humano(id):
    conexion = sqlite3.connect(direccion_base_datos)
    cursor = conexion.cursor()

    respuesta = cursor.execute("delete from humanos where id = " + id)
    conexion.commit()
    return id


@app.post("/humanos")
def agregar_humano(humano_a_agregar: Humano):
    conexion = sqlite3.connect(direccion_base_datos)
    cursor = conexion.cursor()


    # Usamos obtener UUID para egenrar un UUID especifco para cada nueva integracion en la BDD
    respuesta = cursor.execute(f"""
            insert into humanos (
                            id,
                            nombre,
                            id_sexo,
                            tipo_sangre,
                            edad
                        )
                    values (
                            '{obtener_uuid()}',
                            '{humano_a_agregar.nombre}',
                            {humano_a_agregar.id_sexo},
                            '{humano_a_agregar.tipo_sangre}',
                            {humano_a_agregar.edad}
                        )
                        """)

    conexion.commit()

    return humano_a_agregar


