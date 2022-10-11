<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="com.apex.utils.SessionUtils" %>
<%
	request.getSession().setAttribute("refresh", true);
	SessionUtils.updateSessionAttributes(request);
	String toHighlight = request.getRequestURI().split("/")[3];
%>

<!DOCTYPE html>

<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

		<title>Welcome!</title>

		<!-- Latest compiled and minified CSS -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
		<link rel="stylesheet" href="index.css">
		
		<!-- Optional JavaScript -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
		<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js"></script>
	</head>
	<body>
		<nav class="navbar navbar-expand-xl navbar-dark bg-dark">
			<a class="navbar-brand" href="index.jsp">Apex Courier</a>
		    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#menuItems" aria-controls="menuItems" aria-expanded="false" aria-label="Toggle navigation">
		      <span class="navbar-toggler-icon"></span>
		    </button>
			<div class="collapse navbar-collapse" id="menuItems">
				<ul class="navbar-nav mx-auto">
					<li class="nav-item" id="order">
						<a class="nav-link" href="../order-page/order.jsp">Order your Courier</a>
					</li>
					<li class="nav-item" id="view">
						<a class="nav-link" href="../view-page/view.jsp">View your Courier</a>
					</li>
				</ul>
			</div>
		</nav>

        <section class="bg-light">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 order-2 order-lg-1">
                        <h1>Welcome to Apex Courier!</h1>
                        <p class="lead">Access our courier services at your fingertips</p>
                        <p class="lead">Anytime</p>
                        <p class="lead">Anywhere</p>  
                    </div>
                	<div class="col-lg-6 order-1 order-lg-2 hide-below-1000"><img src="../images/logo.png" class="logo-all" alt="landing image" class="img-fluid"></div>
            	</div>
        	</div>
        </section>

		<div class="center">
			<div class="card-body">
				<div>
					<h2 class="card-header">Our Services</h2>
				</div>
			</div>
		</div>

		<div id="carouselExampleCaptions" class="carousel slide" data-bs-ride="carousel">
			<div class="carousel-indicators">
				<button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
				<button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" aria-label="Slide 2"></button>
		  	</div>
		  	<div class="carousel-inner">
				<div class="carousel-item active">
					<img src="../images/order.png">
					<div class="carousel-caption d-none d-md-block dark-theme">
						<h5>Place your Courier Order</h5>
			  		</div>
				</div>
				<div class="carousel-item">
					<img src="../images/track.png" class="d-block w-100">
					<div class="carousel-caption d-none d-md-block dark-theme">
						<h5>View your Courier Order</h5>
					</div>
				</div>
		  	</div>
			<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Previous</span>
			</button>
			<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Next</span>
			</button>
		</div>


		<div class="bg-dark text-white footer-container">
			<span>(C) 2022 Apex Courier. All rights reserved. </span>
	    </div>

		<script type="text/javascript">
		    function preventBack() {
		    	window.history.forward();
		    }
		    setTimeout("preventBack()", 0);
		    window.onunload = function () { null };
		
			function highlight(toHighlight) {
				deselect();
				var id = toHighlight.split(".")[0];
				if (id === "index") {
					return;
				}
				var li = document.getElementById(id);
				li.style.backgroundColor = "white";
				li.childNodes[0].nextSibling.style.color = "black";
			}
	
			function deselect() {
				var liElements = document.getElementsByTagName("li");
				for (var li of liElements) {
					li.className = ""
				}
			}
			
			highlight('<%= toHighlight %>');
		</script>
	</body>
</html>
