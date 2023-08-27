<%@page import="java.sql.*" %>

<%      
        String prizeid=request.getParameter("prizeid");
        String cid=request.getParameter("cid");
        DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
        String url="jdbc:oracle:thin:@artemis.vsnet.gmu.edu:1521/vse18c.vsnet.gmu.edu";
        Connection conn=DriverManager.getConnection(url,"ikim26","meejefax");
        Statement stmt=conn.createStatement();
        ResultSet rs=stmt.executeQuery("SELECT p.p_description, p.points_needed, rh.r_date, e.center_name FROM Redemption_History rh, ExchgCenters e, Prizes p WHERE rh.prize_id="+prizeid+" AND rh.cid="+cid+" AND p.prize_id=rh.prize_id AND e.center_id=rh.center_id");
        String output="";
      
        while(rs.next()){
            
            output+=rs.getObject(1)+", "+rs.getObject(2)+", "+rs.getObject(3)+", "+rs.getObject(4)+"#";
            
            }
        conn.close();
        out.print(output);
%>
