package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.sql.*;

public final class Buyer_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>JSP Page</title>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("    <header>\n");
      out.write("        <nav style=\"background-color: lightgray;\">\n");
      out.write("            <div id=\"logo\">\n");
      out.write("                <img src=\"logo/hlogo.png\" alt=\"PharmaMedicine\" height=\"60px\" width=\"60px\" />\n");
      out.write("                <a href=\"Seller.jsp\" style=\"text-decoration: none; \"> \n");
      out.write("                    <h1 style=\"color:black;\">PharmaMedicine</h1>\n");
      out.write("                </a> \n");
      out.write("            </div>\n");
      out.write("            <ul class=\"navigation-menu\">\n");
      out.write("                <li>\n");
      out.write("                    <a href=\"#buy\"> Buy Medicines </a>\n");
      out.write("                </li> \n");
      out.write("                <li>\n");
      out.write("                    <a href=\"#orders\"> Orders </a>\n");
      out.write("                </li>\n");
      out.write("                <li>\n");
      out.write("                    <a href=\"Logout.jsp\"> Logout </a>\n");
      out.write("                </li>\n");
      out.write("                    \n");
      out.write("            </ul>\n");
      out.write("        </nav>\n");
      out.write("    </header>\n");
      out.write("<div class=\"active\">\n");
      out.write("\t\n");
      out.write("\t\n");
      out.write("\t\n");
      out.write("\t");

	HttpSession httpSession = request.getSession();
    String guid=(String)httpSession.getAttribute("currentuser");
    
      out.write("\n");
      out.write("    \n");
      out.write("    <div class=\"filler\"></div>\n");
      out.write("    <h2>Welcome ");
      out.print(guid);
      out.write("</h2>\n");
      out.write("    \n");
      out.write("    ");

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
			
		
      out.write("\n");
      out.write("\t\t<div class=\"filler2\"></div>\n");
      out.write("\t\t\t<div class=\"card\">\n");
      out.write("  \t\t\t\t<img src=\"images/User.png\" class=\"Avatar\" width=234 height=234>\n");
      out.write("  \t\t\t\t<div class=\"container\">\n");
      out.write("    \t\t\t <div class=\"space1\"><b>");
      out.print(rs.getString("fname") );
      out.write("</b></div>\n");
      out.write("    \t\t\t <div class=\"filler3\"></div>\n");
      out.write("   \t\t\t\t\t<div class=\"space\"><b>ID: </b>");
      out.print(rs.getString("uid") );
      out.write("</div>\n");
      out.write("   \t\t\t\t\t<div class=\"space\"><b>Address: </b>");
      out.print(rs.getString("address") );
      out.write("</div>\n");
      out.write("   \t\t\t\t\t<div class=\"space\"><b>Phone: </b>");
      out.print(rs.getString("phno") );
      out.write("</div>\n");
      out.write("   \t\t\t\t\t<div class=\"space\"><b>Email: </b>");
      out.print(rs.getString("email") );
      out.write("</div>\n");
      out.write("  \t\t\t\t</div>\n");
      out.write("\t\t\t</div>\n");
      out.write("\t\t");

		
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
	
      out.write("\n");
      out.write("\t\n");
      out.write("</div>\n");
      out.write("<section id=\"buy\">\n");
      out.write("<div class=\"active\">    \n");
      out.write("    <div class=\"filler\"></div>\n");
      out.write("    \n");
      out.write("    ");

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
		
      out.write("<div class=\"filler2\"></div>\n");
      out.write("\t\t\t\t<div class=\"block\">\n");
      out.write("\t\t\t\t");

		while(rs.next())
		{
			if(flag==4)
				{
				flag=1;
				
      out.write("</div><div class=\"filler2\"></div>");

				}
			else
			flag++;
		
      out.write("\n");
      out.write("\t\t\t<div class=\"row\">\n");
      out.write(" \t\t\t\t<div class=\"column\">\n");
      out.write("    \t\t\t\t<div class=\"card\">\n");
      out.write("    \t\t\t\t<img src=\"images/pills.png\" width=180 height=200>\n");
      out.write("  \t\t\t\t\t<h1>");
      out.print(rs.getString("pname") );
      out.write("</h1>\n");
      out.write("  \t\t\t\t\t<p><b>ID: </b>");
      out.print(rs.getString("pid") );
      out.write("</p>\n");
      out.write("\t\t\t\t\t<p><b>Manufacturer: </b>");
      out.print(rs.getString("manufacturer") );
      out.write("</p>\n");
      out.write("\t\t\t\t\t<p><b>Mfg Date: </b>");
      out.print(rs.getDate("mfg") );
      out.write("</p>\n");
      out.write("\t\t\t\t\t<p><b>Stock: </b>");
      out.print(rs.getInt("quantity") );
      out.write("</p>\n");
      out.write("\t\t\t\t\t<p><b>Price: </b>");
      out.print(rs.getInt("price") );
      out.write("</p>\n");
      out.write("\t\t\t\t\t");
if (rs.getInt("quantity")>0) 
					{
					
      out.write("\n");
      out.write("  \t\t\t\t\t<form action=\"PlaceOrder.jsp\" method=\"post\">\n");
      out.write("  \t\t\t\t\t<input type=\"number\" name=\"orderquantity\" onkeypress=\"return event.charCode>= 48 && event.charCode<= 57\" placeholder=\"Enter quantity\" max=\"");
      out.print(rs.getInt("quantity") );
      out.write("\" required >\n");
      out.write("  \t\t\t\t\t<input type=\"hidden\" name=\"pid\" value=\"");
      out.print(rs.getString("pid") );
      out.write("\">\n");
      out.write("  \t\t\t\t\t<p></p>\n");
      out.write("  \t\t\t\t\t<button>Buy</button></form></div>\n");
      out.write("  \t\t\t\t\t");

  					}
  					else	
  						{
  						
      out.write("\n");
      out.write("  \t\t\t\t\t\n");
      out.write("  \t\t\t\t\t<button>Out Of Stock</button></div>\n");
      out.write("  \t\t\t\t\t");
 
  						} 
  					
      out.write("\n");
      out.write("  \t\t\t\t</div>\n");
      out.write("  \t\t\t\t");

  				}
				
      out.write("\n");
      out.write("\t\t");

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
	
      out.write("\n");
      out.write("\t\t\t</div>\n");
      out.write("    \n");
      out.write("</section>\n");
      out.write("\n");
      out.write("    <footer>\n");
      out.write("        <font style=\"text-align: center; color: white;\">\n");
      out.write("        @Copyright by Kashyap and Aakash 2023\n");
      out.write("        </font>\n");
      out.write("    </footer>\n");
      out.write("    </body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
