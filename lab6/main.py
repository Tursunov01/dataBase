import psycopg2
from contextlib import closing
from psycopg2.extras import DictCursor
from psycopg2.extras import execute_values


def commands(code):
    with closing(psycopg2.connect(dbname = 'postgres', user = 'postgres',
                                  password = '6hhv48tt', host = 'localhost')) as conn:
        with conn.cursor(cursor_factory=DictCursor) as cursor:
            conn.autocommit = True
            if code == 1:
                cursor.execute('select name from footballers where rating = (select max(rating) from footballers) limit 1')
                for row in cursor:
                    print(row[0])
            if code == 2:
                cursor.execute("""select footballers.name, transfers.position, agents.name
                                  from transfers
                                  join footballers on footballers.id = transfers.footballer
                                  join agents on agents.id = transfers.agent 
                                  limit 5;""")
                for row in cursor:
                    print(row[0])
            if code == 3:
                cursor.execute("""
                                  With cte as
                                  (select name, rating, cost, avg(cost) over (partition by rating)
                                    from agents )
                                    select * from cte limit 5;""")
                for row in cursor:
                    print(row)
            if code == 4:
                cursor.execute("""select table_catalog, table_schema, table_name, table_type from information_schema.tables where table_schema = 'public'""")
                for row in cursor:
                    print(row)
            if code == 5:
                cursor.callproc('getFootballer')
                for row in cursor:
                    print(row)
            if code == 6:
                cursor.callproc('getFootballerTable', ['left'])
                records = cursor.fetchmany(size=5)
                for row in records:
                    print(row)
            if code == 7:
                cursor.execute('select * into temp footballers_copy from footballers;')
                cursor.execute('call update_rating();')
                cursor.execute("""select footballers.name, footballers.foot, footballers.rating as before_update, footballers_copy.rating as after_update
                                  from footballers_copy join footballers on footballers_copy.id = footballers.id order by footballers_copy.rating desc limit 10""")
                for row in cursor:
                    print(row)
            if code == 8:
                cursor.execute('select current_user;')
                record1 = cursor.fetchone()
                cursor.execute('select version();')
                record2 = cursor.fetchone()
                print("USER: ", record1)
                print("VERSION: ", record2)
            if code == 9:
                cursor.execute("""create table if not exists tournaments
                                  (
                                      name varchar(30),
                                      quality int,
                                      quantity_clubs int,
                                      price varchar
                                  )
                                    """)
            if code == 10:
                namedict = [("Bundesliga", 5, 18, "1B"),
                            ("La Liga", 5, 20, "2B"),
                            ("Seria A", 4, 20, "0.5B"),
                            ("Tinkoff RFL", 3, 16, "150M"),
                            ("Premier League", 5, 20, "3B"),
                            ("Ligue 1", 4, 18, "1B")]
                execute_values(cursor, "insert into tournaments(name,quality, quantity_clubs,price) values %s", namedict)

def printMenu():
    print("--------------------------------------------")
    print("|                   MENU                   |")
    print("1) Скалярный запрос")
    print("2) Запрос с несколькими соединениями(JOIN)")
    print("3) Запрос с ОТВ(СТЕ) и оконными функциями")
    print("4) Запрос к метаданным")
    print("5) Скалярная функция(3 лаба)")
    print("6) Многооператорную функция(3 лаба)")
    print("7) Хранимая процедура")
    print("8) Вызов системной функции или процедуры")
    print("9) Создание таблице")
    print("10) Вставка в созданную таблицу")
    print("11) Выход")
    print("\n")


def main():
    code = 1
    while code != 0:
        printMenu()
        code = int(input("Input: "))
        commands(code)
        if code != 0:
            a = input("Would you like to continue? [y/n]  ")
            if a == "n":
                code = 0


if __name__ == "__main__":
    main()