// STEP: Import required packages
import java.sql.*;

public class SQLiteJDBC {
    private Connection c = null;
    private String dbName;
    private boolean isConnected = false;

    private void openConnection(String _dbName) {
        dbName = _dbName;

        if (false == isConnected) {
            System.out.println("++++++++++++++++++++++++++++++++++");
            System.out.println("Open database: " + _dbName);

            try {
                String connStr = new String("jdbc:sqlite:");
                connStr = connStr + _dbName;

                // STEP: Register JDBC driver
                Class.forName("org.sqlite.JDBC");

                // STEP: Open a connection
                c = DriverManager.getConnection(connStr);

                // STEP: Diable auto transactions
                c.setAutoCommit(false);

                isConnected = true;
                System.out.println("success");
            } catch (Exception e) {
                System.err.println(e.getClass().getName() + ": " + e.getMessage());
                System.exit(0);
            }

            System.out.println("++++++++++++++++++++++++++++++++++");
        }
    }

    private void closeConnection() {
        if (true == isConnected) {
            System.out.println("++++++++++++++++++++++++++++++++++");
            System.out.println("Close database: " + dbName);

            try {
                // STEP: Close connection
                c.close();

                isConnected = false;
                dbName = "";
                System.out.println("success");
            } catch (Exception e) {
                System.err.println(e.getClass().getName() + ": " + e.getMessage());
                System.exit(0);
            }

            System.out.println("++++++++++++++++++++++++++++++++++");
        }
    }

    private void createTables() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Create tables");

