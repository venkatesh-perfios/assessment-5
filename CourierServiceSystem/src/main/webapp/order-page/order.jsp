<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="com.apex.utils.SessionUtils"%>
<%
	SessionUtils.updateSessionAttributes(request);
	String toHighlight = request.getRequestURI().split("/")[3];
	String status;
	Double amount = (Double) request.getSession().getAttribute("amount");
%>

<!DOCTYPE html>

<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

		<title>Order your courier now!</title>

		<!-- Latest compiled and minified CSS -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
		<link rel="stylesheet" href="order.css">

		<!-- Optional JavaScript -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
		<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js"></script>
	</head>
	<body>
		<div class="page-container">
			<div class="header-container">
				<nav class="navbar navbar-expand-xl navbar-dark bg-dark">
					<a class="navbar-brand" href="../landing-page/index.jsp">Apex Courier</a>
				    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#menuItems" aria-controls="menuItems" aria-expanded="false" aria-label="Toggle navigation">
				      <span class="navbar-toggler-icon"></span>
				    </button>
					<div class="collapse navbar-collapse" id="menuItems">
						<ul class="navbar-nav mx-auto">
							<li class="nav-item" id="order">
								<a class="nav-link" href="order.jsp">Order your Courier</a>
							</li>
							<li class="nav-item" id="view">
								<a class="nav-link" href="../view-page/view.jsp">View your Courier</a>
							</li>
						</ul>
					</div>
				</nav>
			</div>
	
			<div class="content-container">
				<div class="card center shadow-sm bg-body rounded" style="margin-right: 0;">
					<div class="card-body">
						<img src="../images/order.png" class="image">
					</div>
				</div>
				<div class="card center" style="margin-left: 0;">
					<div class="card-body" style="padding: 0;">
						<div class="title-container">
							<h2 class="card-header">Order your Courier Here!</h2>
						</div>
						<div style="padding: 16px;">
							<form action="order" method="post">
								<div class="form-group">
									<label for="exampleInputName">Name</label>
									<% 
										status = (String) request.getSession().getAttribute("nameException");
										if (status == null) {
									%>
									<input type="text" name="name" value="<%= (request.getParameter("name") == null) ? "" : request.getParameter("name") %>" class="form-control" id="exampleInputName" aria-describedby="nameHelp" placeholder="Enter your name" required>
									<%
										} else {
									%>
									<input type="text" name="name" value="<%= (request.getParameter("name") == null) ? "" : request.getParameter("name") %>" class="form-control is-invalid" id="exampleInputName" aria-describedby="nameHelp" placeholder="Enter your name" required>
								    <div class="invalid-feedback">
								    	<%
											out.println(status);
								    	%>
								    </div>
									<%
										}
									%>				
								</div>
								<br>
								<div class="form-group">
									<label for="exampleInputPhone">Phone Number</label>
									<% 
										status = (String) request.getSession().getAttribute("phoneException");
										if (status == null) {
									%>
									<input type="number" name="phone" value="<%= (request.getParameter("phone") == null) ? "" : request.getParameter("phone") %>" class="form-control" id="exampleInputPhone" placeholder="Enter your phone number" required>
									<%
										} else {
									%>
									<input type="number" name="phone" value="<%= (request.getParameter("phone") == null) ? "" : request.getParameter("phone") %>" class="form-control is-invalid" id="exampleInputPhone" placeholder="Enter your phone number" required>
								    <div class="invalid-feedback">
								    	<%
											out.println(status);
								    	%>
								    </div>
									<%
										}
									%>
								</div>
								<br>
								<div class="form-group">
									<label for="exampleInputSource">Source City</label>
									<% 
										status = (String) request.getSession().getAttribute("sourceException");
										if (status == null) {
									%>
									<select name="source" class="form-select" id="exampleInputSource" required>
									  <% 
										  String source = request.getParameter("source");
										  if (source == null || amount == null) {
									  %>
									  <option value="">Select your source city</option>
									  <option value="Bengaluru">Bengaluru</option>
									  <option value="Mumbai">Mumbai</option>
									  <option value="Delhi">Delhi</option>
									  <option value="Kolkata">Kolkata</option>
									  <%
										} else {
									  %>
									  <option value="<%= source %>"><%= source %></option>
									  <%
										}
									  %>
									</select>
									<%
										} else {
									%>
									<select name="source" class="form-select is-invalid" id="exampleInputSource" required>
									  <% 
										  String source = request.getParameter("source");
										  if (source == null || amount == null) {
									  %>
									  <option value="">Select your source city</option>
									  <option value="Bengaluru">Bengaluru</option>
									  <option value="Mumbai">Mumbai</option>
									  <option value="Delhi">Delhi</option>
									  <option value="Kolkata">Kolkata</option>
									  <%
										} else {
									  %>
									  <option value="<%= source %>"><%= source %></option>
									  <%
										}
									  %>
									</select>
								    <div class="invalid-feedback">
								    	<%
											out.println(status);
								    	%>
								    </div>
									<%
										}
									%>				
								</div>
								<br>
								<div class="form-group">
									<label for="exampleInputDestination">Destination City</label>
									<% 
										status = (String) request.getSession().getAttribute("destinationException");
										if (status == null) {
									%>
									<select name="destination" class="form-select" id="exampleInputDestination" required>
									  <% 
										  String destination = request.getParameter("destination");
										  if (destination == null || amount == null) {
									  %>						
									  <option value="">Select your destination city</option>
									  <option value="Bengaluru">Bengaluru</option>
									  <option value="Mumbai">Mumbai</option>
									  <option value="Delhi">Delhi</option>
									  <option value="Kolkata">Kolkata</option>
									  <%
										} else {
									  %>
									  <option value="<%= destination %>"><%= destination %></option>
									  <%
										}
									  %>
									</select>
									<%
										} else {
									%>
									<select name="destination" class="form-select is-invalid" id="exampleInputDestination" required>
									  <% 
										  String destination = request.getParameter("destination");
										  if (destination == null || amount == null) {
									  %>
									  <option value="">Select your destination city</option>
									  <option value="Bengaluru">Bengaluru</option>
									  <option value="Mumbai">Mumbai</option>
									  <option value="Delhi">Delhi</option>
									  <option value="Kolkata">Kolkata</option>
									  <%
										} else {
									  %>
									  <option value="<%= destination %>"><%= destination %></option>
									  <%
										}
									  %>
									</select>
								    <div class="invalid-feedback">
								    	<%
											out.println(status);
								    	%>
								    </div>
									<%
										}
									%>				
								</div>
								<br>
								<div class="form-group">
									<label for="exampleInputWeight">Package Weight</label>
									<% 
										status = (String) request.getSession().getAttribute("weightException");
										if (status == null) {
									%>
									<input type="number" name="weight" step=".01" value="<%= (request.getParameter("weight") == null) ? "" : request.getParameter("weight") %>" class="form-control" id="exampleInputWeight" placeholder="Enter your package's weight (in grams)" required>
									<%
										} else {
									%>
									<input type="number" name="weight" step=".01" value="<%= (request.getParameter("weight") == null) ? "" : request.getParameter("weight") %>" class="form-control is-invalid" id="exampleInputWeight" placeholder="Enter your package's weight (in grams)" required>
								    <div class="invalid-feedback">
								    	<%
											out.println(status);
								    	%>
								    </div>
									<%
										}
									%>
								</div>
								<br>
								<%
									if (amount == null) {
								%>
								<div class="btn-container">
									<button type="submit" class="btn btn-success">Place your Order</button>
								</div>
								<%
									} else {
										amount = Math.round(amount * 100) / 100.0;
								%>
								<label for="exampleAmount">Amount to Pay</label>
								<input class="form-control" id="exampleAmount" type="text" name="amount" value="<%= amount %>" disabled>
								<br>
								<div class="btn-container">
									<button type="submit" class="btn btn-success">Confirm your Order</button>
								</div>
								<%
									}
									
									status = (String) request.getSession().getAttribute("otherException");
									if (status != null) {
								%>
								<br>
							    <div class="invalid-status-container">
							    	<%
										out.println(status);
							    	%>
							    </div>
								<%
									}
									
									status = (String) request.getSession().getAttribute("success");
									if (status != null) {
								%>
								<br>
							    <div class="valid-status-container">
							    	<%
										out.println(status);
							    	%>
							    </div>
							    <%
									}
							    %>
							</form>
						</div>
					</div>
				</div>
			</div>
			
			<div class="bg-dark text-white footer-container">
				<span>(C) 2022 Apex Courier. All rights reserved.</span>
		    </div>
		</div>

		<script type="text/javascript">
// 		    function preventBack() { 
// 		    	window.history.forward(); 
// 		    }
// 		    setTimeout("preventBack()", 0);
// 		    window.onunload = function () { null };
    
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
