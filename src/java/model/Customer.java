/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import jakarta.persistence.*;
/*


author KTYJ

*/
@Entity
@Table(name = "customer")
public class Customer {

    @Id
    private String custid;
    private String fname;
    private String lname;
    private String email;
    private String psw;

    // Constructors
    public Customer() {
    }

    public Customer(String custid, String fname, String lname, String email, String psw) {
        this.custid = custid;
        this.fname = fname;
        this.lname = lname;
        this.email = email;
        this.psw = psw;
    }

    // Getters and Setters
    public String getCustid() {
        return custid;
    }

    public void setCustid(String custid) {
        this.custid = custid;
    }

    public String getFname() {
        return fname;
    }

    public void setFname(String fname) {
        this.fname = fname;
    }

    public String getLname() {
        return lname;
    }

    public void setLname(String lname) {
        this.lname = lname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPsw() {
        return psw;
    }
    
    //should be avoided to prevent hacks, USE WITH CAUTION
    public void SetPsw(String newPsw) {
        this.psw = newPsw;
    }

    
}


