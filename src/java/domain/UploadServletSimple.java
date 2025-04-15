/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package domain;

import model.Product;
import da.ProductDA;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.sql.SQLException;

/**
 *
 * @author KTYJ
 */
@WebServlet(name = "UploadServletSimple", urlPatterns = {"/UploadServletSimple"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 100 // 100 MB
)

public class UploadServletSimple extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        try{
        String sku = request.getParameter("sku");
        
        //File manage
        Part filePart = request.getPart("file");  // Retrieves <input type="file" name="file">
        String originalFileName = filePart.getSubmittedFileName();
        String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
        
        //THIS IS THE FILE NAME THAT WILL BE SAVED IN THE DATABASE
        String fileName = Toolkit.generateUID() + fileExtension;  // Add extension to generated ID
        String uploadPath = request.getServletContext().getRealPath("\\");
        
        ProductDA pda = new ProductDA();
        pda.updateFile(sku, fileName);
        
        //SAVE THE FILE TO THE LOCAL DIRECTORY if database is updated successfully
            for (Part part : request.getParts()) {              

                part.write("..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\" + uploadPath.substring(3) + "..\\..\\web\\upload\\" + fileName);          
                // Saves file to local directory ()
            
            }
            request.setAttribute("successMessage", "Changed image of " + sku.toUpperCase() +" successfully");
            request.getRequestDispatcher("addProdRes.jsp").forward(request, response); // Forward back to addProdRes.jsp
        
        }catch (SQLException e) {
            request.setAttribute("errorMessage", "INTERNAL ERROR: " + e.getMessage());
            request.getRequestDispatcher("addProdRes.jsp").forward(request, response); // Forward back to addProdRes.jsp

        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
