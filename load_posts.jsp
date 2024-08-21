<%@page import="java.util.List" %>
<%@page import="com.tech.blog.helper.ConnectionProvider" %>
<%@page import="com.tech.blog.dao.PostDao" %>
<%@page import="com.tech.blog.dao.LikeDao" %>
<%@page import="com.tech.blog.entities.Post" %>
<%@page import="com.tech.blog.entities.User" %>
<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login_page.jsp");
        return; // Ensure the rest of the page doesn't execute after redirect
    }
%>

<div class="row">
<% 
//    Thread.sleep(1000);
    PostDao d=new PostDao(ConnectionProvider.getConnection());
    
    int cid = Integer.parseInt(request.getParameter("cid"));
    List<Post> posts = null;
    if(cid==0){
        posts=d.getAllPosts();
    }
    else{
        posts=d.getPostByCatId(cid);
    }
    
    if(posts.size()==0)
    {
        out.println("<h3 class='display-3 text-center'>No Posts in this categroy...</h3>");
        return ;
    }

    for(Post p:posts)
    {
%>

<div class="col-md-6 mt-2">
    <div class="card" style="width: 18rem;">
        <img src="blog_pics/<%= p.getpPic() %>"  class="card-img-top" style="width: 50%" alt="...">
        <div class="card-body">
            <b><%= p.getpTitle() %></b>
            <p><%= p.getpContent() %></p>
        </div>
        <div class="card-footer primary-background text-center">
            <% 
                LikeDao ldao = new LikeDao(ConnectionProvider.getConnection());
            %>
            <a href="#" onclick="doLike(<%= p.getId() %>,<%= user.getId() %>)" class="btn btn-outline-light btn-sm"><i class="fa fa-thumbs-o-up"></i><span class="like-counter-<%= p.getId() %>"><%= ldao.countLikeOnPost(p.getId()) %></span></a>
            <a href="show_blog_page.jsp?post_id=<%= p.getId() %>" class="btn btn-outline-light btn-sm">Read More...</a>
            <a href="#" class="btn btn-outline-light btn-sm"><i class="fa fa-commenting-o"></i><span>20</span></a>
        </div>
    </div>
</div>

<%
    }
%>

</div>