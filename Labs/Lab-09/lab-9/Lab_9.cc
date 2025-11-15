#include <fstream>
#include <iostream>
#include <iomanip>
#include <cstdlib>
#include <string>

#include "sqlite3.h"

using namespace std;


class Lab_9 {
protected:
    // class variables
    string dbName;
    bool isConnected;

	sqlite3* db;
	sqlite3_stmt* stmt_handle;
	const char* stmt_leftover;

public:
    // constructor & destructor
    Lab_9(string& _dbFile) : dbName(_dbFile), isConnected(false) {}
    
    virtual ~Lab_9() {
        if (true == isConnected) {
            CloseConnection();
        }
    }

    // public interface
    void OpenConnection() {
        if (isConnected == false) {
            cout << "++++++++++++++++++++++++++++++++++\n";
            cout << "Open database: " << dbName << endl;

            int rc = sqlite3_open(string(dbName).c_str(), &db);
            if (rc != SQLITE_OK) {
                cout << sqlite3_errmsg(db) << endl;
                sqlite3_close(db);
                exit(1);
            }

            isConnected = true;

            cout << "success\n";
            cout << "++++++++++++++++++++++++++++++++++\n";
        }
    }

    void CloseConnection() {
        if (isConnected == true) {
            cout << "++++++++++++++++++++++++++++++++++\n";
            cout << "Close database: " << dbName << endl;

            sqlite3_close(db);
            isConnected = false;

            cout << "success\n";
            cout << "++++++++++++++++++++++++++++++++++\n";
        }
    }

    void create_View1() {
        std::cout << "++++++++++++++++++++++++++++++++++" << std::endl;
        std::cout << "Create V1" << std::endl;
        std::cout << "++++++++++++++++++++++++++++++++++" << std::endl;
    }

    void Q1() {
        std::cout << "++++++++++++++++++++++++++++++++++" << std::endl;
        std::cout << "Q1" << std::endl;

        try {
            std::ofstream writer("output/1.out", std::ios::out);
            writer << "country|cnt\n";
            writer.close();
        } catch (const std::exception& e) {
            std::cerr << typeid(e).name() << ": " << e.what() << std::endl;
        }

        std::cout << "++++++++++++++++++++++++++++++++++" << std::endl;
    }

    void create_View2() {
        std::cout << "++++++++++++++++++++++++++++++++++" << std::endl;
        std::cout << "Create V2" << std::endl;
        std::cout << "++++++++++++++++++++++++++++++++++" << std::endl;
    }

    void Q2() {
        std::cout << "++++++++++++++++++++++++++++++++++" << std::endl;
        std::cout << "Q2" << std::endl;

        try {
            std::ofstream writer("output/2.out", std::ios::out);
            writer << "customer|cnt\n";
            writer.close();
        } catch (const std::exception& e) {
            std::cerr << typeid(e).name() << ": " << e.what() << std::endl;
        }

        std::cout << "++++++++++++++++++++++++++++++++++" << std::endl;
    }

    void Q3() {
        std::cout << "++++++++++++++++++++++++++++++++++" << std::endl;
        std::cout << "Q3" << std::endl;

        try {
            std::ofstream writer("output/3.out", std::ios::out);
            writer << "customer|total_price\n";
            writer.close();
        } catch (const std::exception& e) {
            std::cerr << typeid(e).name() << ": " << e.what() << std::endl;
        }

        std::cout << "++++++++++++++++++++++++++++++++++" << std::endl;
    }

    void create_View4() {
        std::cout << "++++++++++++++++++++++++++++++++++" << std::endl;
        std::cout << "Create V4" << std::endl;
        std::cout << "++++++++++++++++++++++++++++++++++" << std::endl;
    }

    void Q4() {
        std::cout << "++++++++++++++++++++++++++++++++++" << std::endl;
        std::cout << "Q4" << std::endl;

        try {
            std::ofstream writer("output/4.out", std::ios::out);
            writer << "supplier|cnt\n";
            writer.close();
        } catch (const std::exception& e) {
            std::cerr << typeid(e).name() << ": " << e.what() << std::endl;
        }

        std::cout << "++++++++++++++++++++++++++++++++++" << std::endl;
    }

    void Q5() {
        std::cout << "++++++++++++++++++++++++++++++++++" << std::endl;
        std::cout << "Q5" << std::endl;

        try {
            std::ofstream writer("output/5.out", std::ios::out);
            writer << "country|cnt\n";
            writer.close();
        } catch (const std::exception& e) {
            std::cerr << typeid(e).name() << ": " << e.what() << std::endl;
        }

        std::cout << "++++++++++++++++++++++++++++++++++" << std::endl;
    }

    void Q6() {
        std::cout << "++++++++++++++++++++++++++++++++++" << std::endl;
        std::cout << "Q6" << std::endl;

        try {
            std::ofstream writer("output/6.out", std::ios::out);
            writer << "supplier|priority|parts\n";
            writer.close();
        } catch (const std::exception& e) {
            std::cerr << typeid(e).name() << ": " << e.what() << std::endl;
        }

        std::cout << "++++++++++++++++++++++++++++++++++" << std::endl;
    }

    void Q7() {
        std::cout << "++++++++++++++++++++++++++++++++++" << std::endl;
        std::cout << "Q7" << std::endl;

        try {
            std::ofstream writer("output/7.out", std::ios::out);
            writer << "country|status|orders\n";
            writer.close();
        } catch (const std::exception& e) {
            std::cerr << typeid(e).name() << ": " << e.what() << std::endl;
        }

        std::cout << "++++++++++++++++++++++++++++++++++" << std::endl;
    }

