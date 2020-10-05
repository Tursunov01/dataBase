from faker import Faker
from random import randint
from random import choice

MAX = 1000
sex = ['male', 'female']
foot = ['left', 'right']
positions = ['GK', 'CB', 'RB', 'LB', 'SW', 'RWB', 'LWB', 'CDM', 'RM', 
            'LM', 'CF', 'RF', 'LF', 'RS', 'LS', "ST", 'CAM', 'LWM', 'RWM']

def generateFootballers():
    faker = Faker()
    f = open('footballers.csv', 'w')
    for i in range(1000):
        rating = randint(0, 99)
        line = "{0},{1},{2},{3},{4}\n".format(
                                                  faker.name(),
                                                  choice(sex),
                                                  faker.date(),
                                                  choice(foot),
                                                  rating)
        f.write(line)
    f.close()

def generateClubs():
    faker = Faker()
    f = open('clubs.csv', 'w')
    for i in range(1000):
        rating = randint(50, 99)
        uniorsNum = randint(0, 50)
        trophiesNum = randint(0, 20)
        line = "{0} FC,{1},{2},{3}\n".format(faker.city(), rating, trophiesNum, uniorsNum)
        f.write(line)
    f.close()

def generateAgents():
    faker = Faker()
    f = open('agents.csv', 'w')
    for i in range(1000):
        rating = randint(30, 99)
        clients = randint(0, 40)
        cost = randint(100, 5000)
        line = "{0},{1},{2},{3},{4}\n".format(
                                                  faker.name(),
                                                  faker.date(),
                                                  rating,
                                                  clients,
                                                  cost)
        f.write(line)
    f.close()

def generateTransfers():
    f = open('transfers.csv', 'w')
    for i in range(1000):
        line = "{0},{1},{2},{3}\n".format(randint(1, MAX-1), randint(1, MAX-1), randint(1, MAX-1), choice(positions))
        f.write(line)
    f.close()


if __name__ == "__main__":
    generateFootballers()
    generateClubs()
    generateAgents()
    generateTransfers()

