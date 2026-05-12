package com.thoughtsofnomads.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    // serverTimezone=UTC is critical — without it MySQL uses local time (Nepal UTC+5:45)
    // which caused the lockout timer to show 355 minutes instead of 10
    private static final String URL = "jdbc:mysql://localhost:3306/thoughts_of_nomads?useSSL=false&serverTimezone=UTC";
    private static final String USER = "admin";
    private static final String PASSWORD = "your_password";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println("Failed to load MySQL JDBC Driver");
            e.printStackTrace();
        }
    }

    // every DAO calls this — connection pooling would be better for production
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}