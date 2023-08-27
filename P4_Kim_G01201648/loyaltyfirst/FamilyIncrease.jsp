<%@page import="java.sql.*" %>

<%      
        String fid=request.getParameter("fid");
        String cid=request.getParameter("cid");
        String npoints=request.getParameter("npoints");
        DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
        String url="jdbc:oracle:thin:@artemis.vsnet.gmu.edu:1521/vse18c.vsnet.gmu.edu";
        Connection conn=DriverManager.getConnection(url,"ikim26","meejefax");
        Statement stmt=conn.createStatement();
        stmt.executeUpdate("UPDATE Point_Accounts SET num_of_points=num_of_points+"+npoints+" WHERE family_id="+fid+" AND NOT cid ="+cid);
        conn.close();
        out.print("Successfully updated!");
%>
