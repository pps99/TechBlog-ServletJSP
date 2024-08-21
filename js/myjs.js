function doLike(pid,uid){
    console.log(pid,uid);
    
    const data ={
        uid: uid,
        pid: pid,
        operation: 'like'
    };
    
    $.ajax({
        url: "LikeServlet",
        data: data,
        success: function (data, textStatus, jqXHR) {
            console.log(data);
            if(data.trim()==='true'){
                let c = parseInt($(".like-counter-" + pid).html(), 10);
                c++;
                $(".like-counter-" + pid).html(c);
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(data);
        }
    })
}

