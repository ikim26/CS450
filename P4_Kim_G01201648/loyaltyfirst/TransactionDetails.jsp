<%@page import="java.sql.*" %>

<%      
        String tref=request.getParameter("tref");
        DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
        String url="jdbc:oracle:thin:@artemis.vsnet.gmu.edu:1521/vse18c.vsnet.gmu.edu";
        Connection conn=DriverManager.getConnection(url,"ikim26","meejefax");
        Statement stmt=conn.createStatement();
        ResultSet rs=stmt.executeQuery("SELECT t.t_date, t.t_points, p.prod_name, p.prod_points, tp.quantity FROM Transactions t, Products p, Transactions_Products tp WHERE t.tref='"+tref+"' AND tp.tref=t.tref AND p.prod_id=tp.prod_id");
        String output="";
      
        while(rs.next()){
            
            output+=rs.getObject(1)+", "+rs.getObject(2)+", "+rs.getObject(3)+", "+rs.getObject(4)+", "+rs.getObject(5)+"#";
            
            }
        conn.close();
        out.print(output);
%>
