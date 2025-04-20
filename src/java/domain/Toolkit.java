/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package domain;

/**
 *
 * @author KTYJ
 */

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.UUID;


public class Toolkit {

    // Hash password using SHA-256
    public static String hashPsw(String password) {
        try {
            // Create MessageDigest instance for SHA-256
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            
            // Add password bytes to digest
            md.update(password.getBytes());
            
            // Get the hashed bytes
            byte[] hashedBytes = md.digest();
            
            // Convert bytes to hexadecimal format
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }
            
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            // If SHA-256 is not available (very unlikely), return a simple hash
            return String.valueOf(password.hashCode());
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

    public static String generateSku(String name, String size, String price){
        String sku = name.substring(0, 3).toUpperCase() + size.substring(0, 1).toUpperCase() + price.substring(0, 3).toUpperCase();
        return sku;
    }

    public static String generateUID() {
        // Generate a random UUID and take first 8 characters
        return UUID.randomUUID().toString().substring(0, 8);
    }

    

    
}
