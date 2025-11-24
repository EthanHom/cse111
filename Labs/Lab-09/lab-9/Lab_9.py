import sqlite3
from sqlite3 import Error


def openConnection(_dbFile):
    print("++++++++++++++++++++++++++++++++++")
    print("Open database: ", _dbFile)

    conn = None
    try:
        conn = sqlite3.connect(_dbFile)
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


def create_View1(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V1")

    try: 
        dropView = "DROP VIEW IF EXISTS V1"

        sql = """
            CREATE VIEW V1 AS
            SELECT c_custkey, c_name, c_address, c_phone, c_acctbal, c_mktsegment, 
                c_comment, n_name as c_nation, r_name as c_region
            FROM customer, nation, region
            WHERE c_nationkey = n_nationkey
            AND n_regionkey = r_regionkey
        """
        
        _conn.execute(dropView)
        _conn.execute(sql)
        _conn.commit()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q1(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q1")

    try:
        output = open('output/1.out', 'w')

        header = "{}|{}"
        output.write((header.format("country", "cnt")) + '\n')

        sql = """
            SELECT c_nation as country, count(*) as cnt
            FROM orders, V1
            WHERE c_custkey = o_custkey
            AND c_region = 'EUROPE'
            GROUP BY c_nation
        """
        
        cursor = _conn.cursor()
        cursor.execute(sql)
        rows = cursor.fetchall()
        
        for row in rows:
            output.write((header.format(row[0], row[1])) + '\n')

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def create_View2(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V2")

    try:
        dropView = "DROP VIEW IF EXISTS V2"

        sql = """
        CREATE VIEW V2 AS
        SELECT o_orderkey, o_custkey, o_orderstatus, o_totalprice, 
               substr(o_orderdate, 1, 4) as o_orderyear, o_orderpriority, 
               o_clerk, o_shippriority, o_comment
        FROM orders
        """

        _conn.execute(dropView)
        _conn.execute(sql)
        _conn.commit()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q2(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q2")

    try:
        output = open('output/2.out', 'w')

        header = "{}|{}"
        output.write((header.format("customer", "cnt")) + '\n')

        sql = """
            SELECT c_name as customer, count(*) as cnt
            FROM V2, V1
            WHERE o_custkey = c_custkey
            AND c_nation = 'EGYPT'
            AND o_orderyear = '1992'
            GROUP BY c_name
        """
        
        cursor = _conn.cursor()
        cursor.execute(sql)
        rows = cursor.fetchall()
        
        for row in rows:
            output.write((header.format(row[0], row[1])) + '\n')

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q3(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q3")

    try:
        output = open('output/3.out', 'w')

        header = "{}|{}"
        output.write((header.format("customer", "total_price")) + '\n')

        sql = """
            SELECT c_name as customer, sum(o_totalprice) as total_price
            FROM orders, V1
            WHERE o_custkey = c_custkey
            AND c_nation = 'ARGENTINA'
            AND o_orderdate like '1996-%'
            GROUP BY c_name
        """
        
        cursor = _conn.cursor()
        cursor.execute(sql)
        rows = cursor.fetchall()
        
        for row in rows:
            output.write((header.format(row[0], row[1])) + '\n')

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def create_View4(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V4")

    try:
        dropView = "DROP VIEW IF EXISTS V4"

        sql = """
        CREATE VIEW V4 AS
        SELECT s_suppkey, s_name, s_address, s_phone, s_acctbal, 
               s_comment, n_name as s_nation, r_name as s_region
        FROM supplier, nation, region
        WHERE s_nationkey = n_nationkey
        AND n_regionkey = r_regionkey
        """

        _conn.execute(dropView)
        _conn.execute(sql)
        _conn.commit()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q4(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q4")

    try:
        output = open('output/4.out', 'w')

        header = "{}|{}"
        output.write((header.format("supplier", "cnt")) + '\n')

        sql = """
            SELECT s_name as supplier, count(*) as cnt
            FROM partsupp, V4, part
            WHERE p_partkey = ps_partkey
            AND ps_suppkey = s_suppkey
            AND s_nation = 'KENYA'
            AND p_container LIKE '%BOX%'
            GROUP BY s_name
        """
        
        cursor = _conn.cursor()
        cursor.execute(sql)
        rows = cursor.fetchall()
        
        for row in rows:
            output.write((header.format(row[0], row[1])) + '\n')

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q5(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q5")

    try:
        output = open('output/5.out', 'w')

        header = "{}|{}"
        output.write((header.format("country", "cnt")) + '\n')

        sql = """
            SELECT s_nation as country, count(*) as cnt
            FROM V4
            WHERE s_nation = 'ARGENTINA' OR s_nation = 'BRAZIL'
            GROUP BY s_nation
        """
        
        cursor = _conn.cursor()
        cursor.execute(sql)
        rows = cursor.fetchall()
        
        for row in rows:
            output.write((header.format(row[0], row[1])) + '\n')

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q6(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q6")

    try:
        output = open('output/6.out', 'w')

        header = "{}|{}|{}"
        output.write((header.format("supplier", "priority", "parts")) + '\n')

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q7(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q7")

    try:
        output = open('output/7.out', 'w')

        header = "{}|{}|{}"
        output.write((header.format("country", "status", "orders")) + '\n')

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q8(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q8")

    try:
        output = open('output/8.out', 'w')

        header = "{}"
        output.write((header.format("clerks")) + '\n')

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q9(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q9")

    try:
        output = open('output/9.out', 'w')

        header = "{}|{}"
        output.write((header.format("country", "cnt")) + '\n')

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def create_View10(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V10")

    print("++++++++++++++++++++++++++++++++++")


def Q10(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q10")

    try:
        output = open('output/10.out', 'w')

        header = "{}|{}|{}"
        output.write((header.format("part_type", "min_disc", "max_disc")) + '\n')

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def create_View111(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V111")

    print("++++++++++++++++++++++++++++++++++")


def create_View112(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V112")

    print("++++++++++++++++++++++++++++++++++")


def Q11(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q11")

    try:
        output = open('output/11.out', 'w')

        header = "{}"
        output.write((header.format("order_cnt")) + '\n')

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q12(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q12")

    try:
        output = open('output/12.out', 'w')

        header = "{}|{}"
        output.write((header.format("region", "max_bal")) + '\n')

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q13(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q13")

    try:
        output = open('output/13.out', 'w')

        header = "{}|{}|{}"
        output.write((header.format("supp_region", "cust_region", "min_price")) + '\n')

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q14(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q14")

    try:
        output = open('output/14.out', 'w')

        header = "{}"
        output.write((header.format("items")) + '\n')

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q15(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q15")

    try:
        output = open('output/15.out', 'w')

        header = "{}|{}|{}"
        output.write((header.format("region", "supplier", "acct_bal")) + '\n')

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def main():
    database = r"tpch.sqlite"

    # create a database connection
    conn = openConnection(database)
    with conn:
        create_View1(conn)
        Q1(conn)

        create_View2(conn)
        Q2(conn)

        Q3(conn)

        create_View4(conn)
        Q4(conn)

        Q5(conn)
        Q6(conn)
        Q7(conn)
        Q8(conn)
        Q9(conn)

        create_View10(conn)
        Q10(conn)

        create_View111(conn)
        create_View112(conn)
        Q11(conn)

        Q12(conn)
        Q13(conn)
        Q14(conn)
        Q15(conn)

    closeConnection(conn, database)


if __name__ == '__main__':
    main()





# import sqlite3
# from sqlite3 import Error


# def openConnection(_dbFile):
#     print("++++++++++++++++++++++++++++++++++")
#     print("Open database: ", _dbFile)

#     conn = None
#     try:
#         conn = sqlite3.connect(_dbFile)
#         print("success")
#     except Error as e:
#         print(e)

#     print("++++++++++++++++++++++++++++++++++")

#     return conn

# def closeConnection(_conn, _dbFile):
#     print("++++++++++++++++++++++++++++++++++")
#     print("Close database: ", _dbFile)

#     try:
#         _conn.close()
#         print("success")
#     except Error as e:
#         print(e)

#     print("++++++++++++++++++++++++++++++++++")


# def create_View1(_conn):
#     print("++++++++++++++++++++++++++++++++++")
#     print("Create V1")

#     try: 
#         sql = """
#             CREATE VIEW V1 AS
#             SELECT c_custkey, c_name, c_address, c_phone, c_acctbal, c_mktsegment, 
#                 c_comment, n_name as c_nation, r.r_name as c_region
#             FROM customer, nation, region
#             WHERE c_nationkey = n_nationkey
#             AND n_regionkey = r_regionkey
#         """
#     except Error as e:
#         print(e)

#     print("++++++++++++++++++++++++++++++++++")


# def Q1(_conn):
#     print("++++++++++++++++++++++++++++++++++")
#     print("Q1")

#     print("++++++++++++++++++++++++++++++++++")

#     try:
#         output = open('output/1.out', 'w')

#         header = "{}|{}"
#         output.write((header.format("country", "cnt")) + '\n')

#         sql = """
#             SELECT c_nation as country, count(*) as cnt
#             FROM orders, V1
#             WHERE c_custkey = o_custkey
#             AND c_region = 'EUROPE'
#             GROUP BY c_nation
#         """
        
#         cursor = _conn.cursor()
#         cursor.execute(sql)
#         rows = cursor.fetchall()
        
#         for row in rows:
#             output.write((header.format(row[0], row[1])) + '\n')

#         output.close()
#     except Error as e:
#         print(e)


# def create_View2(_conn):
#     print("++++++++++++++++++++++++++++++++++")
#     print("Create V2")

#     print("++++++++++++++++++++++++++++++++++")

#     try:
#         sql_statement = """
#         CREATE VIEW V2 AS
#         SELECT o_orderkey, o_custkey, o_orderstatus, o_totalprice, 
#                substr(o_orderdate, 1, 4) as o_orderyear, o_orderpriority, 
#                o_clerk, o_shippriority, o_comment
#         FROM orders
#         """
#         _conn.execute(sql_statement)
#         _conn.commit()
#     except Error as e:
#         print(e)


# def Q2(_conn):
#     print("++++++++++++++++++++++++++++++++++")
#     print("Q2")

#     try:
#         output = open('output/2.out', 'w')

#         header = "{}|{}"
#         output.write((header.format("customer", "cnt")) + '\n')

#         sql_statement = """
#         SELECT c_name as customer, count(*) as cnt
#         FROM V2, V1
#         WHERE o_custkey = c_custkey
#         AND c_nation = 'EGYPT'
#         AND o_orderyear = '1992'
#         GROUP BY c_name
#         """
        
#         cursor = _conn.cursor()
#         cursor.execute(sql_statement)
#         rows = cursor.fetchall()
        
#         for row in rows:
#             output.write((header.format(row[0], row[1])) + '\n')
        

#         output.close()
#     except Error as e:
#         print(e)

#     print("++++++++++++++++++++++++++++++++++")


# def Q3(_conn):
#     print("++++++++++++++++++++++++++++++++++")
#     print("Q3")

#     try:
#         output = open('output/3.out', 'w')

#         header = "{}|{}"
#         output.write((header.format("customer", "total_price")) + '\n')

#         sql_statement = """
#         SELECT c_name as customer, sum(o_totalprice) as total_price
#         FROM orders, V1
#         WHERE o_custkey = c_custkey
#         AND c_nation = 'ARGENTINA'
#         AND o_orderdate like '1996-%'
#         GROUP BY c_name
#         """
        
#         cursor = _conn.cursor()
#         cursor.execute(sql_statement)
#         rows = cursor.fetchall()
        
#         for row in rows:
#             output.write((header.format(row[0], row[1])) + '\n')

#         output.close()
#     except Error as e:
#         print(e)

#     print("++++++++++++++++++++++++++++++++++")


# def create_View4(_conn):
#     print("++++++++++++++++++++++++++++++++++")
#     print("Create V4")

#     print("++++++++++++++++++++++++++++++++++")

#     try:
#         sql_statement = """
#         CREATE VIEW V4 AS
#         SELECT s_suppkey, s_name, s_address, s_phone, s_acctbal, 
#                s_comment, n_name as s_nation, r_name as s_region
#         FROM supplier, nation, region
#         WHERE s_nationkey = n_nationkey
#         AND n_regionkey = r_regionkey
#         """
#         _conn.execute(sql_statement)
#         _conn.commit()
#     except Error as e:
#         print(e)


# def Q4(_conn):
#     print("++++++++++++++++++++++++++++++++++")
#     print("Q4")

#     try:
#         output = open('output/4.out', 'w')

#         header = "{}|{}"
#         output.write((header.format("supplier", "cnt")) + '\n')

#         sql_statement = """
#         SELECT s_name as supplier, count(*) as cnt
#         FROM partsupp, V4, part
#         WHERE p_partkey = ps_partkey
#         AND ps_suppkey = s_suppkey
#         AND s_nation = 'KENYA'
#         AND p_container LIKE '%BOX%'
#         GROUP BY s_name
#         """
        
#         cursor = _conn.cursor()
#         cursor.execute(sql_statement)
#         rows = cursor.fetchall()
        
#         for row in rows:
#             output.write((header.format(row[0], row[1])) + '\n')

#         output.close()
#     except Error as e:
#         print(e)

#     print("++++++++++++++++++++++++++++++++++")


# def Q5(_conn):
#     print("++++++++++++++++++++++++++++++++++")
#     print("Q5")

#     try:
#         output = open('output/5.out', 'w')

#         header = "{}|{}"
#         output.write((header.format("country", "cnt")) + '\n')

#         sql_statement = """
#         SELECT s_nation as country, count(*) as cnt
#         FROM V4
#         WHERE s_nation = 'ARGENTINA' OR s_nation = 'BRAZIL'
#         GROUP BY s_nation
#         """
        
#         cursor = _conn.cursor()
#         cursor.execute(sql_statement)
#         rows = cursor.fetchall()
        
#         for row in rows:
#             output.write((header.format(row[0], row[1])) + '\n')

#         output.close()
#     except Error as e:
#         print(e)

#     print("++++++++++++++++++++++++++++++++++")


# def Q6(_conn):
#     print("++++++++++++++++++++++++++++++++++")
#     print("Q6")

#     try:
#         output = open('output/6.out', 'w')

#         header = "{}|{}|{}"
#         output.write((header.format("supplier", "priority", "parts")) + '\n')

#         output.close()
#     except Error as e:
#         print(e)

#     print("++++++++++++++++++++++++++++++++++")


# def Q7(_conn):
#     print("++++++++++++++++++++++++++++++++++")
#     print("Q7")

#     try:
#         output = open('output/7.out', 'w')

#         header = "{}|{}|{}"
#         output.write((header.format("country", "status", "orders")) + '\n')

#         output.close()
#     except Error as e:
#         print(e)

#     print("++++++++++++++++++++++++++++++++++")


# def Q8(_conn):
#     print("++++++++++++++++++++++++++++++++++")
#     print("Q8")

#     try:
#         output = open('output/8.out', 'w')

#         header = "{}"
#         output.write((header.format("clerks")) + '\n')

#         output.close()
#     except Error as e:
#         print(e)

#     print("++++++++++++++++++++++++++++++++++")


# def Q9(_conn):
#     print("++++++++++++++++++++++++++++++++++")
#     print("Q9")

#     try:
#         output = open('output/9.out', 'w')

#         header = "{}|{}"
#         output.write((header.format("country", "cnt")) + '\n')

#         output.close()
#     except Error as e:
#         print(e)

#     print("++++++++++++++++++++++++++++++++++")


# def create_View10(_conn):
#     print("++++++++++++++++++++++++++++++++++")
#     print("Create V10")

#     print("++++++++++++++++++++++++++++++++++")


# def Q10(_conn):
#     print("++++++++++++++++++++++++++++++++++")
#     print("Q10")

#     try:
#         output = open('output/10.out', 'w')

#         header = "{}|{}|{}"
#         output.write((header.format("part_type", "min_disc", "max_disc")) + '\n')

#         output.close()
#     except Error as e:
#         print(e)

#     print("++++++++++++++++++++++++++++++++++")


# def create_View111(_conn):
#     print("++++++++++++++++++++++++++++++++++")
#     print("Create V111")

#     print("++++++++++++++++++++++++++++++++++")


# def create_View112(_conn):
#     print("++++++++++++++++++++++++++++++++++")
#     print("Create V112")

#     print("++++++++++++++++++++++++++++++++++")


# def Q11(_conn):
#     print("++++++++++++++++++++++++++++++++++")
#     print("Q11")

#     try:
#         output = open('output/11.out', 'w')

#         header = "{}"
#         output.write((header.format("order_cnt")) + '\n')

#         output.close()
#     except Error as e:
#         print(e)

#     print("++++++++++++++++++++++++++++++++++")


# def Q12(_conn):
#     print("++++++++++++++++++++++++++++++++++")
#     print("Q12")

#     try:
#         output = open('output/12.out', 'w')

#         header = "{}|{}"
#         output.write((header.format("region", "max_bal")) + '\n')

#         output.close()
#     except Error as e:
#         print(e)

#     print("++++++++++++++++++++++++++++++++++")


# def Q13(_conn):
#     print("++++++++++++++++++++++++++++++++++")
#     print("Q13")

#     try:
#         output = open('output/13.out', 'w')

#         header = "{}|{}|{}"
#         output.write((header.format("supp_region", "cust_region", "min_price")) + '\n')

#         output.close()
#     except Error as e:
#         print(e)

#     print("++++++++++++++++++++++++++++++++++")


# def Q14(_conn):
#     print("++++++++++++++++++++++++++++++++++")
#     print("Q14")

#     try:
#         output = open('output/14.out', 'w')

#         header = "{}"
#         output.write((header.format("items")) + '\n')

#         output.close()
#     except Error as e:
#         print(e)

#     print("++++++++++++++++++++++++++++++++++")


# def Q15(_conn):
#     print("++++++++++++++++++++++++++++++++++")
#     print("Q15")

#     try:
#         output = open('output/15.out', 'w')

#         header = "{}|{}|{}"
#         output.write((header.format("region", "supplier", "acct_bal")) + '\n')

#         output.close()
#     except Error as e:
#         print(e)

#     print("++++++++++++++++++++++++++++++++++")


# def main():
#     database = r"tpch.sqlite"

#     # create a database connection
#     conn = openConnection(database)
#     with conn:
#         create_View1(conn)
#         Q1(conn)

#         create_View2(conn)
#         Q2(conn)

#         Q3(conn)

#         create_View4(conn)
#         Q4(conn)

#         Q5(conn)
#         Q6(conn)
#         Q7(conn)
#         Q8(conn)
#         Q9(conn)

#         create_View10(conn)
#         Q10(conn)

#         create_View111(conn)
#         create_View112(conn)
#         Q11(conn)

#         Q12(conn)
#         Q13(conn)
#         Q14(conn)
#         Q15(conn)

#     closeConnection(conn, database)


# if __name__ == '__main__':
#     main()



# """