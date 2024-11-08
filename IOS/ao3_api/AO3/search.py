from math import ceil

from bs4 import BeautifulSoup

from . import threadable, utils
from .common import get_work_from_banner
from .requester import requester
from .series import Series
from .users import User
from .works import Work

DEFAULT = "_score"
BEST_MATCH = "_score"
AUTHOR = "authors_to_sort_on"
TITLE = "title_to_sort_on"
DATE_POSTED = "created_at"
DATE_UPDATED = "revised_at"
WORD_COUNT = "word_count"
RATING = "rating_ids"
HITS = "hits"
BOOKMARKS = "bookmarks_count"
COMMENTS = "comments_count"
KUDOS = "kudos_count"

DESCENDING = "desc"
ASCENDING = "asc"

def clean_and_convert_to_int(self, value, field_name="Unknown"):
    """ Limpia la cadena de comas y puntos y la convierte a un entero. """
    try:
        # Mostrar el valor original
        print(f"Intentando convertir el valor de {field_name}: '{value}'")
        
        # Elimina las comas y los puntos para garantizar que solo quede un número limpio
        cleaned_value = value.replace(',', '').replace('.', '').strip()

        # Mostrar el valor después de limpiarlo
        print(f"Valor después de limpiar {field_name}: '{cleaned_value}'")

        # Intenta convertir a entero
        return int(cleaned_value)
    except ValueError as e:
        # Si no se puede convertir, imprime el campo y el valor que causó el error
        print(f"Error al convertir {field_name}: '{value}'")
        print(f"Error específico: {e}")
        return 0  # Valor predeterminado en caso de error

class Search:
    def __init__(
        self,
        any_field="",
        title="",
        author="",
        single_chapter=False,
        word_count=None,
        language="",
        fandoms="",
        rating=None,
        hits=None,
        kudos=None,
        crossovers=None,
        bookmarks=None,
        excluded_tags="",
        comments=None,
        completion_status=None,
        page=1,
        sort_column="",
        sort_direction="",
        revised_at="",
        characters="",
        relationships="",
        tags="",
        session=None):

        self.any_field = any_field
        self.title = title
        self.author = author
        self.single_chapter = single_chapter
        self.word_count = word_count
        self.language = language
        self.fandoms = fandoms
        self.characters = characters
        self.relationships = relationships
        self.tags = tags
        self.rating = rating
        self.hits = hits
        self.kudos = kudos
        self.crossovers = crossovers
        self.bookmarks = bookmarks
        self.excluded_tags = excluded_tags
        self.comments = comments
        self.completion_status = completion_status
        self.page = page
        self.sort_column = sort_column
        self.sort_direction = sort_direction
        self.revised_at = revised_at
        
        self.session = session

        self.results = None
        self.pages = 0
        self.total_results = 0




        

    @threadable.threadable
    def update(self):
        """ Envía una solicitud al sitio web de AO3 con los parámetros de búsqueda definidos, y actualiza toda la información. """
        soup = search(...)  # Realiza la búsqueda
        results = soup.find("ol", {"class": ("work", "index", "group")})
        
        if results is None and soup.find("p", text="No results found.") is not None:
            self.results = []
            self.total_results = 0
            self.pages = 0
            return

        works = []
        for work in results.find_all("li", {"role": "article"}):
            if work.h4 is None:
                continue
            new = get_work_from_banner(work)
            new._session = self.session
            works.append(new)

        self.results = works
        
        maindiv = soup.find("div", {"class": "works-search region", "id": "main"})
        total_results_text = maindiv.find("h3", {"class": "heading"}).getText()

        # Aquí usamos la función clean_and_convert_to_int para limpiar y convertir el valor
        self.total_results = self.clean_and_convert_to_int(total_results_text.split(" ")[0], field_name="total_results")
        # Lo mismo para otros campos
        self.word_count = self.clean_and_convert_to_int(work.word_count, field_name="word_count")

        self.pages = ceil(self.total_results / 20)

