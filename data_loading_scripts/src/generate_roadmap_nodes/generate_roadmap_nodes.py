import os
from dotenv import load_dotenv
from supabase import create_client, Client
from config import *
from utils import (
    fetch_source_data,
    get_ingredient_counts,
    map_categories_by_area,
    map_recipes_to_categories,
    build_nodes_to_insert,
    upsert_nodes,
)

load_dotenv()
SUPABASE_URL = os.environ.get(ENV_SUPABASE_URL)
SUPABASE_KEY = os.environ.get(ENV_SUPABASE_KEY)

supabase: Client = create_client(SUPABASE_URL, SUPABASE_KEY)
logger = logging.getLogger(__name__)
logging.basicConfig(level=LOG_LEVEL)


def generate_roadmap_nodes():
    logger.info(LOG_FETCHING_DATA)
    categories, recipes, ingredients = fetch_source_data(supabase)

    if not categories or not recipes:
        logger.error(ERROR_NO_DATA)
        return

    ingredient_counts = get_ingredient_counts(ingredients)
    area_to_categories = map_categories_by_area(categories)
    category_to_recipes = map_recipes_to_categories(recipes, area_to_categories)

    logger.info(LOG_GENERATING_DAGS)
    nodes_to_insert = build_nodes_to_insert(category_to_recipes, ingredient_counts)

    try:
        inserted_count = upsert_nodes(supabase, nodes_to_insert)
        if inserted_count:
            logger.info(LOG_SUCCESS_TEMPLATE.format(count=inserted_count))
    except Exception as error:
        logger.error(ERROR_INSERT_TEMPLATE.format(error=error))


if __name__ == "__main__":
    generate_roadmap_nodes()
