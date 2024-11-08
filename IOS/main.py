# main.py
import AO3
from fastapi import FastAPI, Body
from fastapi.middleware.cors import CORSMiddleware
from fastapi import HTTPException
from bs4 import BeautifulSoup
import requests
from pydantic import BaseModel
from ao3_api.AO3.users import User  # Correcta importación desde la carpeta 'ao3_api'
from ao3_api.AO3.works import Work  # Lo mismo para 'works'
from ao3_api.AO3.chapters import Chapter  # Lo mismo para 'chapters'
from ao3_api.AO3.search import Search
from typing import Optional

from AO3 import Search, utils

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=False,
    allow_methods=["*"],
    allow_headers=["*"],
)

#MODELOS ADICIONALES
class SearchRequest(BaseModel):
    any_field: Optional[str] = ""
    title: Optional[str] = ""
    author: Optional[str] = ""
    single_chapter: Optional[bool] = False
    word_count: Optional[int] = None
    language: Optional[str] = ""
    fandoms: Optional[str] = ""
    rating: Optional[int] = None
    hits: Optional[int] = None
    kudos: Optional[int] = None
    crossovers: Optional[bool] = None
    bookmarks: Optional[int] = None
    excluded_tags: Optional[str] = ""
    comments: Optional[int] = None
    completion_status: Optional[bool] = None
    page: Optional[int] = 1
    sort_column: Optional[str] = ""
    sort_direction: Optional[str] = ""
    revised_at: Optional[str] = ""
    characters: Optional[str] = ""
    relationships: Optional[str] = ""
    tags: Optional[str] = ""

class ChapterModel(BaseModel):
    id: int
    title: str
    number: int
    summary: str
    words: int
    url: str
    content: str  # Agregamos un campo para el contenido del capítulo

"""------------------------------"""

@app.get("/user/{username}")
def obtener_usuario(username: str):
    user = User(username)  # Crea una instancia de User con el nombre de usuario

    # Verifica que los trabajos estén cargados
    works = user.get_works()  # Obtiene los trabajos del usuario

    works_list = []
    if isinstance(works, list):
        for work in works:
            # Accede a los atributos del objeto Work
            works_list.append({
                'id': work.id,  # Accede al atributo 'id' del objeto Work
                'title': work.title,  # Título del trabajo
                #'author': work.author,  # Autor del trabajo
                #'nchapters': work.nchapters,  # Número de capítulos
                'words': work.words,  # Número de palabras
                'language': work.language,  # Idioma
                'status': work.status,  # Estado del trabajo
                #'date_published': work.date_published,  # Fecha de publicación
                'url': work.url  # URL del trabajo
            })

    # Devuelve los trabajos como respuesta
    return {'username': user.username, 'works': works_list}

"""------------------------------"""

def obtener_contenido_obra(url):
    # Realiza una solicitud GET a la página de la obra
    response = requests.get(url)
    
    # Si la solicitud fue exitosa
    if response.status_code == 200:
        soup = BeautifulSoup(response.content, "html.parser")
        
        # Busca el contenedor que contiene el texto de la obra (puede variar según el diseño de AO3)
        contenido_obra = soup.find("div", {"class": "userstuff"})
        
        if contenido_obra:
            return contenido_obra.get_text(strip=True)  # Devuelve el texto de la obra
        else:
            return "Contenido no encontrado"  # Si no se encuentra el contenido, retornamos un mensaje
    else:
        return f"Error al acceder a la obra: {response.status_code}"


"""------------------------------"""

@app.get("/work/{work_id}/chapter/{chapter_id}", response_model=ChapterModel)
def obtener_capitulo(work_id: int, chapter_id: int):
    try:
        # Obtiene la obra a partir del ID
        work = AO3.Work(work_id)
        
        # Busca el capítulo por el ID dentro de los capítulos de la obra
        chapter = next((ch for ch in work.chapters if ch.id == chapter_id), None)
        
        if chapter:
            # Obtiene el contenido del capítulo
            content = obtener_contenido_obra(chapter.url)  # Usamos la URL del capítulo
            
            # Creamos el modelo con el contenido
            chapter_model = ChapterModel(
                id=chapter.id,
                title=chapter.title,
                number=chapter.number,
                summary=chapter.summary,
                words=chapter.words,
                url=chapter.url,
                content=content  # Incluimos el contenido en la respuesta
            )
            return chapter_model
        else:
            raise HTTPException(status_code=404, detail="Capítulo no encontrado")
    
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.get("/work/{work_id}/chapters")
def Obtener_Chapters(work_id: int):
    try:
        # Obtienes el trabajo (Work) a partir del ID
        work = AO3.Work(work_id)

        # Asegúrate de que el trabajo tiene capítulos cargados
        if not work.chapters:
            raise HTTPException(status_code=404, detail="No chapters found for this work.")

        chapters = []  # Lista para almacenar los capítulos

        # Iteramos sobre todos los capítulos del trabajo
        for chapter in work.chapters:
            # Aquí estamos pasando el ID del capítulo, el objeto Work y otros parámetros necesarios
            chapter_content = obtener_contenido_obra(chapter.url)  # Obtener contenido de cada capítulo
            
            chapters.append({
                'id': chapter.id,
                'title': chapter.title,
                'number': chapter.number,
                'summary': chapter.summary,
                'words': chapter.words,
                'url': chapter.url,
                'content': chapter_content  # Añadimos el contenido del capítulo
            })

        return chapters

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


"""------------------------------"""

@app.get("/search")
def search_works(
    any_field: Optional[str] = "",
    title: Optional[str] = "",
    author: Optional[str] = "",
    page: Optional[int] = 1,
):
    try:
        # Realiza la búsqueda según los parámetros proporcionados
        search = AO3.Search(
            title=title,
            author=author,
            page=page
        )
        search.update()

        results = []

        for work in search.results:
            # Debug: muestra el tipo y valor de work.words para rastrear el problema
            print(f"Debug: Tipo de work.words = {type(work.words)}, Valor de work.words = '{work.words}'")

            author_name = getattr(work, 'author', 'Unknown Author')
            title = getattr(work, 'title', 'Unknown Title')
            summary = getattr(work, 'summary', 'No Summary Available')
            language = getattr(work, 'language', 'Unknown Language')
            status = getattr(work, 'status', 'Unknown Status')
            url = getattr(work, 'url', '')

            # Procesa el word_count asegurando la eliminación de comas y conversión a string
            word_count = "0"  # Valor predeterminado como string

            try:
                if isinstance(work.words, str):
                    # Elimina las comas y convierte a entero, luego a string
                    cleaned_word_count = work.words.replace(",", "").strip()
                    word_count = str(int(cleaned_word_count))  # Convierte la cadena limpia a int
                elif isinstance(work.words, int):
                    # Si es un entero, no hace falta limpieza
                    word_count = str(work.words)
                else:
                    # Si es un tipo inesperado, registra el problema
                    print(f"Debug: Tipo inesperado para work.words = {type(work.words)}")
            except (ValueError, AttributeError) as e:
                print(f"Error al procesar word_count para la obra '{title}': {e}")
                word_count = "0"  # Asigna un valor predeterminado

            # Añade la información de la obra a los resultados
            results.append({
                "id": work.id,
                "title": title,
                "author": author_name,
                "summary": summary,
                "language": language,
                "status": status,
                "url": url,
                "word_count": word_count
            })

        return {"results": results} if results else {"results": "No works found."}

    except Exception as e:
        print(f"Error general en búsqueda: {e}")
        raise HTTPException(status_code=500, detail=f"Error general en búsqueda: {e}")









