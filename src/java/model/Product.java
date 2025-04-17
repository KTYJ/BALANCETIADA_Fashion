package model;

import java.io.Serializable;
import java.util.Arrays;

public class Product implements Serializable {

    private String sku;
    private String name;
    private String file;
    private int[] stock;
    private String description;
    private int catId;
    private String[] size;
    private double price;
    private int sold;

    // Default constructor
    public Product() {
    }

    // Constructor with all fields
    public Product(String sku, String name, String file, int[] stock,
            String description, int catId, String[] size,
            double price, int sold) {
        this.sku = sku;
        this.name = name;
        this.file = file;
        this.stock = stock;
        this.description = description;
        this.catId = catId;
        this.size = size;
        this.price = price;
        this.sold = sold;
    }

    // constructor without the file parameter
    public Product(String sku, String name, int[] stock,
            String description, int catId, String[] size,
            double price, int sold) {
        this.sku = sku;
        this.name = name;
        this.stock = stock;
        this.description = description;
        this.catId = catId;
        this.size = size;
        this.price = price;
        this.sold = sold;
    }

    //contstructor for order product
    public Product(String name, String sku, String[] size, double price, int[] qty) {
        this.name = name;
        this.sku = sku;
        this.price = price;

        //are arrays, but lets just focus on the first elemnt
        
        this.stock = qty; //assuming this is order quantity
        this.size = size; //how many i bought?
    }

    public String updateStockStr(String targetSize, int newStock) {
        if (size == null || stock == null) {
            return null;
        }

        // Use arraycopy to clone stock array
        int[] updatedStock = new int[stock.length];
        System.arraycopy(stock, 0, updatedStock, 0, stock.length);

        // Update the stock for the given size
        for (int i = 0; i < size.length; i++) {
            if (size[i].equalsIgnoreCase(targetSize)) {
                updatedStock[i] = newStock;
                break;
            }
        }

        // Convert to pipe-separated string
        StringBuilder stockStr = new StringBuilder();
        for (int i = 0; i < updatedStock.length; i++) {
            stockStr.append(updatedStock[i]);
            if (i < updatedStock.length - 1) {
                stockStr.append("|");
            }
        }

        return stockStr.toString();
    }

    // Getters and Setters
    public String getSku() {
        return sku;
    }

    public void setSku(String sku) {
        this.sku = sku;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getFile() {
        return file;
    }

    public void setFile(String file) {
        this.file = file;
    }

    //array yaaaaaaa
    public int[] getStock() {
        return stock;
    }

    public void setStock(int[] stock) {
        this.stock = stock;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getCatId() {
        return catId;
    }

    public void setCatId(int catId) {
        this.catId = catId;
    }

    //array yaaaaaaa
    public String[] getSize() {
        return size;
    }

    public void setSize(String[] size) {
        this.size = size;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getSold() {
        return sold;
    }

    public void setSold(int sold) {
        this.sold = sold;
    }

    public String getCatName() {
        switch (this.catId) {
            case 1:
                return "Men";
            case 2:
                return "Women";
            default:
                return "Kids";
        }
    }

    @Override
    public String toString() {
        return "Product{"
                + "sku='" + sku + '\''
                + ", name='" + name + '\''
                + ", file='" + file + '\''
                + ", stock=" + Arrays.toString(stock)
                + ", description='" + description + '\''
                + ", catId=" + catId
                + ", size=" + Arrays.toString(size)
                + ", price=" + price
                + ", sold=" + sold
                + '}';
    }


    
}
