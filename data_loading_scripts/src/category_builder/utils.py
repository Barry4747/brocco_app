from config import *

def round_to_nearest_base(number):
    return ROUNDING_BASE * round(number / ROUNDING_BASE)
