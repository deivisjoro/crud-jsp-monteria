<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<% 
    
    String parametro = request.getParameter("id");
    int id  = parametro==null? 0 : Integer.parseInt(parametro);
    if(id!=0){
        String guardar = request.getParameter("guardar");
        if(guardar!=null){
            try{
                Class.forName("com.mysql.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/crud";
                Connection conexion = DriverManager.getConnection(url, "root", "");
                PreparedStatement pst = null;
                ResultSet rs = null;
                String sql = "UPDATE estudiantes SET nombre = ?, nota1=?, nota2=?, nota3=? WHERE id = ?";
                pst = conexion.prepareStatement(sql);
                pst.setString(1, request.getParameter("nombre"));
                pst.setFloat(2, Float.parseFloat(request.getParameter("nota1")));
                pst.setFloat(3, Float.parseFloat(request.getParameter("nota2")));
                pst.setFloat(4, Float.parseFloat(request.getParameter("nota3")));
                pst.setInt(5, Integer.parseInt(request.getParameter("id")));
                pst.executeUpdate();
                pst.close();
                conexion.close();
                response.sendRedirect("estudiantes.jsp");
            }
            catch(Exception e){
                response.sendRedirect("estudiantes.jsp?error=si");
            }
        }
    }
    else{
        response.sendRedirect("estudiantes.jsp?error=editando");
    }  
    

%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CRUD con JSP</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">    
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <a class="navbar-brand" href="#">Crud con JSP</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="index.jsp">Inicio</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="estudiantes.jsp">Estudiantes</a>
      </li>      
    </ul>
    <form class="form-inline my-2 my-lg-0">
      <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
    </form>
  </div>
</nav>

<main>
    <div class="container p-3">
        <div class="container p-3">            
            <div class="container p-5">
                <div class="col-md-8 offset-md-2">
                    <div class="card">
                        <div class="card-header bg-dark text-white text-center">
                            <h4>DATOS DEL ESTUDIANTE</h4>
                        </div>
                        <%
                            try{
                                Class.forName("com.mysql.jdbc.Driver");
                                String url = "jdbc:mysql://localhost:3306/crud";
                                Connection conexion = DriverManager.getConnection(url, "root", "");
                                PreparedStatement pst = null;
                                ResultSet rs = null;
                                String sql = "SELECT * FROM estudiantes WHERE id = ?";
                                pst = conexion.prepareStatement(sql);
                                pst.setInt(1, id);            
                                rs = pst.executeQuery();
                                while(rs.next()){
                                %>
                                <form action="" method="POST">                            
                                    <div class="card-body">
                                        <div class="form-group">
                                            <input type="text" name="nombre" class="form-control" placeholder="Ingrese el nombre..." value="<%=rs.getString("nombre")%>">                                 
                                        </div>
                                        <div class="form-group">
                                            <input type="text" name="nota1" class="form-control" placeholder="Ingrese la nota 1..." value="<%=rs.getString("nota1")%>">
                                        </div>
                                        <div class="form-group">
                                            <input type="text" name="nota2" class="form-control" placeholder="Ingrese la nota 2..." value="<%=rs.getString("nota2")%>">
                                        </div>
                                        <div class="form-group">
                                            <input type="text" name="nota3" class="form-control" placeholder="Ingrese la nota 3..." value="<%=rs.getString("nota3")%>">
                                        </div>
                                    </div>
                                    <div class="card-footer row">
                                        <div class="col-md-6">
                                            <input type="submit" name="guardar" value="Guardar" class="btn btn-success btn-block">
                                        </div>
                                        <div class="col-md-6">
                                            <a href="estudiantes.jsp" class="btn btn-danger btn-block">Cancelar</a>
                                        </div>
                                    </div>
                                </form>
                                <%
                                }
                                pst.close();
                                conexion.close();
                            }
                            catch(Exception e){
                                response.sendRedirect("estudiantes.jsp?error=eliminando");
                            }
                        %>                        
                    </div>
                </div>
            </div>

        </div>
    </div>
</main>


<footer class="bg-dark text-white text-center p-3">
    <p>Todos los derechos reservados</p>
</footer>
</body>
</html>

