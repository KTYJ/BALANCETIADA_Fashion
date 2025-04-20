package model;

public class Customer {
    private String custID;
    private String firstName;
    private String lastName;
    private String email;
    private String password;
    
    public Customer() {
    }
    
    public Customer(String custID, String firstName, String lastName, String email, String password) {
        this.custID = custID;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.password = password;
    }
    
    // Getters and setters
    public String getCustID() {
        return custID;
    }
    
    public void setCustID(String custID) {
        this.custID = custID;
    }
    
    public String getFirstName() {
        return firstName;
    }
    
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }
    
    public String getLastName() {
        return lastName;
    }
    
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    // Helper method to get full name
    public String getFullName() {
        return firstName + " " + lastName;
    }
} 