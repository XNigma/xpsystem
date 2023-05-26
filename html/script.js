$(function () {

    function display(bool) {
        if (bool) {
            $("html").show();
        } else {
            $("html").hide();
        }
    }
    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type == "show") {
            if (item.status == true) {
                $("html").fadeIn();
                display(true)
            } else {
                display(false)
            }
        }
    })  

    window.addEventListener('message', function (event) {
        if (event.data.action == 'update') {
           let data = event.data.data;
               switch (event.data.type) {
                    case 'xp': {
                       $('#xp').html(`<span>XP: `+ data.value +`</span>`);                        
                       break;
                    }
                    case 'level': {
                        $('#level').html(`<span>Level: `+ data.value +`</span>`);                        
                        break;
                    }
                    case 'coins': {
                        $('#xpcoins').html(`<span>Coins: `+ data.value +`</span>`);                        
                        break;
                    }
               }
           }
       }
   );

    document.onkeyup = function (data) {
        if (data.which == 27) {
            $("html").fadeOut("slow");
            $.post('https://xpsystem/close', JSON.stringify({}));
            return
        }
    };  

    $("#btn-wab").click(function () {
        $.post('https://xpsystem/wab', JSON.stringify({}));
        return
    })
    
    $("#btn-armor").click(function () {
        $.post('https://xpsystem/armor', JSON.stringify({}));
        return
    })
    
    $("#btn-pistol").click(function () {
        $.post('https://xpsystem/pistol', JSON.stringify({}));
        return
    })
    
    $("#btn-money").click(function () {
        $.post('https://xpsystem/money', JSON.stringify({}));
        return
    })    
    
    $("#btn-bmoney").click(function () {
        $.post('https://xpsystem/bmoney', JSON.stringify({}));
        return
    })
    
    $("#btn-assrifle").click(function () {
        $.post('https://xpsystem/assrifle', JSON.stringify({}));
        return
    })
    
    $("#btn-fpack").click(function () {
        $.post('https://xpsystem/fpack', JSON.stringify({}));
        return
    })
    
    $("#btn-gpack").click(function () {
        $.post('https://xpsystem/gpack', JSON.stringify({}));
        return
    })
})