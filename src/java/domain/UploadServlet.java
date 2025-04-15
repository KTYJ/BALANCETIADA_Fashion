/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package domain;

import model.Product;
import da.ProductDA;
import java.sql.*;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/UploadServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 100 // 100 MB
)

public class UploadServlet extends HttpServlet {
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {

        String sku = request.getParameter("sku");
        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));
        int cat = Integer.parseInt(request.getParameter("cat"));
        String desc = request.getParameter("desc");
        int sold = Integer.parseInt(request.getParameter("sold"));
        int[] stock = Toolkit.stringToIntArray(request.getParameter("stock"));
        String[] size = Toolkit.stringToStrArray(request.getParameter("size"));

        Part filePart = request.getPart("file");  // Retrieves <input type="file" name="file">
        String originalFileName = filePart.getSubmittedFileName();
        String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));

        //THIS IS THE FILE NAME THAT WILL BE SAVED IN THE DATABASE
        String fileName = Toolkit.generateUID() + fileExtension;  // Add extension to generated ID
        String uploadPath = request.getServletContext().getRealPath("\\");
        
        

        //CREATE A NEW PRODUCT OBJECT
        //(String sku, String name, String file, int[] stock, String description, int catId, String[] size, double price, int sold)
        
        Product product = new Product(sku, name, fileName, stock, desc, cat, size, price, sold);


        //ADD THE PRODUCT TO THE DATABASE
        

            ProductDA productDA = new ProductDA();
            productDA.addProduct(product);

            
            //SAVE THE FILE TO THE LOCAL DIRECTORY if database is updated successfully
            for (Part part : request.getParts()) {              

                part.write("..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\" + uploadPath.substring(3) + "..\\..\\web\\upload\\" + fileName);          // Saves file to local directory
            
            }
            request.setAttribute("successMessage", "Product " + name + " added successfully");
            request.getRequestDispatcher("addProdRes.jsp").forward(request, response); // Forward back to addProdRes.jsp

        } catch (SQLException e) {
            request.setAttribute("errorMessage", "INTERNAL ERROR: " + e.getMessage());
            request.getRequestDispatcher("addProdRes.jsp").forward(request, response); // Forward back to addProdRes.jsp

        }

        
        //response.getWriter().print("File uploaded as " + fileName);

    }

    // </editor-fold>
}
