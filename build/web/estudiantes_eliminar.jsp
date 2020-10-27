<%@page import="java.sql.*"%>
<%
    String parametro = request.getParameter("id");
    int id  = parametro==null? 0 : Integer.parseInt(parametro);
    if(id!=0){
        try{
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/crud";
            Connection conexion = DriverManager.getConnection(url, "root", "");
            PreparedStatement pst = null;
            String sql = "DELETE FROM estudiantes WHERE id = ?";
            pst = conexion.prepareStatement(sql);
            pst.setInt(1, id);            
            pst.executeUpdate();
            pst.close();
            conexion.close();
            response.sendRedirect("estudiantes.jsp");
        }
        catch(Exception e){
            response.sendRedirect("estudiantes.jsp?error=eliminando");
        }
    }
    else{
        response.sendRedirect("estudiantes.jsp?error=eliminando");
    }
%>