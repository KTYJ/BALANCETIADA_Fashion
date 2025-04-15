/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.io.Serializable;
import jakarta.persistence.*;
import java.util.Random;

@Entity
@Table(name = "Staff")
@NamedQueries({
    @NamedQuery(
            name = "Staff.findByEmail",
            query = "SELECT s FROM Staff s WHERE s.email = :email"
    ),
    @NamedQuery(
            name = "Staff.findByType",
            query = "SELECT s FROM Staff s WHERE s.type = :type"
    ),
    @NamedQuery(
            name = "Staff.findByName",
            query = "SELECT s FROM Staff s WHERE s.name = :name"
    ),
    @NamedQuery(
            name = "Staff.findByIdAndPassword",
            query = "SELECT s FROM Staff s WHERE staffid = :email AND s.psw = :psw"
    )
})
public class Staff implements Serializable {

    @Id
    private String staffid;

    private String name;
    private String email;
    private String psw;
    private String type;

    // Constructors
    public Staff() {
    }

    public Staff(String id, String psw) {
        this.staffid = id;
        this.psw = psw;

    }


    public Staff(String id, String name, String email, String psw, String type) {
        this.staffid = id;
        this.name = name;
        this.email = email;
        this.psw = psw;
        this.type = type;
    }

    public static int generateStaffId() {
        Random random = new Random();
        return 10000 + random.nextInt(90000); // range: 10000 to 99999
    }
    
    // Getters and Setters
    public String getStaffid() {
        return staffid;
    }

    public void setStaffid(String staffid) {
        this.staffid = staffid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    //USE WITH CAUTION
    public void setPsw(String psw) {
        this.psw = psw;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    @Override
    public boolean equals(Object obj) {
        // Check if the object is the same as this instance
        if (this == obj) {
            return true;
        }

        // Check if the object is an instance of Staff
        if (obj == null || getClass() != obj.getClass()) {
            return false;
        }

        // Cast the object to a Staff type
        Staff otherStaff = (Staff) obj;

        // Compare the staffid and psw
        return this.staffid.equals(otherStaff.staffid) && this.psw.equals(otherStaff.psw);
    }

    public String toString() {
        return "Staff [staffid=" + staffid + ", name=" + name + ", email=" + email + ", psw=" + psw + ", type=" + type + "]";
    }
}
