<%-- 
    Document   : register_page
    Created on : 7 Aug 2024, 15:49:57
    Author     : pyaephyoshan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Page</title>
        <!--css-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <script src="https://kit.fontawesome.com/b45ad3d737.js" crossorigin="anonymous"></script>
        <style>
            .banner-background{
                clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 94%, 68% 91%, 31% 96%, 0 89%, 0 0);
            }
        </style>
    </head>
    <body>
        <!--navbar-->
        <%@include file="normal_navbar.jsp" %>
        
        <main class="primary-background banner-background" style="padding-bottom: 80px; padding-top: 10px">
            <div class="contianer">
                <div class="col-md-6 offset-md-3">
                    <div class="card">
                        <div class="card-header text-center primary-background text-white">
                            <span class="fa fa-3x fa-user-circle"></span>
                            <br>
                            Register Here
                        </div>
                        <div class="card-body">
                            <form id="reg-form" action="RegisterServlet" method="POST">
                                <div class="mb-3">
                                  <label for="user_name" class="form-label">User Name</label>
                                  <input type="text" name="user_name" class="form-control" id="user_name" aria-describedby="emailHelp" placeholder="Enter User Name">
                                </div>                                
                                
                                <div class="mb-3">
                                  <label for="exampleInputEmail1" class="form-label">Email address</label>
                                  <input type="email" name="user_email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter Email">
                                  <div id="emailHelp" class="form-text">We'll never share your email with anyone else.</div>
                                </div>
                                
                                
                                <div class="mb-3">
                                  <label for="exampleInputPassword1" class="form-label">Password</label>
                                  <input type="password" name="user_password" class="form-control" id="exampleInputPassword1" placeholder="Enter Password">
                                </div>
                                
                                <div class="mb-3">
                                  <label for="gender" class="form-label">Select Gender</label>
                                  <br>
                                  <input type="radio"  id="gender" name="gender" value="male" > Male
                                  <input type="radio"  id="gender_2" name="gender" value="female" > Female
                                </div>
                                
                                <div class="mb-3">
                                    <textarea name="about" class="form-control" rows="1" placeholder="Enter something about yourself"></textarea>
                                </div>
                                
                                
                                <div class="mb-3 form-check">
                                    <input type="checkbox" name="check" class="form-check-input" id="exampleCheck1">
                                  <label class="form-check-label" for="exampleCheck1">Agree Terms and Conditions</label>
                                </div>
                                
                                <div class="container text-center" id="loader" style="display: none">
                                   <span class="fa fa-refresh fa-spin fa-4x"></span> 
                                   <h4>Please Wait</h4>
                                </div>

                                <button id="submit-btn" type="submit" class="btn btn-primary">Submit</button>
                              </form>
                        </div>
                    </div>
                    
                    
                </div>
            </div>
            
        </main>
        
        
        <!--javascript-->
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js" integrity="sha512-AA1Bzp5Q0K1KanKKmvN/4d3IRKVlv9PYgwFPvm32nPO6QS8yH1HO7LbgB1pgiOxPtfeg5zEn2ba64MUcqJx6CA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script>
            $(document).ready(function(){
                console.log("loaded...");
                
                $('#reg-form').on('submit',function(event){
                    event.preventDefault();
                    
                    
                    
                    let form=new FormData(this);
                    $('#submit-btn').hide();
                    $('#loader').show();
                    
                    //send register servlet
                    $.ajax({
                        url: "RegisterServlet",
                        type: "POST",
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                        console.log(data);
                        $('#submit-btn').show();
                        $('#loader').hide();
                        if(data.trim() === 'done')
                        {
                        swal("Registered successfully..we are going to redirect to login page ")
                            .then((value) => {
                              window.location="login_page.jsp";
                            });
                        }else{
                            swal(data);
                        }
                        
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        $('#submit-btn').hide();
                        $('#loader').show();
                        swal("Something went wrong...try again")
                            .then((value) => {
                              window.location="login_page.jsp";
                            });
                    },
                    processData: false,
                    contentType: false
                    });
                });
            });
        </script>
    </body>
</html>
