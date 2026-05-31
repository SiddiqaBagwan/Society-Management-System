/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.*;
import db.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

    public static ResultSet login(String email, String password) {
    try {
        Connection con = db.DBConnection.getConnection();

        String query = "SELECT * FROM users WHERE email=? AND password=? AND is_active=1 AND approval_status='approved'";

        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, email);
        ps.setString(2, password);

        return ps.executeQuery();

    } catch(Exception e) {
        e.printStackTrace();
    }
    return null;
}
    
    public static boolean isPending(String email) {
    try {
        Connection con = db.DBConnection.getConnection();

        String q = "SELECT * FROM users WHERE email=? AND approval_status='pending'";
        PreparedStatement ps = con.prepareStatement(q);
        ps.setString(1, email);

        ResultSet rs = ps.executeQuery();
        return rs.next();

    } catch(Exception e) {
        e.printStackTrace();
    }
    return false;
}

    public static String getUserRole(String email, String password) {
        try {
            Connection con = DBConnection.getConnection();

            String query = "SELECT role FROM users WHERE email=? AND password=?";
            PreparedStatement ps = con.prepareStatement(query);

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getString("role"); // admin or resident
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
    
    
    public static void registerUser(String name, String email, String phone, String password) {
    try {
        Connection con = db.DBConnection.getConnection();

        String q = "INSERT INTO users (name, email, phone, password, role, approval_status, is_active) VALUES (?, ?, ?, ?, 'resident', 'pending', 1)";

        PreparedStatement ps = con.prepareStatement(q);

        ps.setString(1, name);
        ps.setString(2, email);
        ps.setString(3, phone);
        ps.setString(4, password);

        ps.executeUpdate();

    } catch(Exception e) {
        e.printStackTrace();
    }
}
    
    public static ResultSet searchUsers(String keyword) {
    try {
        Connection con = db.DBConnection.getConnection();

        String query =
        "SELECT user_id, name, email, phone, role, is_active, approval_status, created_at " +
        "FROM users " +
        "WHERE is_active = 1 AND (name LIKE ? OR email LIKE ? OR phone LIKE ?)";

        PreparedStatement ps = con.prepareStatement(query);

        String k = "%" + keyword + "%";
        ps.setString(1, k);
        ps.setString(2, k);
        ps.setString(3, k);

        return ps.executeQuery();

    } catch(Exception e) {
        e.printStackTrace();
    }
    return null;
}
    
    
    public static ResultSet searchComplaints(String keyword) {
    try {
        Connection con = db.DBConnection.getConnection();

        String query =
        "SELECT c.complaint_id, u.name, c.description, c.priority, c.status, c.date_created " +
        "FROM complaints c " +
        "JOIN users u ON c.user_id = u.user_id " +
        "WHERE c.description LIKE ? OR u.name LIKE ?";

        PreparedStatement ps = con.prepareStatement(query);

        String k = "%" + keyword + "%";
        ps.setString(1, k);
        ps.setString(2, k);

        return ps.executeQuery();

    } catch(Exception e) {
        e.printStackTrace();
    }
    return null;
}

    public static String getUserName(String email) {
        try {
            Connection con = db.DBConnection.getConnection();

            String query = "SELECT name FROM users WHERE email=?";
            PreparedStatement ps = con.prepareStatement(query);

            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getString("name");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return "User";
    }

    public static String getFlatDetails(String email) {
        try {
            Connection con = db.DBConnection.getConnection();

            String query = "SELECT f.block, f.flat_number, fa.type "
                    + "FROM users u "
                    + "JOIN flat_allocation fa ON u.user_id = fa.user_id "
                    + "JOIN flats f ON fa.flat_id = f.flat_id "
                    + "WHERE u.email=?";

            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String block = rs.getString("block");
                String flat = rs.getString("flat_number");
                String type = rs.getString("type");

                return block + "-" + flat + " (" + type + ")";
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return "No Flat Assigned";
    }

    public static ResultSet getUserDetails(String email) {
        try {
            Connection con = DBConnection.getConnection();

            String query = "SELECT u.name, u.email, u.phone, "
                    + "f.block, f.flat_number, fa.type "
                    + "FROM users u "
                    + "JOIN flat_allocation fa ON u.user_id = fa.user_id "
                    + "JOIN flats f ON fa.flat_id = f.flat_id "
                    + "WHERE u.email=?";

            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, email);

            return ps.executeQuery();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
/*
    public static ResultSet getMaintenance(String email) {
        try {
            Connection con = db.DBConnection.getConnection();

            String query = "SELECT m.maintenance_id, f.block, f.flat_number, m.month, m.year, m.amount, m.status "
                    + "FROM users u "
                    + "JOIN flat_allocation fa ON u.user_id = fa.user_id "
                    + "JOIN flats f ON fa.flat_id = f.flat_id "
                    + "JOIN maintenance m ON f.flat_id = m.flat_id "
                    + "WHERE u.email=?";

            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, email);

            return ps.executeQuery();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }*/
/*
    public static void payMaintenance(int maintenanceId, double amount) {
        try {
            Connection con = db.DBConnection.getConnection();

            String query = "INSERT INTO payments (maintenance_id, payment_date, amount_paid, payment_mode, status) "
                    + "VALUES (?, CURDATE(), ?, 'online', 'success')";

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, maintenanceId);
            ps.setDouble(2, amount);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
*/
    public static ResultSet getComplaints(String email) {
         try {
        Connection con = db.DBConnection.getConnection();

        String query = "SELECT c.complaint_id, c.description, c.priority, c.status, c.date_created "
                + "FROM complaints c "
                + "JOIN users u ON c.user_id = u.user_id "
                + "WHERE u.email=?";

        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, email);

        return ps.executeQuery();

    } catch (Exception e) {
        e.printStackTrace();
    }
    return null;
    }

    public static void addComplaint(String email, String desc, String priority) {
        try {
            Connection con = db.DBConnection.getConnection();

            String query = "INSERT INTO complaints (user_id, flat_id, description, priority, status, date_created) "
                    + "SELECT u.user_id, fa.flat_id, ?, ?, 'pending', CURDATE() "
                    + "FROM users u "
                    + "JOIN flat_allocation fa ON u.user_id = fa.user_id "
                    + "WHERE u.email=?";

            PreparedStatement ps = con.prepareStatement(query);

            ps.setString(1, desc);
            ps.setString(2, priority);
            ps.setString(3, email);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static ResultSet getAllComplaints() {
        try {
            Connection con = db.DBConnection.getConnection();

            String query = "SELECT c.complaint_id, u.name, f.block, f.flat_number, "
                    + "c.description, c.priority, c.status, c.date_created, c.resolved_date "
                    + "FROM complaints c "
                    + "JOIN users u ON c.user_id = u.user_id "
                    + "JOIN flats f ON c.flat_id = f.flat_id";

            PreparedStatement ps = con.prepareStatement(query);

            return ps.executeQuery();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void resolveComplaint(int complaintId) {
    try {
        Connection con = db.DBConnection.getConnection();

        CallableStatement cs = con.prepareCall("{CALL resolve_complaint(?)}");
        cs.setInt(1, complaintId);

        cs.execute();

    } catch(Exception e) {
        e.printStackTrace();
    }
}
/*
    public static ResultSet getAllPayments() {
        try {
            Connection con = db.DBConnection.getConnection();

            String query = "SELECT p.payment_id, u.name, f.block, f.flat_number, "
                    + "p.amount_paid, p.payment_date, p.payment_mode, p.transaction_id, p.status "
                    + "FROM payments p "
                    + "JOIN maintenance m ON p.maintenance_id = m.maintenance_id "
                    + "JOIN flats f ON m.flat_id = f.flat_id "
                    + "JOIN flat_allocation fa ON f.flat_id = fa.flat_id "
                    + "JOIN users u ON fa.user_id = u.user_id";

            PreparedStatement ps = con.prepareStatement(query);

            return ps.executeQuery();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
  */  
    public static void addUser(String name, String email, String password, String phone, String role) {
    try {
        Connection con = db.DBConnection.getConnection();

        String query = "INSERT INTO users (name, email, phone, password, role) VALUES (?, ?, ?, ?, ?)";

        PreparedStatement ps = con.prepareStatement(query);

        ps.setString(1, name);
        ps.setString(2, email);
        ps.setString(3, phone);
        ps.setString(4, password);
        ps.setString(5, role);

        ps.executeUpdate();

    } catch(Exception e) {
        e.printStackTrace();
    }
}
    
    public static ResultSet getAllUsers() {
    try {
        Connection con = db.DBConnection.getConnection();

        String query = "SELECT user_id, name, email, phone, role, is_active, approval_status, created_at FROM users WHERE is_active = 1";

        PreparedStatement ps = con.prepareStatement(query);

        return ps.executeQuery();

    } catch(Exception e) {
        e.printStackTrace();
    }
    return null;
}
    
    public static ResultSet getPendingUsers() {
    try {
        Connection con = db.DBConnection.getConnection();

        String query = "SELECT user_id, name, email, phone, role, is_active, approval_status, created_at FROM users WHERE approval_status='pending'";

        PreparedStatement ps = con.prepareStatement(query);

        return ps.executeQuery();

    } catch(Exception e) {
        e.printStackTrace();
    }
    return null;
}
    
    public static void updateUser(int userId, String name, String phone) {
    try {
        Connection con = db.DBConnection.getConnection();

        String query = "UPDATE users SET name=?, phone=? WHERE user_id=?";

        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, name);
        ps.setString(2, phone);
        ps.setInt(3, userId);

        ps.executeUpdate();

    } catch(Exception e) {
        e.printStackTrace();
    }
}
    
    
    public static ResultSet getUserByEmail(String email) {
    try {
        Connection con = db.DBConnection.getConnection();

        String query = "SELECT * FROM users WHERE email=?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, email);

        return ps.executeQuery();

    } catch(Exception e) {
        e.printStackTrace();
    }
    return null;
}
    
    public static void updatePassword(int userId, String newPassword) {
    try {
        Connection con = db.DBConnection.getConnection();

        String query = "UPDATE users SET password=? WHERE user_id=?";

        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, newPassword);
        ps.setInt(2, userId);

        ps.executeUpdate();

    } catch(Exception e) {
        e.printStackTrace();
    }
}
    
    public static void updateEmail(int userId, String email) {
    try {
        Connection con = db.DBConnection.getConnection();

        String query = "UPDATE users SET email=? WHERE user_id=?";

        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, email);
        ps.setInt(2, userId);

        ps.executeUpdate();

    } catch(Exception e) {
        e.printStackTrace();
    }
}
    
    
    public static boolean updateFlat(int flatId, String block, String flatNo, int floor) {
    try {
        Connection con = db.DBConnection.getConnection();

        // 🔥 CHECK DUPLICATE FIRST
        String checkQuery = "SELECT * FROM flats WHERE block=? AND flat_number=? AND flat_id != ?";
        PreparedStatement checkPs = con.prepareStatement(checkQuery);

        checkPs.setString(1, block);
        checkPs.setString(2, flatNo);
        checkPs.setInt(3, flatId);

        ResultSet rs = checkPs.executeQuery();

        if(rs.next()) {
            return false; // ❌ already exists
        }

        // ✅ UPDATE
        String query = "UPDATE flats SET block=?, flat_number=?, floor=? WHERE flat_id=?";
        PreparedStatement ps = con.prepareStatement(query);

        ps.setString(1, block);
        ps.setString(2, flatNo);
        ps.setInt(3, floor);
        ps.setInt(4, flatId);

        ps.executeUpdate();

        return true;

    } catch(Exception e) {
        e.printStackTrace();
    }
    return false;
}
    
    
    
    public static void approveUser(int userId) {
    try {
        Connection con = db.DBConnection.getConnection();

        CallableStatement cs = con.prepareCall("{CALL approve_user(?)}");
        cs.setInt(1, userId);

        cs.execute();

    } catch(Exception e) {
        e.printStackTrace();
    }
}
  /*  
    public static void generateMaintenance(int month, int year, double amount) {
    try {
        Connection con = db.DBConnection.getConnection();

        String query = "INSERT INTO maintenance (flat_id, month, year, amount, status) " +
                       "SELECT flat_id, ?, ?, ?, 'unpaid' FROM flats";

        PreparedStatement ps = con.prepareStatement(query);

        ps.setInt(1, month);
        ps.setInt(2, year);
        ps.setDouble(3, amount);

        ps.executeUpdate();

    } catch(Exception e) {
        e.printStackTrace();
    }
}*/
    public static ResultSet getFlatDetails() {
    try {
        Connection con = db.DBConnection.getConnection();

        String query = "SELECT f.flat_id, f.block, f.flat_number, f.floor, " +
                       "u.name, fa.type, fa.start_date " +
                       "FROM flats f " +
                       "LEFT JOIN flat_allocation fa ON f.flat_id = fa.flat_id " +
                       "LEFT JOIN users u ON fa.user_id = u.user_id";

        PreparedStatement ps = con.prepareStatement(query);

        return ps.executeQuery();

    } catch(Exception e) {
        e.printStackTrace();
    }
    return null;
}
    public static java.sql.ResultSet getAllFlats() {
    try {
        java.sql.Connection con = db.DBConnection.getConnection();

        String query = "SELECT * FROM flats";

        java.sql.PreparedStatement ps = con.prepareStatement(query);

        return ps.executeQuery();

    } catch(Exception e) {
        e.printStackTrace();
    }
    return null;
}
    
    public static void deactivateUser(int userId) {
    try {
        Connection con = db.DBConnection.getConnection();

        String query = "UPDATE users SET is_active=0 WHERE user_id=?";
        PreparedStatement ps = con.prepareStatement(query);

        ps.setInt(1, userId);
        ps.executeUpdate();

    } catch(Exception e) {
        e.printStackTrace();
    }
}
    
    public static boolean deleteFlat(int flatId) {
    try {
        Connection con = db.DBConnection.getConnection();

        // check active allocation
        String check = "SELECT * FROM flat_allocation WHERE flat_id=? AND end_date IS NULL";
        PreparedStatement ps1 = con.prepareStatement(check);
        ps1.setInt(1, flatId);

        ResultSet rs = ps1.executeQuery();

        if(rs.next()) {
            return false; // ❌ cannot delete
        }

        // delete flat
        String query = "DELETE FROM flats WHERE flat_id=?";
        PreparedStatement ps2 = con.prepareStatement(query);
        ps2.setInt(1, flatId);

        ps2.executeUpdate();

        return true;

    } catch(Exception e) {
        e.printStackTrace();
    }
    return false;
}
    
    public static void deleteComplaint(int complaintId, String email) {
    try {
        Connection con = db.DBConnection.getConnection();

        String query =
        "DELETE c FROM complaints c " +
        "JOIN users u ON c.user_id = u.user_id " +
        "WHERE c.complaint_id=? AND u.email=?";

        PreparedStatement ps = con.prepareStatement(query);

        ps.setInt(1, complaintId);
        ps.setString(2, email);

        ps.executeUpdate();

    } catch(Exception e) {
        e.printStackTrace();
    }
}
    
    public static void updateStaff(int staffId, String name, String role, String phone, String shift, double salary) {
    try {
        Connection con = db.DBConnection.getConnection();

        String query = "UPDATE staff SET name=?, role=?, phone=?, shift=?, salary=? WHERE staff_id=?";
        PreparedStatement ps = con.prepareStatement(query);

        ps.setString(1, name);
        ps.setString(2, role);
        ps.setString(3, phone);
        ps.setString(4, shift);
        ps.setDouble(5, salary);
        ps.setInt(6, staffId);

        ps.executeUpdate();

    } catch(Exception e) {
        e.printStackTrace();
    }
}
    
    public static void deleteStaff(int staffId) {
    try {
        Connection con = db.DBConnection.getConnection();

        String query = "DELETE FROM staff WHERE staff_id=?";
        PreparedStatement ps = con.prepareStatement(query);

        ps.setInt(1, staffId);
        ps.executeUpdate();

    } catch(Exception e) {
        e.printStackTrace();
    }
}
    
    public static void assignFlat(int userId, int flatId, String type) {
    try {
        Connection con = db.DBConnection.getConnection();

        CallableStatement cs = con.prepareCall("{CALL assign_flat(?, ?, ?)}");

        cs.setInt(1, userId);
        cs.setInt(2, flatId);
        cs.setString(3, type);

        cs.execute();

    } catch(Exception e) {
        e.printStackTrace();
    }
}
    
    public static boolean isFlatAssigned(int flatId) {
    boolean assigned = false;

    try {
        Connection con = db.DBConnection.getConnection();

        String query = "SELECT 1 FROM flat_allocation WHERE flat_id=? AND end_date IS NULL";

        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, flatId);

        ResultSet rs = ps.executeQuery();

        if(rs.next()) {
            assigned = true; // flat currently assigned
        }

    } catch(Exception e) {
        e.printStackTrace();
    }

    return assigned;
}
    
    public static void addFlat(String block, String flatNumber, int floor) {
    try {
        Connection con = db.DBConnection.getConnection();

        String query = "INSERT INTO flats (block, flat_number, floor) VALUES (?, ?, ?)";

        PreparedStatement ps = con.prepareStatement(query);

        ps.setString(1, block);
        ps.setString(2, flatNumber);
        ps.setInt(3, floor);

        ps.executeUpdate();

    } catch(Exception e) {
        e.printStackTrace();
    }
}
    
    public static ResultSet getAllStaff() {
    try {
        Connection con = db.DBConnection.getConnection();

        String query = "SELECT * FROM staff";
        PreparedStatement ps = con.prepareStatement(query);

        return ps.executeQuery();

    } catch(Exception e) {
        e.printStackTrace();
    }
    return null;
}
    
    public static void addStaff(String name, String role, String phone, String shift, double salary) {
    try {
        Connection con = db.DBConnection.getConnection();

        String query = "INSERT INTO staff (name, role, phone, shift, salary, joining_date) VALUES (?, ?, ?, ?, ?, CURDATE())";

        PreparedStatement ps = con.prepareStatement(query);

        ps.setString(1, name);
        ps.setString(2, role);
        ps.setString(3, phone);
        ps.setString(4, shift);
        ps.setDouble(5, salary);

        ps.executeUpdate();

    } catch(Exception e) {
        e.printStackTrace();
    }
}
    
    
    
    
    
    
}
