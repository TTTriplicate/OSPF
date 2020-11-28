#!/usr/bin/python

from collections import deque
import mysql.connector, time

def connect():
    #connects to the database in order to read node and edge data 
    try:
        conn = mysql.connector.connect(
            host="mysql",
            database="dijkstra",
            user="dijkstra",
            password="G3n3r1cP@ssw0rd!"
        )
    except mysql.connector.Error as err:
        #this boots way faster than the DB in Docker even with a dependency statement, automating restart
        print("Something went wrong: {}".format(err))
        time.sleep(15)
        return connect()

    return conn

def routingTable(start, values, pending):
    '''
Given a node to check paths from, a set of current path values, and the queue of pending
nodes to check, check the nodes adjacent to the current node to see if a path formed here
is shorter than any previous path.  Updates values, and appends any updated nodes to the queue to 
check or recheck.
    '''
    conn = connect()
    cursor = conn.cursor()
    cursor.execute("SELECT weight, destination FROM edges WHERE source=%s", (start,))
    for result in cursor:
        if values[result[1]][1] > (values[start][1] + result[0]) or values[result[1]][1] == -1: 
            values.update({result[1] : ( (values[start][0] + result[1]), (values[start][1] + result[0]))})
            pending.append(result[1])


def nodesMap():
    #Gets the nodes from the DB and makes a dict, with initial values set to 0
    conn = connect()
    cursor = conn.cursor()
    cursor.execute("SELECT node_id from nodes ORDER BY node_id asc")
    nodes = {}
    for result in cursor:
        nodes.update({result[0] : ('a', -1)})
    
    return nodes

values = nodesMap()
pending = deque()
pending.append('a')
values.update({'a' : ('a',0)})

while len(pending) > 0:
    print(values)
    routingTable(pending.popleft(), values, pending)

