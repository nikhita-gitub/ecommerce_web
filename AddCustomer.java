import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.connection.DatabaseConnection;
//import java.rmi.activation.Activatable;
import java.sql.Connection;
import org.apache.tomcat.jni.SSLContext;

@WebServlet("/AddCustomer")
public class AddCustomer extends HttpServlet{

   
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        
        //retrieving values from frontend
        
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
         String password1 = request.getParameter("password1");
         
         //creating a session
         HttpSession hs = request.getSession();
         
         // inserting values inside db
         try{
             int addCustomer = DatabaseConnection.insertUpdateFromSqlQuery("insert into tblcustomer(email,name,password,password1)values('"+ email+ "','"+ name+ "','"+ password+ "','"+ password1 + "')");
         
             if(addCustomer>0){
                 String msg = "Customer registered successfully";
                 //Passing message via session.
                 hs.setAttribute("success-message", msg);
                 response.sendRedirect("customer-register.jsp");
                 
             }
             else{
                 String msg = "Customer registration failed!";
                 hs.setAttribute("fail-message",msg);
                 response.sendRedirect("customer-register.jsp");
             }
         
         
         } catch(Exception e){
             e.printStackTrace();
         }
    }
    
}