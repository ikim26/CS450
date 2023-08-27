<%@page import="java.sql.*" %>

<%      
        String fid=request.getParameter("fid");
        DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
        String url="jdbc:oracle:thin:@artemis.vsnet.gmu.edu:1521/vse18c.vsnet.gmu.edu";
        Connection conn=DriverManager.getConnection(url,"ikim26","meejefax");
        Statement stmt=conn.createStatement();
        ResultSet rs=stmt.executeQuery("SELECT cid, num_of_points FROM Point_Accounts WHERE family_id="+fid);
        String output="";
        out.println("current number of points for family");
        while(rs.next()){
            
            output+=rs.getObject(1)+", "+rs.getObject(2)+"#";
            
            }
        conn.close();
        out.print(output);
%>
