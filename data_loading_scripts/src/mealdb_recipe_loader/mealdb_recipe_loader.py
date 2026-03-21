import logging
import os
from dotenv import load_dotenv
import requests
from utils import *
from config import *
from supabase import create_client, Client

load_dotenv()

SUPABASE_URL = os.environ.get("SUPABASE_URL")
SUPABASE_KEY = os.environ.get("SUPABASE_KEY")

if not SUPABASE_URL or not SUPABASE_KEY:
    raise ValueError("Missing Supabase credentials. Check your .env file.")

supabase: Client = create_client(SUPABASE_URL, SUPABASE_KEY)

logger = logging.getLogger(__name__)
logging.basicConfig(level=logging.INFO)


def process_and_insert_meals(meals):
    recipes_to_insert = []
    ingredients_to_insert = []

    for meal in meals:
        original_id = meal.get("idMeal")
        recipe_id = str(uuid.uuid5(uuid.NAMESPACE_OID, f"mealdb_{original_id}"))

        meal_ingredients = extract_ingredients(meal, recipe_id, original_id)
        ingredients_to_insert.extend(meal_ingredients)

        ingredient_count = len(meal_ingredients)

        difficulty = calculate_difficulty(ingredient_count)
        duration = calculate_duration(ingredient_count)
        description = generate_description(meal)

        raw_tags = meal.get("strTags")
        tags_list = [tag.strip() for tag in raw_tags.split(',')] if raw_tags else []

        recipes_to_insert.append({
            "id": recipe_id,
            "title": meal.get("strMeal"),
            "description": description,
            "recipe_plaintext": meal.get("strInstructions"),
            "image_url": meal.get("strMealThumb"),
            "difficulty_level": difficulty,
            "duration_minutes": duration,
            "youtube_url": meal.get("strYoutube"),
            "tags": tags_list,
            "category": meal.get("strCategory"),
            "area": meal.get("strArea"),
            "source_url": meal.get("strSource")
        })

    try:
        if recipes_to_insert:
            supabase.table('recipes').upsert(recipes_to_insert).execute()
        if ingredients_to_insert:
            supabase.table('ingredients').upsert(ingredients_to_insert).execute()
        logger.info(
            f'Uploaded/Updated {len(recipes_to_insert)} recipes and {len(ingredients_to_insert)} ingredients.')
    except Exception as e:
        logger.error(f"Error while inserting to database: {e}")


def main():
    print("Hello from mealdb-data-loader!")
    total_inserted = 0

    for letter in ALPHABET:
        logger.info('Processing letter {}'.format(letter))
        current_request_string = REQUEST_STRING.format(letter)

        response = requests.get(current_request_string)
        response.raise_for_status()
        data = response.json()

        items = data.get("meals", [])

        if not items:
            logger.warning('No items found for letter {}'.format(letter))
            continue

        logger.info('Found {} items for letter {}'.format(len(items), letter))

        process_and_insert_meals(items)
        total_inserted += len(items)

    print(f"\nFinished! Processed a total of {total_inserted} meals.")


if __name__ == "__main__":
    main()
