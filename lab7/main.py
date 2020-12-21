from peewee import *
from peewee import fn
from playhouse.shortcuts import model_to_dict, dict_to_model
import json


conn = PostgresqlDatabase(database = 'postgres', user = 'postgres',
                          password = '6hhv48tt', host = 'localhost')

class BaseModel(Model):
    class Meta:
        database = conn

class Footballers(BaseModel):
    id = AutoField(column_name='id')
    name = TextField(column_name='name', null=False)
    foot = TextField(column_name='foot', null=False)
    sex = TextField(column_name='sex', null=False)
    rating = TextField(column_name='rating', null=False)
    birthday = TextField(column_name='birthday', null=False)
    class Meta:
        table_name = 'footballers'
class FootballersCopy(BaseModel):
    id = AutoField(column_name='id')
    name = TextField(column_name='name', null=False)
    foot = TextField(column_name='foot', null=False)
    sex = TextField(column_name='sex', null=False)
    rating = TextField(column_name='rating', null=False)
    birthday = TextField(column_name='birthday', null=False)
    class Meta:
        table_name = 'footballers_copy'


class Agents(BaseModel):
    id = AutoField(column_name='id')
    name = TextField(column_name='name', null=False)
    cost = TextField(column_name='cost', null=False)
    rating = TextField(column_name='rating', null=False)
    clients_num = TextField(column_name='clientsnum', null=False)
    class Meta:
        table_name = 'agents'

class Transfers(BaseModel):
    id = AutoField(column_name='id')
    footballer = TextField(column_name='footballer', null=False)
    club = TextField(column_name='club', null=False)
    agent = TextField(column_name='agent', null=False)
    position = TextField(column_name='position', null=False)
    class Meta:
        table_name = 'transfers'

class Orders(BaseModel):
    id = AutoField(column_name='id')
    jjson = TextField(column_name='data', null=False)
    customer = TextField(column_name='customer', null=False)
    items = TextField(column_name='items', null=False)
    class Meta:
        table_name = 'orders'

    

def first():
    query1 = Footballers.select().where(Footballers.sex == 'male').limit(10).order_by(Footballers.rating.desc())
    
    query2 = Footballers.select(Footballers.name, Footballers.rating).distinct().where(Footballers.rating.between(95,99))
    
    query3 = Agents.select(Agents.name).where(Agents.name%'Thomas%').distinct()
    
    query4 = Agents.get(Agents.clients_num == 20)
    # print("Agent: ", query4.name, query4.clients_num, query4.cost)

    query5 = Agents.select(Agents.name, fn.avg(Agents.cost).alias('total')).where(Agents.cost >'total').group_by(Agents.name)
    
    cases =  Case(None, (
        (Footballers.rating < 30, 'Low'),
        (Footballers.rating.between(50,70) , 'Middle'),
        (Footballers.rating.between(85, 99), 'High')), 
        'ni tuda ni syuda')
    query6 = Footballers.select(Footballers.name, cases.alias('lvl')).limit(10)

    selected = query1.dicts().execute()
    for footballer in selected:
        print(footballer)

def make_json():
    user = Footballers.select().limit(1).get()
    json_data = json.dumps(model_to_dict(user))
    print(json_data)

def second():
    # добавление json в таблицу
    Orders.create(jjson = '{"items": {"product": "Zenbook","qty": 1}, "customer": "Lika"}')
    # обновление поля json 
    product = Orders(jjson = '{"items": {"product": "Zenbook","qty": 1}, "customer": "Jojua"}')
    product.id = 11
    product.save()
    # чтение
    user = dict_to_model(Orders, {"items": {"product": "Zenbook","qty": 1}, "customer": "Jojua"})
    print(user.customer)


def third():
    # добавление json в таблицу
    Footballers.create(id = '1111', name = 'Vinisius', foot = 'left', sex = 'male', rating =  '83', birthday = '2000-06-28')
    # обновление поля json 
    query = Footballers(name = 'Rodrygo', foot = 'left', sex = 'male', rating =  '87', birthday = '2000-06-28')
    query.id = 1111
    query.save()
    # удаление 
    query = Footballers.delete().where(Footballers.id == 1111)
    query.execute()
    # вызов хранимой процедуры
    conn.execute_sql('call update_clients_num()')
    #однотабличный запрос
    query = Agents.select(Agents.name, Agents.cost, Agents.clients_num).where(Agents.name%'Thomas%').distinct()
    # многотабличный запрос
    query = (Transfers
                .select(Transfers.footballer, Footballers.name)
                .join(Footballers, on = (Transfers.footballer == Footballers.id)).alias('tmp')
                .where(Transfers.position == 'GK')
    )
    selected = query.dicts().execute()
    for footballer in selected:
        print(footballer)

third()   

conn.close()

            