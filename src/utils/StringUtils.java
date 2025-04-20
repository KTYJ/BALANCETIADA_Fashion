package utils;

import java.util.ArrayList;
import java.util.stream.Collectors;

public class StringUtils {
    
    /**
     * Converts an ArrayList of strings to a single pipe-delimited string with uppercase values
     * @param list The ArrayList of strings to convert
     * @return A single string with all elements joined by '|' and converted to uppercase
     */
    public static String arrayListToUpperPipeString(ArrayList<String> list) {
        if (list == null || list.isEmpty()) {
            return "";
        }
        
        return list.stream()
                .map(String::toUpperCase)
                .collect(Collectors.joining("|"));
    }
} 