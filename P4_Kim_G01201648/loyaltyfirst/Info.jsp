<%@page import="java.sql.*" %>

<%      
        String customer_id=request.getParameter("cid");
        DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
        String url="jdbc:oracle:thin:@artemis.vsnet.gmu.edu:1521/vse18c.vsnet.gmu.edu";
        Connection conn=DriverManager.getConnection(url,"ikim26","meejefax");
        Statement stmt=conn.createStatement();
        ResultSet rs=stmt.executeQuery("select c.cname, p.num_of_points from Customers c, Point_Accounts p WHERE c.cid="+customer_id + " AND p.cid=c.cid");
        String output="";
      
        while(rs.next()){
            
            output+=rs.getObject(1)+","+rs.getObject(2)+"#";
            
            }
        conn.close();
        out.print(output);
%>
