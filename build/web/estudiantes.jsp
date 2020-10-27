<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    <div class="container p-5">
        <h2>Listado de Estudiantes</h2>
        <div class="container p-5">
            <div class="alert alert-primary">
                <a href="estudiantes_ingresar.jsp" class="btn btn-primary">Ingresar</a>
            </div>    
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th>N</th>
                        <th>Estudiantes</th>
                        <th colspan="3">Notas</th>
                        <th>Promedio</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <%@page import="java.sql.*"%>
                    <%
                      try{
                          Class.forName("com.mysql.jdbc.Driver");
                          String url = "jdbc:mysql://localhost:3306/crud";
                          Connection conexion = DriverManager.getConnection(url, "root", "");
                          PreparedStatement pst = null;
                          ResultSet rs = null;
                          String sql = "SELECT * FROM estudiantes";
                          pst = conexion.prepareStatement(sql);
                          rs = pst.executeQuery();
                          int i=0;
                          while(rs.next()){
                              i++;
                              %>
                              <tr>
                                  <td><%=i%></td>
                                  <td>
                                      <%=rs.getString("nombre")%>
                                  </td>
                                  <td><%=rs.getFloat("nota1")%></td>
                                  <td><%=rs.getFloat("nota2")%></td>
                                  <td><%=rs.getFloat("nota3")%></td>
                                  <td>
                                      <%
                                        String clase = "";
                                        float promedio = (rs.getFloat("nota1")+rs.getFloat("nota2")+rs.getFloat("nota3"))/3;
                                        if(promedio<3){
                                            clase = "text-danger";
                                        }
                                      %>
                                      <span class="<%=clase%>">
                                          <%=promedio%>
                                      </span>
                                  </td>
                                  <td>
                                      <a href="estudiantes_editar.jsp?id=<%=rs.getInt("id")%>" class="btn btn-warning ml">Editar</a>
                                      <a href="estudiantes_eliminar.jsp?id=<%=rs.getInt("id")%>" class="btn btn-danger ml">Eliminar</a>
                                  </td>
                              </tr>
                              <%
                          }
                          
                          if(i==0){
                          %>
                          <tr>
                            <td colspan="7">
                                <div class="alert alert-warning">
                                        No se encontraron registros
                                </div>
                            </td>
                          </tr>
                          <%
                          }
                      }  
                      catch(Exception e){
                      %>
                      <tr>
                          <td colspan="7">
                              <div class="alert alert-danger">
                                  ERROR: <%=e.getMessage()%>
                              </div>
                          </td>
                      </tr>
                      <%
                      }
                    %>
                </tbody>    
            </table>              
        </div>
    </div>
</main>


<footer class="bg-dark text-white text-center p-3">
    <p>Todos los derechos reservados</p>
</footer>
</body>
</html>
