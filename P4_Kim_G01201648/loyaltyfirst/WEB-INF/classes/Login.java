/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Project/Maven2/JavaApp/src/main/java/${packagePath}/${mainClassName}.java to edit this template
 */

/**
 *
 * @author Isaac
 */
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;

@WebServlet("/login")
public class Login extends HttpServlet{

  public void doGet(HttpServletRequest request,HttpServletResponse response){
      try{
        
        
        String user=request.getParameter("user");
        String pass=request.getParameter("pass");
          
        DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
        String url="jdbc:oracle:thin:@artemis.vsnet.gmu.edu:1521/vse18c.vsnet.gmu.edu";
        Connection conn=DriverManager.getConnection(url,"ikim26","meejefax");
        Statement stmt=conn.createStatement();
        ResultSet rs=stmt.executeQuery("Select * from Login where username='"+user+"' AND passwd='"+pass+"'");
        
        PrintWriter out=response.getWriter();
        if(rs.next()){
          if(user.equals(rs.getString("username"))&& pass.equals(rs.getString("passwd"))){
            out.print("Yes:"+rs.getString("cid"));
        }
          else{
              out.print("No");
          }
        }
        
        else
        {
            out.print("No");
        }
        
        conn.close();
       
      }
      catch(Exception e){}
  }
}