import logging
import uuid

ENV_SUPABASE_URL = "SUPABASE_URL"
ENV_SUPABASE_KEY = "SUPABASE_KEY"

LOG_LEVEL = logging.INFO
LOG_FETCHING_DATA = "Fetching data from database..."
LOG_GENERATING_DAGS = "Generating DAGs for each map..."
LOG_SUCCESS_TEMPLATE = "Success! Generated and uploaded {count} roadmap nodes."
ERROR_NO_DATA = "No categories or recipes found. Run previous scripts first."
ERROR_INSERT_TEMPLATE = "Error while inserting nodes: {error}"

TABLE_CATEGORIES = "categories"
TABLE_RECIPES = "recipes"
TABLE_INGREDIENTS = "ingredients"
TABLE_ROADMAP_NODES = "roadmap_nodes"

SELECT_CATEGORIES = "id, category_area, category_type"
SELECT_RECIPES = "id, title, image_url, area, category"
SELECT_INGREDIENTS = "recipe_id"

KEY_ID = "id"
KEY_RECIPE_ID = "recipe_id"
KEY_CATEGORY_ID = "category_id"
KEY_CATEGORY_AREA = "category_area"
KEY_CATEGORY_TYPE = "category_type"
KEY_AREA = "area"
KEY_CATEGORY = "category"
KEY_TITLE = "title"
KEY_IMAGE_URL = "image_url"
KEY_PREVIEW_IMAGE_URL = "preview_image_url"
KEY_MAP_COLUMN = "map_column"
KEY_MAP_ROW = "map_row"
KEY_PREREQUISITE_IDS = "prerequisite_ids"

CATEGORY_TYPE_WILDCARD = "*"
DEFAULT_PREVIEW_IMAGE_URL = ""
NODE_ID_SEPARATOR = "_"
NODE_UUID_NAMESPACE = uuid.NAMESPACE_OID

ZERO = 0
ONE = 1
TWO = 2
COLUMN_DIVISOR = 4.0

