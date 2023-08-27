<%@page import="java.sql.*" %>

<%      
        String tref=request.getParameter("tref");
        String cid=request.getParameter("cid");
        DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
        String url="jdbc:oracle:thin:@artemis.vsnet.gmu.edu:1521/vse18c.vsnet.gmu.edu";
        Connection conn=DriverManager.getConnection(url,"ikim26","meejefax");
        Statement stmt=conn.createStatement();
        ResultSet rs=stmt.executeQuery("SELECT p.family_id, p.percent_added, t.t_points FROM Point_Accounts p, Transactions t WHERE p.cid="+cid+" AND t.tref='"+tref+"' AND p.cid=t.cid");
        String output="";
      
        while(rs.next()){
            
            output+=rs.getObject(1)+", "+rs.getObject(2)+", "+rs.getObject(3)+"#";
            
            }
        conn.close();
        out.print(output);
%>