def search(
    any_field="",
    title="",
    author="",
    single_chapter=False,
    word_count=None,
    language="",
    fandoms="",
    rating=None,
    hits=None,
    kudos=None,
    crossovers=None,
    bookmarks=None,
    excluded_tags="",
    comments=None,
    completion_status=None,
    page=1,
    sort_column="",
    sort_direction="",
    revised_at="",
    session=None,
    characters="",
    relationships="",
    tags=""):
    """Returns the results page for the search as a Soup object

    Args:
        any_field (str, optional): Generic search. Defaults to "".
        title (str, optional): Title of the work. Defaults to "".
        author (str, optional): Authors of the work. Defaults to "".
        single_chapter (bool, optional): Only include one-shots. Defaults to False.
        word_count (AO3.utils.Constraint, optional): Word count. Defaults to None.
        language (str, optional): Work language. Defaults to "".
        fandoms (str, optional): Fandoms included in the work. Defaults to "".
        characters (str, optional): Characters included in the work. Defaults to "".
        relationships (str, optional): Relationships included in the work. Defaults to "".
        tags (str, optional): Additional tags applied to the work. Defaults to "".
        rating (int, optional): Rating for the work. 9 for Not Rated, 10 for General Audiences, 11 for Teen And Up Audiences, 12 for Mature, 13 for Explicit. Defaults to None.
        hits (AO3.utils.Constraint, optional): Number of hits. Defaults to None.
        kudos (AO3.utils.Constraint, optional): Number of kudos. Defaults to None.
        crossovers (bool, optional): If specified, if false, exclude crossovers, if true, include only crossovers
        bookmarks (AO3.utils.Constraint, optional): Number of bookmarks. Defaults to None.
        excluded_tags (str, optional): Tags to exclude. Defaults to "".
        comments (AO3.utils.Constraint, optional): Number of comments. Defaults to None.
        page (int, optional): Page number. Defaults to 1.
        sort_column (str, optional): Which column to sort on. Defaults to "".
        sort_direction (str, optional): Which direction to sort. Defaults to "".
        revised_at (str, optional): Show works older / more recent than this date. Defaults to "".
        session (AO3.Session, optional): Session object. Defaults to None.

    Returns:
        bs4.BeautifulSoup: Search result's soup
    """

    query = utils.Query()
    query.add_field(f"work_search[query]={any_field if any_field != '' else ' '}")
    if page != 1:
        query.add_field(f"page={page}")
    if title != "":
        query.add_field(f"work_search[title]={title}")
    if author != "":
        query.add_field(f"work_search[creators]={author}")
    if single_chapter:
        query.add_field(f"work_search[single_chapter]=1")
    if word_count is not None:
        query.add_field(f"work_search[word_count]={word_count}")
    if language != "":
        query.add_field(f"work_search[language_id]={language}")
    if fandoms != "":
        query.add_field(f"work_search[fandom_names]={fandoms}")
    if characters != "":
        query.add_field(f"work_search[character_names]={characters}")
    if relationships != "":
        query.add_field(f"work_search[relationship_names]={relationships}")
    if tags != "":
        query.add_field(f"work_search[freeform_names]={tags}")
    if rating is not None:
        query.add_field(f"work_search[rating_ids]={rating}")
    if hits is not None:
        query.add_field(f"work_search[hits]={hits}")
    if kudos is not None:
        query.add_field(f"work_search[kudos_count]={kudos}")
    if crossovers is not None:
        query.add_field(f"work_search[crossover]={'T' if crossovers else 'F'}")
    if bookmarks is not None:
        query.add_field(f"work_search[bookmarks_count]={bookmarks}")
    if excluded_tags != "":
        query.add_field(f"work_search[excluded_tag_names]={excluded_tags}")
    if comments is not None:
        query.add_field(f"work_search[comments_count]={comments}")
    if completion_status is not None:
        query.add_field(f"work_search[complete]={'T' if completion_status else 'F'}")
    if sort_column != "":
        query.add_field(f"work_search[sort_column]={sort_column}")
    if sort_direction != "":
        query.add_field(f"work_search[sort_direction]={sort_direction}")
    if revised_at != "":
        query.add_field(f"work_search[revised_at]={revised_at}")

    url = f"https://archiveofourown.org/works/search?{query.string}"

    if session is None:
        req = requester.request("get", url)
    else:
        req = session.get(url)
    if req.status_code == 429:
        raise utils.HTTPError("We are being rate-limited. Try again in a while or reduce the number of requests")
    soup = BeautifulSoup(req.content, features="lxml")
    return soup