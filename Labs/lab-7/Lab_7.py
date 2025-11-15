import sqlite3
from sqlite3 import Error


def openConnection(_dbFile):
    print("++++++++++++++++++++++++++++++++++")
    print("Open database: ", _dbFile)

    conn = None
    try:
        conn = sqlite3.connect(_dbFile)
        # conn = sqlite3.connect(_dbFile, autocommit=False)
        print("success")
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")

    return conn

def closeConnection(_conn, _dbFile):
    print("++++++++++++++++++++++++++++++++++")
    print("Close database: ", _dbFile)

    try:
        _conn.close()
        print("success")
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def createTable(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create table")

    sql = """

    CREATE TABLE IF NOT EXISTS warehouse (w_warehousekey REAL,
        w_name TEXT,
        w_capacity REAL,
        w_suppkey REAL,
        w_nationkey REAL);

    """

    _conn.execute(sql)
    _conn.commit()

    print("++++++++++++++++++++++++++++++++++")


def dropTable(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Drop tables")

    sql = """

    DROP TABLE IF EXISTS warehouse;

    """

    print("++++++++++++++++++++++++++++++++++")


def populateTable(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Populate table")

    num_lineitems_sold_per_nation_supplier = """

        SELECT s_suppkey, s_name, n_nationkey, n_name, COUNT(*) AS num_sold
        FROM supplier, lineitem, orders, customer, nation
        WHERE s_suppkey=l_suppkey
            AND l_orderkey=o_orderkey
            AND o_custkey=c_custkey
            AND c_nationkey=n_nationkey
        GROUP BY s_suppkey, n_nationkey
        ORDER By num_sold DESC, n_name ASC;

    """

    cursor = _conn.execute(num_lineitems_sold_per_nation_supplier)
    rows = cursor.fetchall()

    top3_nations_per_supplier = dict()
    suppkey_name = dict()
    nationkey_name = dict()

    for row in rows:
        print(row)
        s_suppkey, s_name, n_nationkey, n_name, count = row 
        
        if s_suppkey not in top3_nations_per_supplier:
            top3_nations_per_supplier[s_suppkey] = [n_nationkey]
        elif len(top3_nations_per_supplier[s_suppkey]) < 3:
            top3_nations_per_supplier[s_suppkey].append(n_nationkey)

        suppkey_name[s_suppkey] = s_name
        nationkey_name[n_nationkey] = n_name

    print(top3_nations_per_supplier)


# SELECT s_suppkey, s_name, n_nationkey, n_name, 3 * MAX(total_sizes) as capacity
    capacity_per_supplier = """
        
        SELECT s_suppkey, s_name, n_nationkey, n_name, 3 * MAX(capacity)
        FROM (SELECT s_suppkey, s_name, n_nationkey, n_name, 3 * TOTAL(p_size) as capacity
        FROM supplier, lineitem, orders, customer, nation, part
        WHERE s_suppkey=l_suppkey
            AND l_orderkey=o_orderkey
            AND o_custkey=c_custkey
            AND c_nationkey=n_nationkey
            AND l_partkey=p_partkey
        GROUP BY s_suppkey, n_nationkey
        )
        GROUP BY s_suppkey;

    """

    cursor.execute(capacity_per_supplier)
    rows = cursor.fetchall()

    capacity_per_supplier = dict()
    for row in rows:
        print(row)
        s_suppkey, s_name, n_nationkey, n_name, capacity = row 
        capacity_per_supplier[s_suppkey] = capacity
    
    print(capacity_per_supplier)

    insert_sql = """
    INSERT INTO warehouse(w_warehousekey, w_name, w_capacity, w_suppkey, w_nationkey)
    VALUES (?, ?, ?, ?, ?)"""

    warehousekey = 0
    for s_suppkey, top3 in top3_nations_per_supplier.items():
        for n_nationkey in top3:
            s_name = suppkey_name[s_suppkey]
            n_name = nationkey_name[n_nationkey]
            w_name = s_name + "____" + n_name
            w_capacity = capacity_per_supplier[s_suppkey]

            params = (warehousekey, w_name, w_capacity, s_suppkey, n_nationkey)
            print(params)
            warehousekey += 1
            cursor.execute(insert_sql, params)

    _conn.commit()

    print("++++++++++++++++++++++++++++++++++")


def Q1(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q1")

    try:
        output = open('output/1.out', 'w')

        header = "{:>10} {:<40} {:>10} {:>10} {:>10}"
        output.write((header.format("wId", "wName", "wCap", "sId", "nId")) + '\n')

        # Q1 displays the entire content of the warehouse table sorted on w warehousekey by performing a SQL query.

        # sqlite3 data/tpch.sqlite
        # .schema warehouse

        # CREATE TABLE warehouse (w_warehousekey decimal(9,0) not null,w_name char(100) not null,
        # w_capacity decimal(6,0) not null,w_suppkey decimal(9,0) not null,w_nationkey decimal(2,0) not null);

        sql = """
            SELECT w_warehousekey, w_name, w_capacity, w_suppkey, w_nationkey
            FROM warehouse
            ORDER BY w_warehousekey;
        """

        # _conn.execute(sql)
        # _conn.commit()

        cursor = _conn.execute(sql)
        rows = cursor.fetchall()

        for row in rows:
            output.write((header.format(row[0], row[1], row[2], row[3], row[4])) + '\n')

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q2(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q2")

    try:
        output = open('output/2.out', 'w')

        header = "{:<40} {:>10} {:>10}"
        output.write((header.format("nation", "numW", "totCap")) + '\n')

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q3(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q3")

    try:
        input = open("input/3.in", "r")
        nation = input.readline().strip()
        input.close()


        output = open('output/3.out', 'w')

        header = "{:<20} {:<20} {:<40}"
        output.write((header.format("supplier", "nation", "warehouse")) + '\n')

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q4(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q4")

    try:
        input = open("input/4.in", "r")
        region = input.readline().strip()
        cap = input.readline().strip()
        input.close()


        output = open('output/4.out', 'w')

        header = "{:<40} {:>10}"
        output.write((header.format("warehouse", "capacity")) + '\n')

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q5(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q5")

    try:
        input = open("input/5.in", "r")
        nation = input.readline().strip()
        input.close()


        output = open('output/5.out', 'w')

        header = "{:<20} {:>20}"
        output.write((header.format("region", "capacity")) + '\n')

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def main():
    database = r"data/tpch.sqlite"

    # create a database connection
    conn = openConnection(database)
    with conn:
        dropTable(conn)
        createTable(conn)
        populateTable(conn)

        Q1(conn)
        Q2(conn)
        Q3(conn)
        Q4(conn)
        Q5(conn)

    closeConnection(conn, database)


if __name__ == '__main__':
    main()
