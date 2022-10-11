<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="com.apex.utils.SessionUtils, java.sql.ResultSet"%>
<%
	SessionUtils.updateSessionAttributes(request);
	String toHighlight = request.getRequestURI().split("/")[3];
	String status;
%>

<!DOCTYPE html>

<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

		<title>Order your courier now!</title>

		<!-- Latest compiled and minified CSS -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
		<link rel="stylesheet" href="view.css">

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
								<a class="nav-link" href="../order-page/order.jsp">Order your Courier</a>
							</li>
							<li class="nav-item" id="view">
								<a class="nav-link" href="../view-page/view.jsp">View your Courier</a>
							</li>
						</ul>
					</div>
				</nav>
			</div>
	
			<div class="content-container">
				<div class="card center">
					<div class="card-body" style="padding: 0;">
						<div class="title-container">
							<h2 class="card-header">View your Courier Here!</h2>
						</div>
						<div style="padding: 16px;">
							<form action="view" method="post">
								<div class="form-group">
									<label for="exampleInputTrack">Tracking ID</label>
									<% 
										status = (String) request.getSession().getAttribute("trackException");
										if (status == null) {
									%>
									<input type="text" name="track" value="<%= (request.getParameter("track") == null) ? "" : request.getParameter("track") %>" class="form-control" id="exampleInputTrack" aria-describedby="trackHelp" placeholder="Enter your tracking ID" required>
									<%
										} else {
									%>
									<input type="text" name="track" value="<%= (request.getParameter("track") == null) ? "" : request.getParameter("track") %>" class="form-control is-invalid" id="exampleInputTrack" aria-describedby="trackHelp" placeholder="Enter your tracking ID" required>
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
								<div class="btn-container">
									<button type="submit" class="btn btn-success">View your Courier</button>
								</div>
								<%	
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
								%>
							</form>
						</div>
					</div>
				</div>
				<%
					ResultSet resultSet = (ResultSet) request.getSession().getAttribute("order");
				
					if (resultSet != null) {
				%>
					<br>
					<br>
					<table class="table table-striped table-hover table-bordered" style="text-align: center; width: 80%">
						<thead>
							<tr class="table-dark">
								<th scope="col">Name</th>
								<th scope="col">Phone Number</th>
								<th scope="col">Source City</th>
								<th scope="col">Destination City</th>
								<th scope="col">Distance</th>
								<th scope="col">Package's Weight</th>
								<th scope="col">Cost</th>
								<th scope="col">Tracking ID</th>
								<th scope="col">Expected Date of Shipment<br>(YYYY-MM-DD)</th>
								<th scope="col">Expected Date of Delivery<br>(YYYY-MM-DD)</th>
							</tr>
						</thead>
						<tbody>
						<%
							do {
						%>
							    <tr>
							      <td><%= resultSet.getString(1) %></td>
							      <td><%= resultSet.getLong(2) %></td>
							      <td><%= resultSet.getString(3) %></td>
							      <td><%= resultSet.getString(4) %></td>
							      <td><%= resultSet.getInt(5) %> km</td>
							      <td><%= resultSet.getDouble(6) %> gm</td>
							      <td>Rs. <%= resultSet.getDouble(7) %></td>
							      <td><%= resultSet.getString(8) %></td>
							      <td><%= resultSet.getString(9) %></td>
							      <td><%= resultSet.getString(10) %></td>
							    </tr>
						<%
							} while (resultSet.next());
						}
						%>
					</tbody>
				</table>
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
