<%@page import="java.sql.*" %>

<%      
        String cid=request.getParameter("cid");
        DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
        String url="jdbc:oracle:thin:@artemis.vsnet.gmu.edu:1521/vse18c.vsnet.gmu.edu";
        Connection conn=DriverManager.getConnection(url,"ikim26","meejefax");
        Statement stmt=conn.createStatement();
        ResultSet rs=stmt.executeQuery("Select * FROM Transactions WHERE cid="+cid);
        String output="";
      
        while(rs.next()){
            
            output+=rs.getString("tref")+", "+rs.getDate("t_date")+", "+rs.getInt("t_points")+", "+rs.getInt("amount")+"#";
            
            }
        conn.close();
        out.print(output);
%>
