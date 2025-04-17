/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import jakarta.persistence.*;

import java.sql.Timestamp;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

/**
 *
 * @author KTYJ
 */
@Entity
@Table(name = "Orders")
public class Orders {

    @Id
    private String orderId;

    private String custId;
    private Timestamp orderDate; //2024-10-24 12:50:30
    private String status;
    private String address;
    private String posCode;
    private String city;
    private String state;
    private double total;
    private String shipping;
    private ArrayList<Product> products;

    // Constructors
    public Orders() {

    }

    //full getter setter
    public Orders(String orderId, String custId, Timestamp orderDate, String status,
            String address, String posCode, String city, String state,
            double total, String shipping, ArrayList<Product> products) {
        this.orderId = orderId;
        this.custId = custId;
        this.orderDate = orderDate;
        this.status = status;
        this.address = address;
        this.posCode = posCode;
        this.city = city;
        this.state = state;
        this.total = total;
        this.shipping = shipping;
        this.products = products;
    }

    // Getters and Setters
    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getCustId() {
        return custId;
    }

    public void setCustId(String custId) {
        this.custId = custId;
    }

    public java.sql.Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPosCode() {
        return posCode;
    }

    public void setPosCode(String posCode) {
        this.posCode = posCode;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String getShipping() {
        return shipping;
    }

    public void setShipping(String shipping) {
        this.shipping = shipping;
    }

    public ArrayList<Product> getProducts() {
        return products;
    }

    public void setProducts(ArrayList<Product> products) {
        this.products = products;
    }

    //dateStr can look like "2024-10-24 12:50:30", "2025-01-01 00:00:00"
    public static Timestamp strToTimeStamp(String dateStr) {
        Timestamp timestamp = new java.sql.Timestamp(0);
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date parsedDate = dateFormat.parse(dateStr);
            timestamp = new Timestamp(parsedDate.getTime());
        } catch (Exception e) { //this generic but you can control another types of exception
            System.out.println("Error: " + e.getMessage());
        }

        return timestamp;
    }

    public static String timeStampToStr(Timestamp timestamp) {
        String dateStr = "";
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            dateStr = dateFormat.format(timestamp);
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
        return dateStr;

    }

    public void addProduct(Product product) {
        if (this.products == null) {
            this.products = new ArrayList<>();
        }
        products.add(product);
    }

    // Convert product list to string format
    public static String itemListToString(ArrayList<Product> products) {
        if (products == null || products.isEmpty()) {
            return "";
        }
        
        ArrayList<String> itemStrings = new ArrayList<>();
        for (Product p : products) {
            
            // Assuming the first size and quantity are used (quantity and category selected)
            String size = p.getSize() != null && p.getSize().length > 0 ? p.getSize()[0] : "";
            int quantity = p.getStock() != null && p.getStock().length > 0 ? p.getStock()[0] : 0;
            
            String itemStr = String.format("%s|%s|%s|%.2f|%d", 
                p.getName(), 
                p.getSku(), 
                size,
                p.getPrice(),
                quantity);
            itemStrings.add(itemStr);
        }
        return String.join("#", itemStrings);
    }

    // Convert string format to product list
    public static ArrayList<Product> stringToProductList(String combined) {
        ArrayList<Product> products = new ArrayList<>();
        if (combined == null || combined.trim().isEmpty()) {
            return products;
        }

        String[] itemArray = combined.split("#");
        for (String item : itemArray) {
            String[] parts = item.split("\\|");
            if (parts.length == 5) {
                String name = parts[0];
                String productId = parts[1];
                String[] size = new String[]{parts[2]}; // Create array with single size
                double price = Double.parseDouble(parts[3]);
                int[] qty = new int[]{Integer.parseInt(parts[4])}; // Create array with single quantity
                
                Product p = new Product();
                p.setName(name);
                p.setSku(productId);
                p.setSize(size);
                p.setPrice(price);
                p.setStock(qty);
                products.add(p);
            }
        }
        return products;
    }

    // Helper method to get combined string from order
    public String getItemsString() {
        return itemListToString(this.products);
    }

    // Helper method to set products from combined string
    public void setProductsFromString(String combined) {
        this.products = stringToProductList(combined);
    }


}
