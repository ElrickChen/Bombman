package game.record;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import game.record.recorddata;
/**
 * Servlet implementation class recordboard
 */
@WebServlet("/recordboard")
public class recordboard extends HttpServlet {
	private static final long serialVersionUID = 1L;
     private ArrayList<recorddata> myList=new ArrayList<recorddata>();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public recordboard() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String ti=request.getParameter("t");
		String num=request.getParameter("n");
		String na=request.getParameter("na");
			myList.add(new recorddata(Integer.parseInt(num),na,ti));
		for(int i=0;i<myList.size();i++)
		{
			for(int j=myList.size();j>i;j--)
			{
				if(myList.get(j).compareTo(myList.get(j-1))==-1)
				{
					recorddata temp=myList.get(j);
					myList.set(j,myList.get(j-1));
					myList.set(j-1,temp);
				}
			}
		}
		request.getServletContext().setAttribute("re", myList);
		
		RequestDispatcher view = request.getRequestDispatcher("board.jsp");
		view.forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}