    void Q8() {
        std::cout << "++++++++++++++++++++++++++++++++++" << std::endl;
        std::cout << "Q8" << std::endl;

        try {
            std::ofstream writer("output/8.out", std::ios::out);
            writer << "clerks\n";
            writer.close();
        } catch (const std::exception& e) {
            std::cerr << typeid(e).name() << ": " << e.what() << std::endl;
        }

        std::cout << "++++++++++++++++++++++++++++++++++" << std::endl;
    }

    void Q9() {
        std::cout << "++++++++++++++++++++++++++++++++++" << std::endl;
        std::cout << "Q9" << std::endl;

        try {
            std::ofstream writer("output/9.out", std::ios::out);
            writer << "country|cnt\n";
            writer.close();
        } catch (const std::exception& e) {
            std::cerr << typeid(e).name() << ": " << e.what() << std::endl;
        }

        std::cout << "++++++++++++++++++++++++++++++++++" << std::endl;
    }

    void create_View10() {
        std::cout << "++++++++++++++++++++++++++++++++++" << std::endl;
        std::cout << "Create V10" << std::endl;
        std::cout << "++++++++++++++++++++++++++++++++++" << std::endl;
    }

    void Q10() {
        std::cout << "++++++++++++++++++++++++++++++++++" << std::endl;
        std::cout << "Q10" << std::endl;

        try {
            std::ofstream writer("output/10.out", std::ios::out);
            writer << "part_type|min_disc|max_disc\n";
            writer.close();
        } catch (const std::exception& e) {
            std::cerr << typeid(e).name() << ": " << e.what() << std::endl;
        }

        std::cout << "++++++++++++++++++++++++++++++++++" << std::endl;
    }

    void create_View111() {
        std::cout << "++++++++++++++++++++++++++++++++++" << std::endl;
        std::cout << "Create V111" << std::endl;
        std::cout << "++++++++++++++++++++++++++++++++++" << std::endl;
    }

    void create_View112() {
        std::cout << "++++++++++++++++++++++++++++++++++" << std::endl;
        std::cout << "Create V112" << std::endl;
        std::cout << "++++++++++++++++++++++++++++++++++" << std::endl;
    }

    void Q11() {
        std::cout << "++++++++++++++++++++++++++++++++++" << std::endl;
        std::cout << "Q11" << std::endl;

        try {
            std::ofstream writer("output/11.out", std::ios::out);
            writer << "order_cnt\n";
            writer.close();
        } catch (const std::exception& e) {
            std::cerr << typeid(e).name() << ": " << e.what() << std::endl;
        }

        std::cout << "++++++++++++++++++++++++++++++++++" << std::endl;
    }

    void Q12() {
        std::cout << "++++++++++++++++++++++++++++++++++" << std::endl;
        std::cout << "Q12" << std::endl;

        try {
            ofstream writer("output/12.out", std::ios::out);
            writer << "region|max_bal\n";
            writer.close();
        } catch (const std::exception& e) {
            std::cerr << typeid(e).name() << ": " << e.what() << std::endl;
        }

        std::cout << "++++++++++++++++++++++++++++++++++" << std::endl;
    }

    void Q13() {
        std::cout << "++++++++++++++++++++++++++++++++++" << std::endl;
        std::cout << "Q13" << std::endl;

        try {
            ofstream writer("output/13.out", std::ios::out);
            writer << "supp_region|cust_region|min_price\n";
            writer.close();
        } catch (const std::exception& e) {
            std::cerr << typeid(e).name() << ": " << e.what() << std::endl;
        }

        std::cout << "++++++++++++++++++++++++++++++++++" << std::endl;
    }

    void Q14() {
        std::cout << "++++++++++++++++++++++++++++++++++" << std::endl;
        std::cout << "Q14" << std::endl;

        try {
            ofstream writer("output/14.out", std::ios::out);
            writer << "items\n";
            writer.close();
        } catch (const std::exception& e) {
            std::cerr << typeid(e).name() << ": " << e.what() << std::endl;
        }

        std::cout << "++++++++++++++++++++++++++++++++++" << std::endl;
    }

    void Q15() {
        std::cout << "++++++++++++++++++++++++++++++++++" << std::endl;
        std::cout << "Q15" << std::endl;

        try {
            ofstream writer("output/15.out", std::ios::out);
            writer << "region|supplier|acct_bal\n";
            writer.close();
        } catch (const std::exception& e) {
            std::cerr << typeid(e).name() << ": " << e.what() << std::endl;
        }

        std::cout << "++++++++++++++++++++++++++++++++++" << std::endl;
    }
};


int main (int argc, char* argv[]) {
	if (argc != 2) {
		cout << "Usage: main [sqlite_file]" << endl;
		return -1;
	}

	string dbFile(argv[1]);
	Lab_9 sj(dbFile);
	
	sj.OpenConnection();

    sj.create_View1();
    sj.Q1();

    sj.create_View2();
    sj.Q2();

    sj.Q3();

    sj.create_View4();
    sj.Q4();

    sj.Q5();
    sj.Q6();
    sj.Q7();
    sj.Q8();
    sj.Q9();

    sj.create_View10();
    sj.Q10();

    sj.create_View111();
    sj.create_View112();
    sj.Q11();

    sj.Q12();
    sj.Q13();
    sj.Q14();
    sj.Q15();

    sj.CloseConnection();

	return 0;
}


/*
    Compile with: g++ -g -O0 -Wno-deprecated -o Lab_9.exe Lab_9.cc -lsqlite3
    Install requirements: apt install gcc g++ sqlite3 libsqlite3-dev
*/
