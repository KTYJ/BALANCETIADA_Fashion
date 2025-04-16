<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <link href="https://fonts.googleapis.com/css?family=Poppins:100,200,300,400,500,600,700,800,900&display=swap" rel="stylesheet">
        <link href="https://unpkg.com/gijgo@1.9.13/css/gijgo.min.css" rel="stylesheet" type="text/css" />
        <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
        <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <title>Hexashop Ecommerce HTML CSS Template</title>

        <!-- Additional CSS Files -->
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">

        <link rel="stylesheet" type="text/css" href="css/font-awesome.css">

        <link rel="stylesheet" href="css/Products.css">

        <link rel="stylesheet" href="css/owl-carousel.css">

        <link rel="stylesheet" href="css/lightbox.css">

    </head>

    <body>

        <!-- ***** Preloader Start ***** -->
        <div id="preloader">
            <div class="jumper">
                <div></div>
                <div></div>
                <div></div>
            </div>
        </div>  
        <!-- ***** Preloader End ***** -->

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

        <!-- ***** Main Banner Area Start ***** -->
        <div class="main-banner" id="top">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-6">
                        <div class="left-content">
                            <div class="thumb">
                                <div class="inner-content">
                                    <h4 class="poppins-regular special-gothic-condensed-one-regular">BALANCETIADA</h4>
                                    <span>Fashion - Beauty & Dress Up </span>
                                    <!-- <div class="main-border-button">
                                        <a href="#">Purchase Now!</a>
                                    </div> -->
                                </div>
                                <img src="media/left-banner-image.jpg" alt="">
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="right-content">
                            <div class="row">
                                <div class="col-lg-6">
                                    <div class="right-first-image">
                                        <div class="thumb">
                                            <div class="inner-content">
                                                <h4>Women</h4>
                                                <span>Best Clothes For Women</span>
                                            </div>
                                            <div class="hover-content">
                                                <div class="inner">
                                                    <h4>Women</h4>
                                                    <p>Lorem ipsum dolor sit amet, conservisii ctetur adipiscing elit incid.</p>
                                                    <div class="main-border-button">
                                                        <li class="scroll-to-section"><a href="#women">Discover More</a></li>
                                                    </div>
                                                </div>
                                            </div>
                                            <img src="media/baner-right-image-01.jpg">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="right-first-image">
                                        <div class="thumb">
                                            <div class="inner-content">
                                                <h4>Men</h4>
                                                <span>Best Clothes For Men</span>
                                            </div>
                                            <div class="hover-content">
                                                <div class="inner">
                                                    <h4>Men</h4>
                                                    <p>Lorem ipsum dolor sit amet, conservisii ctetur adipiscing elit incid.</p>
                                                    <div class="main-border-button">
                                                        <li class="scroll-to-section"><a href="#men">Discover More</a></li>
                                                    </div>
                                                </div>
                                            </div>
                                            <img src="media/baner-right-image-02.jpg">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6" style="left: 188px">
                                    <div class="right-first-image">
                                        <div class="thumb">
                                            <div class="inner-content">
                                                <h4>Kids</h4>
                                                <span>Best Clothes For Kids</span>
                                            </div>
                                            <div class="hover-content">
                                                <div class="inner">
                                                    <h4>Kids</h4>
                                                    <p>Lorem ipsum dolor sit amet, conservisii ctetur adipiscing elit incid.</p>
                                                    <div class="main-border-button">
                                                        <li class="scroll-to-section"><a href="#kids">Discover More</a></li>
                                                    </div>
                                                </div>
                                            </div>
                                            <img src="media/baner-right-image-03.jpg">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- ***** Main Banner Area End ***** -->

        <%
            Map<String, List<model.Product>> productMap = (Map<String, List<model.Product>>) request.getAttribute("productMap");
        %>

        <!-- ***** Trending Area Starts ***** -->
        <section class="section" id="trending">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6">
                        <div class="section-heading">
                            <h2>Trending</h2>
                            <span>Latest trending items from BalanceTiada.</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-12">
                    <div class="trending-item-carousel">
                        <div class="owl-trending-item owl-carousel">
                            <c:forEach var="product" items="${productMap.trending}">
                                <div class="item">
                                    <div class="thumb">
                                        <div class="hover-content">
                                            <ul>
                                                <li><a href="single-product?sku=${product.sku}"><i class="fa fa-eye"></i></a></li>
                                                <li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
                                            </ul>
                                        </div>
                                        <img src="${product.file}" alt="${product.name}">
                                    </div>
                                    <div class="down-content">
                                        <h4>${product.name}</h4>
                                        <span>$${product.price}</span>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- ***** Trending Area Ends ***** -->

        <!-- ***** Women Area Starts ***** -->
        <section class="section" id="women">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6">
                        <div class="section-heading">
                            <h2>Women's Latest</h2>
                            <span>Details to details is what makes Hexashop different from the other themes.</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="women-item-carousel">
                            <div class="owl-women-item owl-carousel">
                                <c:forEach var="product" items="${productMap.women}">
                                    <div class="item">
                                        <div class="thumb">
                                            <div class="hover-content">
                                                <ul>
                                                    <li><a href="single-product?sku=${product.sku}"><i class="fa fa-eye"></i></a></li>
                                                    <li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
                                                </ul>
                                            </div>
                                            <img src="${product.file}" alt="${product.name}">
                                        </div>
                                        <div class="down-content">
                                            <h4>${product.name}</h4>
                                            <span>$${product.price}</span>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- ***** Women Area Ends ***** -->

        <!-- ***** Men Area Starts ***** -->
        <section class="section" id="men">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6">
                        <div class="section-heading">
                            <h2>Men's Latest</h2>
                            <span>Details to details is what makes Hexashop different from the other themes.</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="men-item-carousel">
                            <div class="owl-men-item owl-carousel">
                                <c:forEach var="product" items="${productMap.men}">
                                    <div class="item">
                                        <div class="thumb">
                                            <div class="hover-content">
                                                <ul>
                                                    <li><a href="single-product?sku=${product.sku}"><i class="fa fa-eye"></i></a></li>
                                                    <li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
                                                </ul>
                                            </div>
                                            <img src="${product.file}" alt="${product.name}">
                                        </div>
                                        <div class="down-content">
                                            <h4>${product.name}</h4>
                                            <span>$${product.price}</span>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- ***** Men Area Ends ***** -->

        <!-- ***** Kids Area Starts ***** -->
        <section class="section" id="kids">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6">
                        <div class="section-heading">
                            <h2>Kid's Latest</h2>
                            <span>Details to details is what makes Hexashop different from the other themes.</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="kid-item-carousel">
                            <div class="owl-kid-item owl-carousel">
                                <c:forEach var="product" items="${productMap.kids}">
                                    <div class="item">
                                        <div class="thumb">
                                            <div class="hover-content">
                                                <ul>
                                                    <li><a href="single-product?sku=${product.sku}"><i class="fa fa-eye"></i></a></li>
                                                    <li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
                                                </ul>
                                            </div>
                                            <img src="${product.file}" alt="${product.name}">
                                        </div>
                                        <div class="down-content">
                                            <h4>${product.name}</h4>
                                            <span>$${product.price}</span>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- ***** Kids Area Ends ***** -->

        <!-- ***** Explore Area Starts ***** -->
        <section class="section" id="explore">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6">
                        <div class="left-content">
                            <h2>Subscribe To Us <br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;& <br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Get 30% Off</h2>
                            <!-- <span>You are allowed to use this HexaShop HTML CSS template. You can feel free to modify or edit this layout. You can convert this template as any kind of ecommerce CMS theme as you wish.</span> -->
                            <div class="quote">
                                <i class="fa fa-quote-left"></i><p style="font-size: 17px;">Fashion is what you buy. Style is what you do with it.</p>
                            </div>
                            <!-- <p>There are 5 pages included in this HexaShop Template and we are providing it to you for absolutely free of charge at our TemplateMo website. There are web development costs for us.</p>
                            <p>If this template is beneficial for your website or business, please kindly <a rel="nofollow" href="https://paypal.me/templatemo" target="_blank">support us</a> a little via PayPal. Please also tell your friends about our great website. Thank you.</p> -->
                            <div class="main-border-button">
                                <a href="products.html">JOIN US</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="right-content">
                            <div class="row">
                                <div class="col-lg-6">
                                    <div class="leather">
                                        <h4>Festival Clothes</h4>
                                        <span>Latest Collection</span>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="first-image">
                                        <img src="media/WomenBlackHoodie.png" alt="">
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="second-image">
                                        <img src="media/explore-image-02.jpg" alt="">
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="types">
                                        <h4>Different Types</h4>
                                        <span>Over 304 Products</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- ***** Explore Area Ends ***** -->

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

        <!-- jQuery -->
        <script src="js/jquery-2.1.0.min.js"></script>

        <!-- Bootstrap -->
        <script src="js/popper.js"></script>
        <script src="js/bootstrap.min.js"></script>

        <!-- Plugins -->
        <script src="js/owl-carousel.js"></script>
        <script src="js/accordions.js"></script>
        <script src="js/datepicker.js"></script>
        <script src="js/scrollreveal.min.js"></script>
        <script src="js/waypoints.min.js"></script>
        <script src="js/jquery.counterup.min.js"></script>
        <script src="js/imgfix.min.js"></script> 
        <script src="js/slick.js"></script> 
        <script src="js/lightbox.js"></script> 
        <script src="js/isotope.js"></script> 

        <!-- Global Init -->
        <script src="js/custom.js"></script>

        <script>

            $(function () {
                var selectedClass = "";
                $("p").click(function () {
                    selectedClass = $(this).attr("data-rel");
                    $("#portfolio").fadeTo(50, 0.1);
                    $("#portfolio div").not("." + selectedClass).fadeOut();
                    setTimeout(function () {
                        $("." + selectedClass).fadeIn();
                        $("#portfolio").fadeTo(50, 1);
                    }, 500);

                });
            });

        </script>

    </body>
</html>