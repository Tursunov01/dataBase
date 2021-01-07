import json
from faker import Faker
from time import sleep
from datetime import datetime
from random import randint, choice

sex_arr = ['male', 'female']
foot_arr = ['left', 'right', 'both']
N_MAX = 10

def generate_footballer():
    faker = Faker()
    name = faker.name()
    sex = choice(sex_arr)
    birthday = faker.date()
    foot = choice(foot_arr)
    rating = randint(0,99)

    rec = {
        'id': randint(1000, 9000),
        'name': name,
        'sex': sex,
        'birthday': birthday,
        'foot': foot,
        'rating': rating
    }

    return json.dumps(rec)


if __name__ == "__main__":
    file_id = 1
    table = "footballers"
    while True:
        time = datetime.now().strftime("%Y-%m-%d_%H.%M.%S")
        with open(f"{file_id}_{table}_{time}.json", "w") as file: 
            file.write(generate_footballer() + '\n' + generate_footballer())
        file_id += 1
        sleep(15)