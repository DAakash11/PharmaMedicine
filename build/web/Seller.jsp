<%-- 
    Document   : Admin
    Created on : 18 Jan, 2024, 1:24:50 PM
    Author     : au
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>PharmaMedicine</title>
<link rel="stylesheet" href="style.css" type="text/css">
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
                    <a href="#add"> Add Medicines </a>
                </li> 
                <li>
                    <a href="#restock"> Restock </a>
                </li>
                <li>
                    <a href="#orders"> Orders </a>
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
<h2>welcome <%=guid%></h2>
<%
    ResultSet rs=null;
    PreparedStatement ps=null;
    java.sql.Connection conn=null;
    String query="select sname,sid,address,phno from seller where sid=?";
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
            <div class="card">
                <img src="images/vendor.png" class="Avatar" width=264 height=194>
                <div class="container">
                    <h4><b><%=rs.getString("sname") %></b></h4>
                    <p><b>ID: </b><%=rs.getString("sid") %> </p>
                    <p><b>Address: </b><%=rs.getString("address") %></p>
                    <p><b>Phone: </b><%=rs.getString("phno") %></p>
                </div>
            </div>
<%
                }
} catch(Exception e) {
out.println("error: "+e);
}
finally {
try { if (rs != null) rs.close(); } catch (Exception e) {};
try { if (ps != null) ps.close(); } catch (Exception e) {};
try { if (conn != null) conn.close(); } catch (Exception e) {};
}
%>
</div>
<section id="add">
    <div class="active">
        <div class="filler"></div>
        <h2>Add Medicine</h2>
        <center>
            <form action="AddProduct.jsp" method="post">
                <div class="bigcard">
                    <table border=0>
                        <tr>
                            <td>
                                <h3>Enter Product Name</h3>
                            </td>
                            <td>
                                <input type='text' name='prname' required>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <h3>Enter Product ID</h3>
                            </td>
                            <td>
                                <input type='text' name='prid' required>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <h3>Enter Manufacturer Name</h3>
                            </td>
                            <td>
                                <input type='text' name='mfname' required>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <h3>Enter Manufacture Date</h3>
                            </td>
                            <td>
                                <input type="text" name="mdate" placeholder="YYYY-MM-DD" onkeypress="return event.charCode>= 48 && event.charCode<= 57 || event.charCode==45" required>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <h3>Enter Expiry Date</h3>
                            </td>
                            <td>
                                <input type="text" name="edate" placeholder="YYYY-MM-DD" onkeypress="return ((event.charCode>= 48 && event.charCode<= 57) || event.charCode==45)" required>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <h3>Quantity</h3>
                            </td>
                            <td>
                                <input type="text" name="quantity" onkeypress="return event.charCode>= 48 && event.charCode<= 57" required>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <h3>Price</h3>
                            </td>
                            <td>
                                <input type="text" name="price" onkeypress="return event.charCode>= 48 && event.charCode<= 57" required>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <center><input type="submit" value="Add"></center>
                            </td>
                        </tr>
                    </table>
                </div>
            </form>                    
        </center>
    </div>
</section>

<section id="restock">
    <div class="active" style="background-color: #F4CFC6;">
<%
    int flag=0;
    rs=null;
    ps=null;
    conn=null;
    query="select p.pid,i.quantity,p.pname,p.manufacturer,p.mfg,p.exp,p.price from product p,inventory i where p.pid=i.pid and i.sid=?";
    try{
        Class.forName("com.mysql.jdbc.Driver");
        conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase","root","");
        ps=conn.prepareStatement(query);
        ps.setString(1,guid);
        rs=ps.executeQuery();
        while(rs.next())
        {
            if(flag==4)
            {
                flag=1;
                %>
    </div>
    <div class="filler2"><p>hello</p></div>
    <% 				}
else
flag++;
%>
<div class="card" style="padding-top: 10px; display: inline; margin: 20px;">
    <form action="UpdateInventory.jsp" method="post" style="padding-top: 10px; ">
        <img src="images/pills.png" width=180 height=200>
        <h1><%=rs.getString("pname") %></h1>
        <p><b>ID: </b><%=rs.getString("pid") %></p>
        <p><b>Manufacturer: </b><%=rs.getString("manufacturer") %></p>
        <p><b>Mfg Date: </b><%=rs.getDate("mfg") %></p>
        <p><b>Exp Date: </b><%=rs.getDate("exp") %></p>
        <p><b>Stock: </b><%=rs.getInt("quantity") %></p>
        <p><b>Price: </b><%=rs.getInt("price") %></p>
        <p><input type="text" name="restock" placeholder="quantity" onkeypress="return event.charCode>= 48 && event.charCode<= 57" required></p>
        <input type="hidden" name="pid" value="<%=rs.getString("pid") %>" >
        <p></p>
        <button>ReStock</button>
    </form>
</div>      
        <% 			} 
		} catch(Exception e) {
out.println("error: "+e);
}
finally {
try { if (rs != null) rs.close(); } catch (Exception e) {};
try { if (ps != null) ps.close(); } catch (Exception e) {};
try { if (conn != null) conn.close(); } catch (Exception e) {};
}
%>   
</section>

    <section id="orders">
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
		cs = conn.prepareCall("call getsellerorders(?)");
		cs.setString(1, guid);
		rs = cs.executeQuery();
		%><div class="filler2"></div>
		<table class="tables">
			<tr>
    			<th>Order ID</th>
    			<th>Product ID</th>
    			<th>Price</th>
    			<th>Quantity</th>
    			<th>CUSTOMER ID</th>
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
    			<td><%=rs.getString("uid") %></td>
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
