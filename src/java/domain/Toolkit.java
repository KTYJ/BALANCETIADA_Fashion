/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package domain;

/**
 *
 * @author KTYJ
 */

import da.StaffDA;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.Random;
import java.util.UUID;


public class Toolkit {
    private static HashSet<String> existingIds = new HashSet<>();
    private static Random random = new Random();

    // Hash password using SHA-256
    public static String hashPsw(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");

            byte[] hashBytes = md.digest(password.getBytes());
            StringBuilder hexString = new StringBuilder();

            for (byte b : hashBytes) {
                // Convert byte to hex
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1)
                    hexString.append('0');
                hexString.append(hex);
            }

            return hexString.toString();

        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }

    //convert string array to pipe delimited string
    public static String arrayToString(String[] array) {
        StringBuilder result = new StringBuilder();

        for (int i = 0; i < array.length; i++) {
            String upper = array[i].toUpperCase();
            result.append(upper);

            if (i < array.length - 1) {
                result.append("|");
            }
        }

        return result.toString();

    }

    //convert int array to pipe delimited string
    public static String arrayToString(int[] array) {
        StringBuilder result = new StringBuilder();

        for (int i = 0; i < array.length; i++) {
            result.append(Integer.toString(array[i]));

            if (i < array.length - 1) {
                result.append("|");
            }
        }

        return result.toString();
    }

    //convert pipe delimited string to string array
    public static String[] stringToStrArray(String str) {
        return str.split("\\|");
    }

    //convert pipe delimited string to int array
    public static int[] stringToIntArray(String str) {
        String[] strArray = stringToStrArray(str);
        int[] intArray = new int[strArray.length];
        for (int i = 0; i < strArray.length; i++) {
            intArray[i] = Integer.parseInt(strArray[i]);
        }
        return intArray;
    }


    public static String generateUID() {
        // Generate a random UUID and return it as a string (without dashes)
        UUID uuid = UUID.randomUUID();
        return uuid.toString().replace("-", "").substring(0, 8);  // Taking first 8 characters as the ID
    }

    public static synchronized String generateDigitUID() {
        String uniqueId;
        do {
            uniqueId = String.format("%05d", random.nextInt(100000)); // Generates a 5-digit number
        } while (existingIds.contains(uniqueId)); // Check for uniqueness
        existingIds.add(uniqueId); // Add to existing IDs
        return uniqueId;
    }

    public static String generateUniqueStaffId() throws SQLException {
        String staffId;
        boolean exists;

        do {
            StaffDA staffDA = new StaffDA();
            // Generate a random 5-digit number as a string
            staffId = String.format("%05d", (int) (Math.random() * 100000));
            
            // Check if the ID already exists in the database
            exists = (staffDA.findById(staffId) != null);
        } while (exists); // Repeat until a unique ID is found

        return staffId; // Return the unique staff ID
    }
}

    

