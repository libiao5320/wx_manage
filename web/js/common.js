var showDiaLog = function( opt  ) {

    var _opt  = {
        message : opt.content ,
        title :opt.title,
        buttons :{

            success : {
                label :"确定",
                className :"btn-success",
                callback:function(){
                    if(opt.success)
                    opt.success();
                }

            },
            cancel :{
                label :"取消",
                className :"btn-primary",
                callback:function(){
                    if(opt.cancel)
                    opt.cancel();
                }

            }

        }


    }
    var options = opt ? _opt :{
        message: "看到这个对话框请仔细阅读common.js中的showDiaLog方法使用说明",
            title: "错误！！！",
        buttons: {
        success: {
            label: "Success!",
                className: "btn-success",
                callback: function () {
                Example.show("great success");
            }
        },
        danger: {
            label: "Danger!",
                className: "btn-danger",
                callback: function () {
                Example.show("uh oh, look out!");
            }
        },
        main: {
            label: "Click ME!",
                className: "btn-primary",
                callback: function () {
                Example.show("Primary button");
            }
        }
    }
    }

    bootbox.dialog(options);
}

var showAlert = function(msg, fn)
{
    bootbox.alert(msg, function() {
            if(fn)
            fn();
    });
}