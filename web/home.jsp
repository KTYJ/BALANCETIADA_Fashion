<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
   <head>
      <!-- basic -->
      <meta charset="utf-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <!-- mobile metas -->
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <meta name="viewport" content="initial-scale=1, maximum-scale=1">
      <!-- site metas -->
      <title>Beautiflie</title>
      <meta name="keywords" content="">
      <meta name="description" content="">
      <meta name="author" content="">
      <!-- bootstrap css -->
      <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
      <!-- style css -->
      <link rel="stylesheet" type="text/css" href="css/style.css">
      <!-- Responsive-->
      <link rel="stylesheet" href="css/responsive.css">
      <!-- fevicon -->
      <link rel="icon" href="images/fevicon.png" type="image/gif" />
      <!-- Scrollbar Custom CSS -->
      <link rel="stylesheet" href="css/jquery.mCustomScrollbar.min.css">
      <!-- Tweaks for older IEs-->
      <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css">
      <!-- fonts -->
      <link href="https://fonts.googleapis.com/css?family=Great+Vibes|Open+Sans:400,700&display=swap&subset=latin-ext" rel="stylesheet">
      <!-- owl stylesheets --> 
      <link rel="stylesheet" href="css/owl.carousel.min.css">
      <link rel="stylesheet" href="css/owl.theme.default.min.css">
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/jquery.fancybox.min.css" media="screen">
      <link href="https://unpkg.com/gijgo@1.9.13/css/gijgo.min.css" rel="stylesheet" type="text/css" />
      <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
      <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
   <body>
      <!-- ** Header Area Start ** -->
   <header class="header-area header-sticky">
      <div class="container">
         <div class="row">
            <div class="col-12">
                  <nav class="main-nav">
                     <!-- ** Logo Start ** -->
                     <a href="home.html" class="logo">
                     <img src="/media/logo.png">
                     </a>
                     <!-- ** Logo End ** -->
                     <!-- ** Menu Start ** -->
                     <ul class="nav">
                        <li class="scroll-to-section"><a href="home.html">Home</a></li>
                                <li><a href="products.html" class="active">Products</a></li>
                                <li><a href="about.html">About Us</a></li>
                        </li>
                        <div class="cart_btn">
                         <li><a href="#explore"><ion-icon name="bag-handle-outline" style="font-size: 20px; vertical-align: text-top;"></ion-icon> CART (0)</a></li>
                        </div>
                        <div class="login_btn">
                            <li><a href="#explore">Login</a></li>
                        </div>
                    </ul>
                     <!-- ** Menu End ** -->
                  </nav>
            </div>
         </div>
      </div>
</header>
<!-- ** Header Area End ** -->
      <!-- banner section start -->
      <div class="banner_section layout_padding">
         <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
            <div class="carousel-inner">
               <div class="carousel-item active">
                  <div class="container">
                     <div class="row">
                        <div class="col-sm-6">
                           <p class="banner_text">Where bold design meets tranquil luxury — BALANCETIADA redefines high fashion with a unique blend of elegance, innovation, and streetwear sophistication, all set against serene surroundings that inspire timeless style.</p>
                           <div class="read_bt"><a href="#">Buy Now</a></div>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
      <!-- banner section end -->
 <!-- product section start -->
 <%
 // Database connection details
 String url = "jdbc:derby://localhost:1527/btdb";
 String user = "nbuser";
 String pass = "nbuser";

 Connection conn = null;
 Statement stmt = null;
 ResultSet rs = null;

 try {
     conn = DriverManager.getConnection(url, user, pass);
     stmt = conn.createStatement();
     String sql = "SELECT * FROM PRODUCT";
     rs = stmt.executeQuery(sql);

     int count = 0;
%>

<div class="product_section layout_padding">
 <div class="container">
     <div class="row">
         <div class="col-sm-12">
             <h1 class="product_taital">Trending Now</h1>
             <p class="product_text">“Our best of the season collection.”</p>
         </div>
     </div>
     <div class="product_section_2 layout_padding">
         <div class="row">
             <%
                 while (rs.next() && count < 4) {
                     String sku = rs.getString("sku");
                     String name = rs.getString("name");
                     count++;
             %>
             <div class="col-lg-3 col-sm-6">
                 <div class="product_box">
                     <h4 class="bursh_text"><%= sku %></h4>
                     <p class="lorem_text"><%= name %></p>
                     <img src="images/img-1.png" class="image_1">
                     <div class="btn_main">
                         <div class="buy_bt">
                             <ul>
                                 <li><a href="Products.html">EXPLORE</a></li>
                             </ul>
                         </div>
                     </div>
                 </div>
             </div>
             <%
                 }
             %>
         </div>

<%
 } catch (Exception e) {
     out.println("Error: " + e.getMessage());
 } finally {
     try { if (rs != null) rs.close(); } catch (Exception e) {}
     try { if (stmt != null) stmt.close(); } catch (Exception e) {}
     try { if (conn != null) conn.close(); } catch (Exception e) {}
 }
