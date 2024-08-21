<%@page import="com.tech.blog.entities.User" %>
<%@page import="com.tech.blog.entities.Message" %>
<%@page errorPage="error_page.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, com.tech.blog.helper.ConnectionProvider, com.tech.blog.dao.PostDao, java.util.ArrayList, com.tech.blog.entities.Category" %>
<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login_page.jsp");
        return; // Ensure the rest of the page doesn't execute after redirect
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile Page</title>
        <!--css-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <script src="https://kit.fontawesome.com/b45ad3d737.js" crossorigin="anonymous"></script>
        <script src="js/myjs.js"></script>
        <style>
            body{
                background: url(img/nice.jpeg);
                background-size: cover;
                background-attachment: fixed;
            }
            .banner-background{
                clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 94%, 68% 91%, 31% 96%, 0 89%, 0 0);
            }
        </style>        
    </head>
    <body>
        <!--navbar-->
        <nav class="navbar navbar-expand-lg navbar-dark primary-background">
          <div class="container-fluid">
              <a class="navbar-brand" href="index.jsp"><span class="fa fa-asterisk"></span> TechBlog</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
              <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
              <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="#"><span class="fa fa-bell-o"></span>LearnCode with PPS</a>
                </li>
                <li class="nav-item dropdown">
                  <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                      <span class="fa fa-check-square-o"></span> Categories
                  </a>
                  <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <li><a class="dropdown-item" href="#">Programming Language</a></li>
                    <li><a class="dropdown-item" href="#">Project Implementation</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item" href="#">Data Structure</a></li>
                  </ul>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"><span class="fa fa-address-card-o"></span>Contact</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#" data-bs-toggle="modal" data-bs-target="#add-post-modal"><span class="fa fa-asterisk"></span>Do Post</a>
                </li>
              </ul>
                <ul class="navbar-nav mr-right">
                    <li class="nav-item">
                        <a class="nav-link" href="#!" data-bs-toggle="modal" data-bs-target="#profile-modal"><span class="fa fa-user-circle "></span><%= user.getName() %></a>
                    </li>
                    <li class="nav-item">
                      <a class="nav-link" href="LogoutServlet"><span class="fa fa-user-plus "></span>Log Out</a>
                    </li>
              </ul>
            </div>
          </div>
        </nav>
                    
        <%

           Message msg = (Message)session.getAttribute("msg");
           if(msg != null)
           {
        %>
        <div class="alert <%= msg.getCssClass()%> " role="alert">
            <%= msg.getContent() %>
        </div>
        <%
            session.removeAttribute("msg");
            }
        %>

        <!--main body of the page-->
        
        <main>
            <div class="container">
                <div class="row mt-4">
                    <!--first col-->
                    <div class="col-md-4">
                        <!--categories-->
                        
                        <div class="list-group">
                            <a href="#" onclick="getPosts(0,this)" class="c-link list-group-item list-group-item-action active" aria-current="true">
                            All Posts
                          </a>
                          <% 
                            PostDao d = new PostDao(ConnectionProvider.getConnection());
                            ArrayList<Category> list1=d.getAllCatagories();
                                
                                for(Category c:list1){
                            %>
                            <a href="#" onclick="getPosts(<%= c.getId() %>,this)" class="c-link list-group-item list-group-item-action"><%= c.getName() %></a>
                            <% 
                                }
                            %>
                        </div>
                        
                    </div>
                    
                    <!--second col-->
                    <div class="col-md-8">
                        <!--posts-->
                        <div class="container text-center" id="loader">
                            <i class="fa fa-refresh fa-4x fa-spin"></i>
                            <h3 class="mt-2">Loading...</h3>
                        </div>
                        
                        <div class="container-fluid" id="post-container">
                            
                        </div>
                    </div>
                    
                </div>
            </div>
        </main>
        <!--end main body of the page-->

        <!--profile modal-->
            <!-- Modal -->
            <div class="modal fade" id="profile-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header primary-background text-white text-center">
                    <h5 class="modal-title" id="exampleModalLabel">TechBlog</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <div class="modal-body">
                      <div class="container text-center">
                          <img src="pics/<%= user.getProfile() %>" style="border-radius: 50%; max-width: 150px" />
                          <br>
                        <h5 class="modal-title mt-3" id="exampleModalLabel"><%= user.getName() %></h5>
                        <!--details-->
                        <div id="profile-details">
                            <table class="table">
                                <tbody>
                                  <tr>
                                    <th scope="row">ID:</th>
                                    <td><%= user.getId() %></td>
                                  </tr>
                                  <tr>
                                    <th scope="row">Email:</th>
                                    <td><%= user.getEmail() %></td>
                                  </tr>
                                  <tr>
                                    <th scope="row">Gender</th>
                                    <td colspan="2"><%= user.getGender() %></td>
                                  </tr>
                                  <tr>
                                    <th scope="row">About</th>
                                    <td colspan="2"><%= user.getAbout() %></td>
                                  </tr>
                                  <tr>
                                    <th scope="row">Registered on</th>
                                    <td colspan="2"><%= user.getDateTime().toString() %></td>
                                  </tr>
                                </tbody>
                              </table>
                        </div>
                                  
                        <!--profile-edit-->
                        <div id="profile-edit" style="display: none">
                            <h3 class="mt-2">Please Edit Carefully </h3>
                            <form action="EditServlet" method="POST" enctype="multipart/form-data">
                                <table class="table">
                                    <tr>
                                        <td>ID : </td>
                                        <td><%= user.getId() %></td>
                                    </tr>
                                    <tr>
                                        <td>Name : </td>
                                        <td><input type="text" class="form-control" name="user_name" value="<%= user.getName() %>" ></td>
                                    </tr>
                                    <tr>
                                        <td>Email : </td>
                                        <td><input type="email" class="form-control" name="user_email" value="<%= user.getEmail() %>" ></td>
                                    </tr>
                                    <tr>
                                        <td>Password : </td>
                                        <td><input type="password" class="form-control" name="user_password" value="<%= user.getPassword() %>" ></td>
                                    </tr>
                                    <tr>
                                        <td>Gender : </td>
                                        <td><%= user.getGender().toUpperCase() %></td>
                                    </tr>
                                    <tr>
                                        <td>About : </td>
                                        <td>
                                            <textarea class="form-control" name="user_about">
                                                <%= user.getAbout() %>
                                            </textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>New Profile Pic : </td>
                                        <td>
                                            <input type="file" name="image" class="form-control">
                                        </td>
                                    </tr>
                                </table>
                                            <div class="container">
                                                <button type="submit" class="btn btn-outline-primary ">Save</button>
                                            </div>
                            </form>
                        </div>
                      
                      </div>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button id="edit-profile-btn" type="button" class="btn btn-primary">Edit</button>
                  </div>
                </div>
              </div>
            </div>
        <!--end of profile modal-->
        
        <!--add post modal-->
        
        <!-- Modal -->
        <div class="modal fade" id="add-post-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Provide the post details...</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
              <div class="modal-body">
                  <form id="add-post-form" action="AddPostServlet" method="post">
                      <div class="mb-3">
                          <select class="form-select" aria-label="Default select example" name="cid">
                            <option selected disabled>---Select Category---</option>
                            <% 
                                PostDao postd=new PostDao(ConnectionProvider.getConnection());
                                ArrayList<Category> list=postd.getAllCatagories();
                                
                                for(Category c:list){
                            %>
                            <option value="<%= c.getId() %>"><%= c.getName() %></option>
                            <%
                                }
                            %>
                        </select>
                      </div>
                      <div class="mb-3">
                          <input name="pTitle" type="text" placeholder="Enter post Title" class="form-control"/>
                      </div>
                      <div class="mb-3">
                          <textarea name="pContent" class="form-control" placeholder="Enter your content"></textarea>
                      </div>
                      <div class="mb-3">
                          <textarea name="pCode" class="form-control" placeholder="Enter your program(if any)"></textarea>
                      </div>
                      <div class="mb-3">
                          <label>Select your pic...</label>
                          <br>
                          <input name="pic" type="file" />
                      </div>
                        
                      <div class="container text-center">
                          <button type="submit" class="btn btn-outline-primary">Post</button>
                     
                      </div>
                  </form>
              </div>
            </div>
          </div>
        </div>
        
        <!--end post modal-->
         
        <!--javascript-->
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script>
            $(document).ready(function(){
                let editStatus=false;
                $("#edit-profile-btn").click(function(){
                    if(editStatus==false)
                    {
                        $("#profile-details").hide();
                        $("#profile-edit").show();
                        editStatus = true;
                        $(this).text("Back");
                    }else
                    {
                        $("#profile-details").show();
                        $("#profile-edit").hide();
                        editStatus = false;                        
                    }
                });
            });
            
        </script>
        <!--add post js-->
        <script>
            $(document).ready(function(e){
                $("#add-post-form").on("submit",function(event){
                    event.preventDefault();
                    
                    let form=new FormData(this);
                    $.ajax({
                        url: "AddPostServlet",
                        type:"POST",
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            if(data.trim() == 'done')
                            {
                                swal("Good job!","saved successfully","success");
                            }else{
                                swal("Error!!!","Something went wrong try again...","error");
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                                swal("Error!!!","Something went wrong try again...","error");
                        },
                        processData: false,
                        contentType: false
                    });
                });
            });
        </script>
        
        <!--loading post using ajax-->
        <script>
            function getPosts(catId,temp){
                $("#loader").show();
                $("#post-container").hide();
                $(".c-link").removeClass("active");
                
                $.ajax({
                   url: "load_posts.jsp",
                   data: {cid: catId},
                   success: function (data, textStatus, jqXHR) {
                        console.log(data);
                        $("#loader").hide();
                        $("#post-container").show();
                        $("#post-container").html(data);
                        $(temp).addClass("active");
                    }
               });
            }
            $(document).ready(function (e){
                let allPostRef=$(".c-link")[0];
                getPosts(0,allPostRef);
            });
        </script>
    </body>
</html>
 