        try {
            Statement stmt = c.createStatement();

            // STEP: Execute update statement
            String sql = "CREATE TABLE Product (" +
                "maker CHAR(32)," +
                "model INTEGER PRIMARY KEY," +
                "type VARCHAR(20) NOT NULL)";
            stmt.execute(sql);

            sql = "CREATE TABLE PC (" +
                "model INTEGER PRIMARY KEY," +
                "speed FLOAT," +
                "ram INTEGER," +
                "hd INTEGER," +
                "price DECIMAL(7,2) NOT NULL)";
            stmt.execute(sql);

            sql = "CREATE TABLE Laptop (" +
                "model INTEGER PRIMARY KEY," +
                "speed FLOAT," +
                "ram INTEGER," +
                "hd INTEGER," +
                "screen DECIMAL(4,1)," +
                "price DECIMAL(7,2) NOT NULL)";
            stmt.execute(sql);

            sql = "CREATE TABLE Printer (" +
                "model INTEGER PRIMARY KEY," +
                "color BOOL," +
                "type VARCHAR(30)," +
                "price decimal(7,2) NOT NULL)";
            stmt.execute(sql);

            // STEP: Commit transaction
            c.commit();

            stmt.close();
            System.out.println("success");
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            try {
                c.rollback();
            } catch (Exception e1) {
                System.err.println(e1.getClass().getName() + ": " + e1.getMessage());
            }
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void populateTable_Product() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Populate PRODUCT");

        try {
            String sql = "INSERT INTO Product VALUES(?, ?, ?)";
            PreparedStatement stmt = c.prepareStatement(sql);

            stmt.setString(1, "A");
            stmt.setInt(2, 1001);
            stmt.setString(3, "pc");
            stmt.addBatch();

            stmt.setString(1, "A");
            stmt.setInt(2, 1002);
            stmt.setString(3, "pc");
            stmt.addBatch();

            stmt.setString(1, "A");
            stmt.setInt(2, 1003);
            stmt.setString(3, "pc");
            stmt.addBatch();

            stmt.setString(1, "A");
            stmt.setInt(2, 2004);
            stmt.setString(3, "laptop");
            stmt.addBatch();

            stmt.setString(1, "A");
            stmt.setInt(2, 2005);
            stmt.setString(3, "laptop");
            stmt.addBatch();

            stmt.setString(1, "A");
            stmt.setInt(2, 2006);
            stmt.setString(3, "laptop");
            stmt.addBatch();

            stmt.setString(1, "B");
            stmt.setInt(2, 1004);
            stmt.setString(3, "pc");
            stmt.addBatch();

            stmt.setString(1, "B");
            stmt.setInt(2, 1005);
            stmt.setString(3, "pc");
            stmt.addBatch();

            stmt.setString(1, "B");
            stmt.setInt(2, 1006);
            stmt.setString(3, "pc");
            stmt.addBatch();

            stmt.setString(1, "B");
            stmt.setInt(2, 2007);
            stmt.setString(3, "laptop");
            stmt.addBatch();

            stmt.setString(1, "C");
            stmt.setInt(2, 1007);
            stmt.setString(3, "pc");
            stmt.addBatch();

            stmt.setString(1, "D");
            stmt.setInt(2, 1008);
            stmt.setString(3, "pc");
            stmt.addBatch();

            stmt.setString(1, "D");
            stmt.setInt(2, 1009);
            stmt.setString(3, "pc");
            stmt.addBatch();

            stmt.setString(1, "D");
            stmt.setInt(2, 1010);
            stmt.setString(3, "pc");
            stmt.addBatch();

            stmt.setString(1, "D");
            stmt.setInt(2, 3004);
            stmt.setString(3, "printer");
            stmt.addBatch();

            stmt.setString(1, "D");
            stmt.setInt(2, 3005);
            stmt.setString(3, "printer");
            stmt.addBatch();

            stmt.setString(1, "E");
            stmt.setInt(2, 1011);
            stmt.setString(3, "pc");
            stmt.addBatch();

            stmt.setString(1, "E");
            stmt.setInt(2, 1012);
            stmt.setString(3, "pc");
            stmt.addBatch();

            stmt.setString(1, "E");
            stmt.setInt(2, 1013);
            stmt.setString(3, "pc");
            stmt.addBatch();

            stmt.setString(1, "E");
            stmt.setInt(2, 2001);
            stmt.setString(3, "laptop");
            stmt.addBatch();

            stmt.setString(1, "E");
            stmt.setInt(2, 2002);
            stmt.setString(3, "laptop");
            stmt.addBatch();

            stmt.setString(1, "E");
            stmt.setInt(2, 2003);
            stmt.setString(3, "laptop");
            stmt.addBatch();

            stmt.setString(1, "E");
            stmt.setInt(2, 3001);
            stmt.setString(3, "printer");
            stmt.addBatch();

            stmt.setString(1, "E");
            stmt.setInt(2, 3002);
            stmt.setString(3, "printer");
            stmt.addBatch();

            stmt.setString(1, "E");
            stmt.setInt(2, 3003);
            stmt.setString(3, "printer");
            stmt.addBatch();

            stmt.setString(1, "F");
            stmt.setInt(2, 2008);
            stmt.setString(3, "laptop");
            stmt.addBatch();

            stmt.setString(1, "F");
            stmt.setInt(2, 2009);
            stmt.setString(3, "laptop");
            stmt.addBatch();

            stmt.setString(1, "G");
            stmt.setInt(2, 2010);
            stmt.setString(3, "laptop");
            stmt.addBatch();

            stmt.setString(1, "H");
            stmt.setInt(2, 3006);
            stmt.setString(3, "printer");
            stmt.addBatch();

            stmt.setString(1, "H");
            stmt.setInt(2, 3007);
            stmt.setString(3, "printer");
            stmt.addBatch();

            // STEP: Execute batch
            stmt.executeBatch();

            // STEP: Commit transaction
            c.commit();

            stmt.close();
            System.out.println("success");
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            try {
                c.rollback();
            } catch (Exception e1) {
                System.err.println(e1.getClass().getName() + ": " + e1.getMessage());
            }
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void populateTable_PC() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Populate PC");

        insert_PC(1001, 2.66, 1024, 250, 2114);
        insert_PC(1002, 2.10, 512, 250, 995);
        insert_PC(1003, 1.42, 512, 80, 478);
        insert_PC(1004, 2.80, 1024, 250, 649);
        insert_PC(1005, 3.20, 512, 250, 630);
        insert_PC(1006, 3.20, 1024, 320, 1049);
        insert_PC(1007, 2.20, 1024, 200, 510);
        insert_PC(1008, 2.20, 2048, 250, 770);
        insert_PC(1009, 2.00, 1024, 250, 650);
        insert_PC(1010, 2.80, 2048, 300, 770);
        insert_PC(1011, 1.86, 2048, 160, 959);
        insert_PC(1012, 2.80, 1024, 160, 649);
        insert_PC(1013, 3.06, 512, 80, 529);

        System.out.println("success");
        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void insert_PC(int _model, double _speed, int _ram,
        int _hd, int _price) {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Insert PC");

        try {
            String sql = "INSERT INTO PC(model, speed, ram, hd, price) " +
                "VALUES(?, ?, ?, ?, ?)";
            PreparedStatement stmt = c.prepareStatement(sql);

            stmt.setInt(1, _model);
            stmt.setDouble(2, _speed);
            stmt.setInt(3, _ram);
            stmt.setInt(4, _hd);
            stmt.setInt(5, _price);

            // STEP: Execute batch
            stmt.executeUpdate();

            // STEP: Commit transaction
            c.commit();

            stmt.close();
            System.out.println("success");
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            try {
                c.rollback();
            } catch (Exception e1) {
                System.err.println(e1.getClass().getName() + ": " + e1.getMessage());
            }
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void populateTable_Laptop() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Populate Laptop");

        insert_Laptop(2001, 2.00, 2048, 240, 20.1, 3673);
        insert_Laptop(2002, 1.73, 1024, 80, 17.0, 949);
        insert_Laptop(2003, 1.80, 512, 60, 15.4, 549);
        insert_Laptop(2004, 2.00, 512, 60, 13.3, 1150);
        insert_Laptop(2005, 2.16, 1024, 120, 17.0, 2500);
        insert_Laptop(2006, 2.00, 2048, 80, 15.4, 1700);
        insert_Laptop(2007, 1.83, 1024, 120, 13.3, 1429);
        insert_Laptop(2008, 1.60, 1024, 100, 15.4, 900);
        insert_Laptop(2009, 1.60, 512, 80, 14.1, 680);
        insert_Laptop(2010, 2.00, 2048, 160, 15.4, 2300);

        System.out.println("success");
        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void insert_Laptop(int _model, double _speed, int _ram,
        int _hd, double _screen, int _price) {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Insert Laptop");

        try {
            String sql = "INSERT INTO Laptop VALUES(?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = c.prepareStatement(sql);

            stmt.setInt(1, _model);
            stmt.setDouble(2, _speed);
            stmt.setInt(3, _ram);
            stmt.setInt(4, _hd);
            stmt.setDouble(5, _screen);
            stmt.setInt(6, _price);

            // STEP: Execute batch
            stmt.executeUpdate();

            // STEP: Commit transaction
            c.commit();

            stmt.close();
            System.out.println("success");
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            try {
                c.rollback();
            } catch (Exception e1) {
                System.err.println(e1.getClass().getName() + ": " + e1.getMessage());
            }
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void populateTable_Printer() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Populate Printer");

        insert_Printer(3001, true, "ink-jet", 99);
        insert_Printer(3002, false, "laser", 239);
        insert_Printer(3003, true, "laser", 899);
        insert_Printer(3004, true, "ink-jet", 120);
        insert_Printer(3005, false, "laser", 120);
        insert_Printer(3006, true, "ink-jet", 100);
        insert_Printer(3007, true, "laser", 200);

        System.out.println("success");
        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void insert_Printer(int _model, boolean _color, String _type, int _price) {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Insert Printer");

        try {
            String sql = "INSERT INTO Printer(model, color, type, price) " +
                "VALUES(?, ?, ?, ?)";
            PreparedStatement stmt = c.prepareStatement(sql);

            stmt.setInt(1, _model);
            stmt.setBoolean(2, _color);
            stmt.setString(3, _type);
            stmt.setInt(4, _price);

            // STEP: Execute batch
            stmt.executeUpdate();

            // STEP: Commit transaction
            c.commit();

            stmt.close();
            System.out.println("success");
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            try {
                c.rollback();
            } catch (Exception e1) {
                System.err.println(e1.getClass().getName() + ": " + e1.getMessage());
            }
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void populateTables() {
        populateTable_Product();
        populateTable_PC();
        populateTable_Laptop();
        populateTable_Printer();
    }

    private void dropTables() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Drop tables");

        try {
            Statement stmt = c.createStatement();

            // STEP: Execute update statement
            String sql = "DROP TABLE Product";
            stmt.execute(sql);

            sql = "DROP TABLE PC";
            stmt.execute(sql);

            sql = "DROP TABLE Laptop";
            stmt.execute(sql);

            sql = "DROP TABLE Printer";
            stmt.execute(sql);

            // STEP: Commit transaction
            c.commit();

            stmt.close();
            System.out.println("success");
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            try {
                c.rollback();
            } catch (Exception e1) {
                System.err.println(e1.getClass().getName() + ": " + e1.getMessage());
            }
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void pcsByMaker(String _maker) {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("PCs by maker: " + _maker);

        try {
            String sql = "select P.model as model, PC.price as price " +
                "from Product P, PC " +
                "where P.model = PC.model AND " +
                "maker = ?";

            // STEP: Execute a query
            PreparedStatement stmt = c.prepareStatement(sql);
            stmt.setString(1, _maker);
            ResultSet rs = stmt.executeQuery();

            // STEP: Extract data from result set
            System.out.printf("%10s %10s\n", "model", "price");
            System.out.println("-------------------------------");

            while (rs.next()) {
                int model = rs.getInt("model");
                int price = rs.getInt(2);
                System.out.printf("%10d %10d\n", model, price);
            }

            // STEP: Clean-up environment
            rs.close();
            stmt.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void productByMaker(String _pType, String _maker) {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println(_pType + " by maker: " + _maker);

        try {
            String sql = "select P.model as model, " +
                _pType + ".price as price " +
                "from Product P, " + _pType +
                " where P.model = " + _pType + ".model AND " +
                "maker = ?";

            // STEP: Execute a query
            PreparedStatement stmt = c.prepareStatement(sql);
            stmt.setString(1, _maker);
            ResultSet rs = stmt.executeQuery();

            // STEP: Extract data from result set
            System.out.printf("%10s %10s\n", "model", "price");
            System.out.println("-------------------------------");

            while (rs.next()) {
                int model = rs.getInt("model");
                int price = rs.getInt(2);
                System.out.printf("%10d %10d\n", model, price);
            }

            // STEP: Clean-up environment
            rs.close();
            stmt.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void allProductsByMaker(String _maker) {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Products by maker: " + _maker);

        try {
            String sql = "select P.model as model, P.type as type, PC.price as price " +
                "from Product P, PC " +
                "where P.model = PC.model AND " +
                "maker = ?";

            sql += " UNION ";

            sql += "select P.model as model, P.type as type, L.price as price " +
                "from Product P, Laptop L " +
                "where P.model = L.model AND " +
                "maker = ?";
            
            sql += " UNION ";

            sql += "select P.model as model, P.type as type, Pr.price as price " +
                "from Product P, Printer Pr " +
                "where P.model = Pr.model AND " +
                "maker = ?";

            // STEP: Execute a query
            PreparedStatement stmt = c.prepareStatement(sql);
            stmt.setString(1, _maker);
            stmt.setString(2, _maker);
            stmt.setString(3, _maker);
            ResultSet rs = stmt.executeQuery();

            // STEP: Extract data from result set
            System.out.printf("%10s %20s %10s\n", "model", "type", "price");
            System.out.println("-------------------------------");

            while (rs.next()) {
                int model = rs.getInt("model");
                String type = rs.getString("type");
                int price = rs.getInt(3);
                System.out.printf("%10d %20s %10d\n", model, type, price);
            }

            // STEP: Clean-up environment
            rs.close();
            stmt.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    public static void main(String args[]) {
        SQLiteJDBC sj = new SQLiteJDBC();
        
        sj.openConnection("data.sqlite");

        //sj.dropTables();
        //sj.createTables();
        //sj.populateTables();

        sj.pcsByMaker("A");
        sj.productByMaker("Laptop", "A");
        sj.allProductsByMaker("A");

        sj.closeConnection();
    }
}