%>

            <div class="seemore_bt"><a href="#">See More</a></div>
            <div class="promo_row">
               <div class="row">
                  <div class="promo_box1">
                     <a href="member.html"> <img src="/media/promo-img.png" class="image_1"></a>
                  </div>
                  <div class="promo_box2">
                     <a href="member.html"> <img src="/media/join-member.png" class="image_1"></a>
                  </div>
               </div>
             </div>
           </div>
         </div>
      </div>
   </div>
   <!-- product section end -->
      <!-- footer section start -->
      <div class="footer_section layout_padding">
         <div class="container">
            <div class="contact_section_2">
               <div class="row">
                  <div class="col-sm-4">
                     <h3 class="address_text">Contact Us</h3>
                     <div class="address_bt">
                        <ul>
                           <li>
                              <a href="#">
                              <i class="fa fa-phone" aria-hidden="true"></i><span class="padding_left10">Call : +6012-3379156</span>
                              </a>
                           </li>
                           <li>
                              <a href="#">
                              <i class="fa fa-envelope" aria-hidden="true"></i><span class="padding_left10">Email : sjh@gmail.com</span>
                              </a>
                           </li>
                        </ul>
                     </div>
                  </div>
                  <div class="col-sm-4">
                     <div class="footer_1"><p>BALANCETIADA</p></div>
                     <p class="dummy_text">Balancetiada blends modern design with timeless values. Every piece is crafted to reflect balance, quality, and contemporary elegance.</p>
                  </div>
                  <div class="col-sm-4">
                     <div class="main">
                        <h3 class="address_text">Visit Us</h3>
                        <p class="ipsum_text">Tanjung Malim</p>
                        <p class="ipsum_text">Rawang</p>
                        <p class="ipsum_text">Sungai Buloh</p>
                        <p class="ipsum_text">Cheras</p>
                        <p class="ipsum_text">Puncak Alam</p>
                     </div>
                  </div>
               </div>
            </div>
            <div class="social_icon">
               <ul>
                  <li>
                     <a href="https://www.facebook.com/"><i class="fa fa-facebook" aria-hidden="true"></i></a>
                  </li>
                  <li>
                     <a href="https://www.twitter.com/"><i class="fa fa-twitter" aria-hidden="true"></i></a>
                  </li>
                  <li>
                     <a href="https://www.instagram.com/"><i class="fa fa-instagram" aria-hidden="true"></i></a>
                  </li>
               </ul>
            </div>
         </div>
      </div>
      <!-- footer section end -->
      <!-- copyright section start -->
      <div class="copyright_section">
         <div class="container">
            <p class="copyright_text">&copy; 2025 All Rights Reserved.</p>
         </div>
      </div>
      <!-- copyright section end -->
      <!-- Javascript files-->
      <script src="java/jquery.min.js"></script>
      <script src="java/popper.min.js"></script>
      <script src="java/bootstrap.bundle.min.js"></script>
      <script src="java/jquery-3.0.0.min.js"></script>
      <script src="java/plugin.js"></script>
      <!-- sidebar -->
      <script src="java/jquery.mCustomScrollbar.concat.min.js"></script>
      <script src="java/custom.js"></script>
      <!-- javascript --> 
      <script src="java/owl.carousel.js"></script>
      <script src="https:cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/jquery.fancybox.min.js"></script>  
      <script src="https://unpkg.com/gijgo@1.9.13/js/gijgo.min.js" type="text/javascript"></script>
      <script>
         function openNav() {
         document.getElementById("mySidenav").style.width = "100%";
         }
         
         function closeNav() {
         document.getElementById("mySidenav").style.width = "0";
         }
      </script> 
   </body>
</html>