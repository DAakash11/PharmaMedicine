<%-- 
    Document   : Buyer
    Created on : 23 Jan, 2024, 1:26:05 PM
    Author     : au
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="styles.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
    <header>
        <nav style="background-color: lightgray;">
            <div id="logo">
                <img src="logo/hlogo.png" alt="PharmaMedicine" height="60px" width="60px" />
                <a href="Seller.jsp" style="text-decoration: none; "> 
                    <h1 style="color:black;">PharmaMedicine</h1>
                </a> 
            </div>
            <ul class="navigation-menu">
                <li>
                    <a href="#buy"> Buy Medicines </a>
                </li> 
                <li>
                    <a href="#orderb"> Orders </a>
                </li>
                <li>
                    <a href="Logout.jsp"> Logout </a>
                </li>
                    
            </ul>
        </nav>
    </header>
<div class="active">
	<%@ page import="java.sql.*" %>
	<%@ page import="javax.sql.*" %>
	
	<%
	HttpSession httpSession = request.getSession();
    String guid=(String)httpSession.getAttribute("currentuser");
    %>
    
    <div class="filler"></div>
    <h2>Welcome <%=guid%></h2>
    
    <%
	ResultSet rs=null;
	PreparedStatement ps=null;
	java.sql.Connection conn=null;
	String query="select fname,uid,address,phno,email from customer where uid=?";
	try{
		Class.forName("com.mysql.jdbc.Driver");
		conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase","root","");
		ps=conn.prepareStatement(query);
		ps.setString(1,guid);
		rs=ps.executeQuery();
		if(rs.next())
		{
			
		%>
		<div class="filler2"></div>
			<div class="cardshow">
  				<img src="images/User.png" class="Avatar" width=234 height=234>
  				<div class="container">
    			 <div class="space1"><b><%=rs.getString("fname") %></b></div>
    			 <div class="filler3"></div>
   					<div class="space"><b>ID: </b><%=rs.getString("uid") %></div>
   					<div class="space"><b>Address: </b><%=rs.getString("address") %></div>
   					<div class="space"><b>Phone: </b><%=rs.getString("phno") %></div>
   					<div class="space"><b>Email: </b><%=rs.getString("email") %></div>
  				</div>
			</div>
		<%
		
		}
	}
	catch(Exception e)
	{
		out.println("error: "+e);
	}
	finally {
	    try { if (rs != null) rs.close(); } catch (Exception e) {};
	    try { if (ps != null) ps.close(); } catch (Exception e) {};
	    try { if (conn != null) conn.close(); } catch (Exception e) {};
	}
	%>
	
</div>
<section id="buy">
<div class="active">    
    <div class="filler"></div>
    
    <%
    int flag=0;
	rs=null;
	ps=null;
	conn=null;
	query="select p.pname,p.pid,p.manufacturer,p.mfg,p.price,i.quantity from product p,inventory i where p.pid=i.pid";
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase","root","");
		ps=conn.prepareStatement(query);
		rs=ps.executeQuery();
		%><div class="filler2"></div>
			<div class="row">
				<%
		while(rs.next())
		{
			if(flag==4)
				{
				flag=1;
				%>
                                <div class="filler2"></div>
                                <%
				}
			else
			flag++;
		%>
 				<div class="column">
    				<div class="card">
    				<img src="images/pills.png" width=180 height=200>
  					<h1><%=rs.getString("pname") %></h1>
  					<p><b>ID: </b><%=rs.getString("pid") %></p>
					<p><b>Manufacturer: </b><%=rs.getString("manufacturer") %></p>
					<p><b>Mfg Date: </b><%=rs.getDate("mfg") %></p>
					<p><b>Stock: </b><%=rs.getInt("quantity") %></p>
					<p><b>Price: </b><%=rs.getInt("price") %></p>
					<%if (rs.getInt("quantity")>0) 
					{
					%>
  					<form action="PlaceOrder.jsp" method="post">
  					<input type="number" name="orderquantity" onkeypress="return event.charCode>= 48 && event.charCode<= 57" placeholder="Enter quantity" max="<%=rs.getInt("quantity") %>" required >
  					<input type="hidden" name="pid" value="<%=rs.getString("pid") %>">
  					<p></p>
  					<button>Buy</button></form>
  					<%
  					}
  					else	
  						{
  						%>
  					
  					<button>Out Of Stock</button>
  					<% 
  						} 
%>
</div></div>
                                <%
  				}
}
	catch(Exception e)
	{
		out.println("error: "+e);
	}
	finally {
	    try { if (rs != null) rs.close(); } catch (Exception e) {};
	    try { if (ps != null) ps.close(); } catch (Exception e) {};
	    try { if (conn != null) conn.close(); } catch (Exception e) {};
}
	%>
			</div></div>
    
</section>
<section id="orderb">
    <div class="active">
    
    <div class="filler"></div>
    
    <%
        flag=0;
	rs=null;
	CallableStatement cs=null;
	conn=null;
		try{
		Class.forName("com.mysql.jdbc.Driver");
		conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase","root","");
		cs = conn.prepareCall("call getorders(?)");
		cs.setString(1, guid);
		rs = cs.executeQuery();
		%><div class="filler2"></div>
		<table class="tables">
			<tr>
    			<th>Order ID</th>
    			<th>Product ID</th>
    			<th>Price</th>
    			<th>Quantity</th>
    			<th>Seller ID</th>
    			<th>Order Date and Time</th>
  			</tr>
		<%while(rs.next()) 
		{
			%>
	  		
  			<tr>
    			<td><%=rs.getInt("oid") %></td>
    			<td><%=rs.getString("pid") %></td>
    			<td><%=rs.getInt("price") %></td>
    			<td><%=rs.getInt("quantity") %></td>
    			<td><%=rs.getString("sid") %></td>
    			<td><%=rs.getTimestamp("orderdatetime") %>
  			</tr>
  			
		<%
	}
		%>
		</table>
		<% 
	}
	catch(Exception e)
	{
		out.println("error: "+e);
	}
		finally {
		    try { if (rs != null) rs.close(); } catch (Exception e) {};
		    try { if (cs != null) cs.close(); } catch (Exception e) {};
		    try { if (conn != null) conn.close(); } catch (Exception e) {};
	}
	%>
		</div>

</section>

    <footer>
        <font style="text-align: center; color: white;">
        @Copyright by Kashyap and Aakash 2023
        </font>
    </footer>
    </body>
</html>
