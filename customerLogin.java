import java.io.IOException;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.connection.DatabaseConnection;

@WebServlet("/customerLogin")
public class customerLogin extends HttpServlet{
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException,IOException{
       
        //Getting all data from user/customer
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        //Creating session
        HttpSession hs = request.getSession();
        try{
            //crating resultset
            ResultSet resultset = null;
            //query to check login details
            resultset = DatabaseConnection.getResultFromSqlQuery("select* from tblcustomer where email = '" + email + "' and password= '" + password +"'");
            //Checking whether the details of user are null or not
            
            if(email!=null && password != null){
                if(resultset.next()){
                    //storing login details in session
                    
                    hs.setAttribute("id", resultset.getInt("id"));
                    hs.setAttribute("name", resultset.getString("name"));
                    //Redirecting response to the main.jsp
                    
                    response.sendRedirect("main.jsp");
                    return;
                }
                
                else{
                    //If wrong credentials are entered in java online shopping system
                    String msg = "You have Entered wrong credentials";
                    hs.setAttribute("credential", msg);
                }
                //Redirecting response to the customer-login.jsp
                response.sendRedirect("customer-login.jsp");
                return;
            }
            else{
                //If username or password is empty or null
                String msg = "User name or Password is null";
                hs.setAttribute("credential", msg);
                //Redirecting response to the customer-login.jsp
                response.sendRedirect("customer-login.jsp");
                return;
            }
        }
        catch(Exception e){
            e.printStackTrace();
            hs.setAttribute("credential", "An error occurred. Please try again.");
            response.sendRedirect("customer-login.jsp");
            return;
            
            
        }
        
        
    }
}