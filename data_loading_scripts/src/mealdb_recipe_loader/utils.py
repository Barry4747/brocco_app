import re
import uuid
from config import *


def parse_measurement(measure_str):
    if not measure_str or not str(measure_str).strip():
        return None, None

    measure_str = str(measure_str).strip()
    match = re.match(r'^(\d+(?:\.\d+)?|\d+\s+\d+\/\d+|\d+\/\d+)\s*(.*)', measure_str)

    amount = None
    unit = measure_str

    if match:
        num_str = match.group(1).strip()
        unit = match.group(2).strip()

        try:
            if '/' in num_str:
                parts = num_str.split()
                if len(parts) == 2:
                    amount = float(parts[0]) + (float(parts[1].split('/')[0]) / float(parts[1].split('/')[1]))
                else:
                    amount = float(parts[0].split('/')[0]) / float(parts[0].split('/')[1])
            else:
                amount = float(num_str)
        except ValueError:
            amount = None
            unit = measure_str

    return amount, unit if unit else DEFAULT_MEASURE


def generate_description(meal):
    area = meal.get("strArea", DEFAULT_AREA)
    category = meal.get("strCategory", DEFAULT_CATEGORY)
    return DEFAULT_DESC_STRING.format(area, category.lower())


def calculate_difficulty(ingredient_count):
    if ingredient_count < SECOND_DIFF_THRESHOLD:
        return FIRST_DIFF_LEVEL
    elif ingredient_count < THIRD_DIFF_THRESHOLD:
        return SECOND_DIFF_LEVEL
    return THIRD_DIFF_LEVEL


def calculate_duration(ingredient_count):
    raw_time = RAW_BASE_TIME + (ingredient_count * INGREDIENT_TIME_MODIFIER)
    return 5 * round(raw_time / 5)


def extract_ingredients(meal, recipe_id, original_id):
    extracted = []
    sort_idx = 1

    for i in range(1, 21):
        ing_name = meal.get(f"strIngredient{i}")
        ing_measure = meal.get(f"strMeasure{i}")

        if not ing_name or not str(ing_name).strip():
            continue

        amount, unit = parse_measurement(ing_measure)
        ing_id = str(uuid.uuid5(uuid.NAMESPACE_OID, f"mealdb_{original_id}_ing_{i}"))

        extracted.append({
            "id": ing_id,
            "recipe_id": recipe_id,
            "name": str(ing_name).strip().lower(),
            "amount": amount,
            "unit": unit,
            "sort_order": sort_idx
        })
        sort_idx += 1

    return extracted
