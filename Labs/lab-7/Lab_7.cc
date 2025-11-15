#include <fstream>
#include <iostream>
#include <iomanip>
#include <cstdlib>
#include <string>

#include "sqlite3.h"

using namespace std;


class Lab_7 {
protected:
    // class variables
    string dbName;
    bool isConnected;

	sqlite3* db;
	sqlite3_stmt* stmt_handle;
	const char* stmt_leftover;

public:
    // constructor & destructor
    Lab_7(string& _dbFile) : dbName(_dbFile), isConnected(false) {}
    
    virtual ~Lab_7() {
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

    void CreateTable() {
        cout << "++++++++++++++++++++++++++++++++++\n";
        cout << "Create table\n";
        cout << "++++++++++++++++++++++++++++++++++\n";
    }

    void PopulateTable() {
        cout << "++++++++++++++++++++++++++++++++++\n";
        cout << "Populate table\n";
        cout << "++++++++++++++++++++++++++++++++++\n";
    }

    void DropTable() {
        cout << "++++++++++++++++++++++++++++++++++\n";
        cout << "Drop table\n";
        cout << "++++++++++++++++++++++++++++++++++\n";
    }

    void Q1() {
        cout << "++++++++++++++++++++++++++++++++++\n";
        cout << "Q1\n";

        ofstream out("output/1.out");
        out << setw(10) << "wId" << " " << setw(40) << left << "wName" << setw(10) << "wCap"
            << setw(10) << "sId" << setw(10) << "nId" << "\n";

        out.close();
        cout << "++++++++++++++++++++++++++++++++++\n";
    }

    void Q2() {
        cout << "++++++++++++++++++++++++++++++++++\n";
        cout << "Q2\n";
    
        ofstream out("output/2.out");
        out << setw(40) << left << "nation" << setw(10) << "numW" << setw(10) << "totCap" << "\n";
    
        out.close();
        cout << "++++++++++++++++++++++++++++++++++\n";
    }

    void Q3() {
        cout << "++++++++++++++++++++++++++++++++++\n";
        cout << "Q3\n";

        ifstream in("input/3.in");
        string nation;
        getline(in, nation);
        in.close();

        ofstream out("output/3.out");
        out << setw(20) << left << "supplier" << setw(20) << "nation" << setw(40) << "warehouse" << "\n";

        out.close();
        cout << "++++++++++++++++++++++++++++++++++\n";
    }

    void Q4() {
        cout << "++++++++++++++++++++++++++++++++++\n";
        cout << "Q4\n";

        ifstream in("input/4.in");
        string region;
        int cap;
        getline(in, region);
        in >> cap;
        in.close();

        ofstream out("output/4.out");
        out << setw(40) << left << "warehouse" << setw(10) << "capacity" << "\n";

        out.close();
        cout << "++++++++++++++++++++++++++++++++++\n";
    }

    void Q5() {
        cout << "++++++++++++++++++++++++++++++++++\n";
        cout << "Q5\n";

        ifstream in("input/5.in");
        string nation;
        getline(in, nation);
        in.close();

        ofstream out("output/5.out");
        out << setw(20) << left << "region" << setw(20) << "capacity" << "\n";

        out.close();
        cout << "++++++++++++++++++++++++++++++++++\n";
    }
};


int main (int argc, char* argv[]) {
	if (argc != 2) {
		cout << "Usage: main [sqlite_file]" << endl;
		return -1;
	}

	string dbFile(argv[1]);
	Lab_7 sj(dbFile);
	
	sj.OpenConnection();

    sj.DropTable();
    sj.CreateTable();
    sj.PopulateTable();
    
    sj.Q1();
    sj.Q2();
    sj.Q3();
    sj.Q4();
    sj.Q5();

    sj.CloseConnection();

	return 0;
}


/*
    Compile with: g++ -g -O0 -Wno-deprecated -o Lab_7.exe Lab_7.cc -lsqlite3
    Install requirements: apt install gcc g++ sqlite3 libsqlite3-dev
*/
