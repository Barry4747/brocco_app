import math
import random
from uuid import uuid5
from collections import defaultdict
from config import *


def fetch_source_data(supabase):
    categories = supabase.table(TABLE_CATEGORIES).select(SELECT_CATEGORIES).execute().data
    recipes = supabase.table(TABLE_RECIPES).select(SELECT_RECIPES).execute().data
    ingredients = supabase.table(TABLE_INGREDIENTS).select(SELECT_INGREDIENTS).execute().data
    return categories, recipes, ingredients


def get_ingredient_counts(ingredients):
    ingredient_counts = defaultdict(int)
    for ingredient in ingredients:
        ingredient_counts[ingredient[KEY_RECIPE_ID]] += ONE
    return ingredient_counts


def map_categories_by_area(categories):
    area_to_categories = defaultdict(list)
    for category in categories:
        area_to_categories[category[KEY_CATEGORY_AREA]].append(category)
    return area_to_categories


def pick_target_category(recipe, categories_in_area):
    recipe_category = recipe.get(KEY_CATEGORY)

    for category in categories_in_area:
        if category[KEY_CATEGORY_TYPE] == recipe_category:
            return category

    for category in categories_in_area:
        if category[KEY_CATEGORY_TYPE] == CATEGORY_TYPE_WILDCARD:
            return category

    return None


def map_recipes_to_categories(recipes, area_to_categories):
    category_to_recipes = defaultdict(list)

    for recipe in recipes:
        categories_in_area = area_to_categories.get(recipe.get(KEY_AREA), [])
        target_category = pick_target_category(recipe, categories_in_area)
        if target_category:
            category_to_recipes[target_category[KEY_ID]].append(recipe)

    return category_to_recipes


def split_recipes_into_columns(recipes, rng):
    total_recipes = len(recipes)
    max_nodes_per_column = max(ONE, math.ceil(total_recipes / COLUMN_DIVISOR))

    columns = []
    current_index = ZERO
    while current_index < total_recipes:
        remaining = total_recipes - current_index
        column_size = rng.randint(ONE, min(max_nodes_per_column, remaining))
        columns.append(recipes[current_index: current_index + column_size])
        current_index += column_size

    return columns


def build_node(category_id, recipe, map_column, map_row, prerequisite_ids):
    node_id = str(uuid5(NODE_UUID_NAMESPACE, f"{category_id}{NODE_ID_SEPARATOR}{recipe[KEY_ID]}"))
    return {
        KEY_ID: node_id,
        KEY_CATEGORY_ID: category_id,
        KEY_RECIPE_ID: recipe[KEY_ID],
        KEY_TITLE: recipe[KEY_TITLE],
        KEY_PREVIEW_IMAGE_URL: recipe.get(KEY_IMAGE_URL, DEFAULT_PREVIEW_IMAGE_URL),
        KEY_MAP_COLUMN: map_column,
        KEY_MAP_ROW: map_row,
        KEY_PREREQUISITE_IDS: prerequisite_ids,
    }


def pick_prerequisite_ids(previous_column_nodes, rng):
    if not previous_column_nodes:
        return []

    prerequisite_count = rng.randint(ONE, min(TWO, len(previous_column_nodes)))
    parent_nodes = rng.sample(previous_column_nodes, prerequisite_count)
    return [parent[KEY_ID] for parent in parent_nodes]


def build_nodes_for_category(category_id, recipes, ingredient_counts):
    sorted_recipes = sorted(recipes, key=lambda recipe: ingredient_counts.get(recipe[KEY_ID], ZERO))
    rng = random.Random(category_id)
    columns = split_recipes_into_columns(sorted_recipes, rng)

    nodes = []
    previous_column_nodes = []

    for column_index, column_recipes in enumerate(columns):
        current_column_nodes = []
        for row_index, recipe in enumerate(column_recipes):
            prerequisite_ids = pick_prerequisite_ids(previous_column_nodes, rng)
            node = build_node(category_id, recipe, column_index, row_index, prerequisite_ids)
            nodes.append(node)
            current_column_nodes.append(node)
        previous_column_nodes = current_column_nodes

    return nodes


def build_nodes_to_insert(category_to_recipes, ingredient_counts):
    nodes_to_insert = []

    for category_id, recipes in category_to_recipes.items():
        if not recipes:
            continue
        nodes_to_insert.extend(build_nodes_for_category(category_id, recipes, ingredient_counts))

    return nodes_to_insert


def upsert_nodes(supabase, nodes_to_insert):
    if not nodes_to_insert:
        return ZERO

    supabase.table(TABLE_ROADMAP_NODES).upsert(nodes_to_insert).execute()
    return len(nodes_to_insert)

