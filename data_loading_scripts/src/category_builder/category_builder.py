import logging
import os
from collections import defaultdict

from config import *
from dotenv import load_dotenv
from supabase import create_client, Client

from utils import round_to_nearest_base


def generate_and_insert_categories():
    load_dotenv()
    supabase_url = os.environ.get(SUPABASE_URL_ENV)
    supabase_key = os.environ.get(SUPABASE_KEY_ENV)
    supabase: Client = create_client(supabase_url, supabase_key)

    logger = logging.getLogger(__name__)
    logging.basicConfig(level=logging.INFO)

    logger.info("Fetching recipes from the database...")
    response = supabase.table(RECIPES_TABLE).select(RECIPES_SELECT_COLUMNS).execute()
    recipes = response.data

    if not recipes:
        logger.error("No recipes found in the database. Run the MealDB loader first.")
        return

    area_groups = defaultdict(list)
    for recipe in recipes:
        area = recipe.get("area")
        if not area or area == UNKNOWN_AREA:
            continue
        area_groups[area].append(recipe)

    categories_to_insert = []

    for area, area_recipes in area_groups.items():
        total_in_area = len(area_recipes)

        if total_in_area < SMALL_AREA_RECIPE_THRESHOLD:
            cost = round_to_nearest_base(total_in_area * STARS_MULTIPLIER)
            categories_to_insert.append(
                {
                    "title": f"{area} {CLASSICS_SUFFIX}",
                    "subtitle": EMPTY_SUBTITLE,
                    "image_url": area_recipes[0].get("image_url", EMPTY_IMAGE_URL),
                    "unlock_cost_stars": cost,
                    "category_area": area,
                    "category_type": ALL_CATEGORY_TYPE,
                }
            )
            continue

        cat_groups = defaultdict(list)
        for recipe in area_recipes:
            category = recipe.get("category")
            if category:
                cat_groups[category].append(recipe)

        specials_recipes = []

        for category_name, cat_recipes in cat_groups.items():
            count = len(cat_recipes)

            if count > STRONG_CATEGORY_RECIPE_THRESHOLD:
                cost = round_to_nearest_base(count * STARS_MULTIPLIER)
                categories_to_insert.append(
                    {
                        "title": f"{area} {category_name}",
                        "subtitle": EMPTY_SUBTITLE,
                        "image_url": cat_recipes[0].get("image_url", EMPTY_IMAGE_URL),
                        "unlock_cost_stars": cost,
                        "category_area": area,
                        "category_type": category_name,
                    }
                )
            else:
                specials_recipes.extend(cat_recipes)

        if specials_recipes:
            cost = round_to_nearest_base(len(specials_recipes) * STARS_MULTIPLIER)
            categories_to_insert.append(
                {
                    "title": f"{area} {SPECIALS_SUFFIX}",
                    "subtitle": EMPTY_SUBTITLE,
                    "image_url": specials_recipes[0].get("image_url", EMPTY_IMAGE_URL),
                    "unlock_cost_stars": cost,
                    "category_area": area,
                    "category_type": ALL_CATEGORY_TYPE,
                }
            )

    try:
        if categories_to_insert:
            supabase.table(CATEGORIES_TABLE).delete().neq("id", DELETE_ALL_SENTINEL_ID).execute()
            supabase.table(CATEGORIES_TABLE).insert(categories_to_insert).execute()
            logger.info(
                f"Success! Generated and inserted {len(categories_to_insert)} new worlds (categories)."
            )

            for category in categories_to_insert:
                print(
                    f"{category['title']} | Stars: {category['unlock_cost_stars']} | "
                    f"Area: {category['category_area']} | Type: {category['category_type']}"
                )
    except Exception as error:
        logger.error(f"Error while inserting categories: {error}")



if __name__ == "__main__":
    generate_and_insert_categories()
