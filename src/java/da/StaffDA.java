/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package da;

/**
 *
 * @author KTYJ
 */
import model.Staff;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.*;
import java.util.List;

public class StaffDA {
    @PersistenceContext EntityManager em;

    private EntityManagerFactory emf;

    public StaffDA() {
    }

    public void createStaff(Staff staff) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.persist(staff);
        em.getTransaction().commit();
        em.close();
    }

    public Staff findStaffById(String staffId) {
        EntityManager em = emf.createEntityManager();
        Staff staff = em.find(Staff.class, staffId);
        em.close();
        return staff;
    }

    public List<Staff> findAllStaff() {
        EntityManager em = emf.createEntityManager();
        TypedQuery<Staff> query = em.createQuery("SELECT s FROM Staff s", Staff.class);
        List<Staff> staffList = query.getResultList();
        em.close();
        return staffList;
    }

    public void updateStaff(Staff staff) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.merge(staff);
        em.getTransaction().commit();
        em.close();
    }

    public void deleteStaff(String staffId) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        Staff staff = em.find(Staff.class, staffId);
        if (staff != null) {
            em.remove(staff);
        }
        em.getTransaction().commit();
        em.close();
    }

    public void close() {
        if (emf != null) {
            emf.close();
        }
    }
}
