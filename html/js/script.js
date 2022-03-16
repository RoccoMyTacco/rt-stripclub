$(document).on('click', '.accept-button', function(e) {
    e.preventDefault();
    var PriceAmount = $(".text-input-price").val();
    var NoteAmount = $(".text-input-note").val();
    $.post('https://rt-stripclub/Click', JSON.stringify({}))
    if (PriceAmount != '' && PriceAmount != undefined && NoteAmount != '' && NoteAmount != undefined) {
        $.post('https://rt-stripclub/AddPrice', JSON.stringify({Price: PriceAmount, Note: NoteAmount}))
        $.post('https://rt-stripclub/CloseNui', JSON.stringify({}))
        $(".main-container").animate({"top": "-30vh"}, 250, function() {
            $(".text-input-price").val('');
            $(".text-input-note").val('');
            $('.main-container').css("display", "none");
        }) 
    } else {
        $.post('https://rt-stripclub/ErrorClick', JSON.stringify({}))
    }
});

$(document).on('click', '.accept-songbutton', function(e) {
    e.preventDefault();
    var songurl = $(".text-input-song").val();
    var volume = $(".text-input-volume").val();
    if (songurl != '' && songurl != undefined) {
        $.post('https://rt-stripclub/AddSong', JSON.stringify({Songurl: songurl, Volume: volume}))
        $.post('https://rt-stripclub/CloseNui', JSON.stringify({}))
        $(".main-container").animate({"top": "-30vh"}, 250, function() {
            $('.songs').html('');
            $(".text-input-song").val('');
            $('.main-container').css("display", "none");
        }) 
    } else {
        $.post('https://rt-stripclub/Click', JSON.stringify({}))
        $.post('https://rt-stripclub/PlaySong', JSON.stringify({}))
        $.post('https://rt-stripclub/CloseNui', JSON.stringify({}))
        $(".main-container").animate({"top": "-30vh"}, 250, function() {
            $('.songs').html('');
            $('.text-input-song').html('');
            $('.main-container').css("display", "none");
        }) 
    }
});

$(document).on('change', '.testvol', function(e) {
    var volume = $(".testvol").val();
    $.post('https://rt-stripclub/SetVolume', JSON.stringify({Volume: volume}))
  });
  

$(document).on('click', '.accept-volumebutton', function(e) {
    e.preventDefault();
    var volume = $(".text-input-volume").val();
    if (volume != '' && volume != undefined) {
        $.post('https://rt-stripclub/SetVolume', JSON.stringify({Volume: volume}))
        $.post('https://rt-stripclub/CloseNui', JSON.stringify({}))
        $(".main-container").animate({"top": "-30vh"}, 250, function() {
            $(".text-input-song").val('');
            $('.main-container').css("display", "none");
        }) 
    } else {
        $.post('https://rt-stripclub/ErrorClick', JSON.stringify({}))
    }
});

$(document).on('click', '.cancel-button', function(e) {
    e.preventDefault();
    $.post('https://rt-stripclub/Click', JSON.stringify({}))
    $.post('https://rt-stripclub/CloseNui', JSON.stringify({}))
    $(".main-container").animate({"top": "-30vh"}, 250, function() {
        $('.main-container').css("display", "none");
    }) 
});

OpenRegister = function() {
    $('.main-container').css("display", "block");
    $('.payment-container').hide()
    $('.song-container').hide()
    $('.menu-items-container').show()
    $('.main-container').animate({"top": "30vh"}, 350)
}

// Payment \\

$(document).on('click', '.close-button', function(e) {
    e.preventDefault();
    $.post('https://rt-stripclub/Click', JSON.stringify({}))
    $.post('https://rt-stripclub/CloseNui', JSON.stringify({}))
    $(".main-container").animate({"top": "-30vh"}, 250, function() {
        $('.items').html('');
        $('.main-container').css("display", "none");
    }) 
});
$(document).on('click', '.close-button2', function(e) {
    e.preventDefault();
    $.post('https://rt-stripclub/Click', JSON.stringify({}))
    $.post('https://rt-stripclub/CloseNui', JSON.stringify({}))
    $(".main-container").animate({"top": "-30vh"}, 250, function() {
        $('.songs').html('');
        $('.main-container').css("display", "none");
    }) 
});

$(document).on('click', '.pause-button', function(e) {
    e.preventDefault();
    $.post('https://rt-stripclub/Click', JSON.stringify({}))
    $.post('https://rt-stripclub/PauseSong', JSON.stringify({}))
    $.post('https://rt-stripclub/CloseNui', JSON.stringify({}))
    $(".main-container").animate({"top": "-30vh"}, 250, function() {
        $('.songs').html('');
        $('.main-container').css("display", "none");
    }) 
});

$(document).on('click', '.play-button', function(e) {
    e.preventDefault();
    $.post('https://rt-stripclub/Click', JSON.stringify({}))
    $.post('https://rt-stripclub/PlaySong', JSON.stringify({}))
    $.post('https://rt-stripclub/CloseNui', JSON.stringify({}))
    $(".main-container").animate({"top": "-30vh"}, 250, function() {
        $('.songs').html('');
        $('.main-container').css("display", "none");
    }) 
});
$(document).on('click', '.skip-button', function(e) {
    e.preventDefault();
    $.post('https://rt-stripclub/Click', JSON.stringify({}))
    $.post('https://rt-stripclub/SkipSong', JSON.stringify({}))
    $.post('https://rt-stripclub/CloseNui', JSON.stringify({}))
    $(".main-container").animate({"top": "-30vh"}, 250, function() {
        $('.songs').html('');
        $('.main-container').css("display", "none");
    }) 
});

$(document).on('click', '.payment', function(e) {
    e.preventDefault();
    var Price = $(this).data('price')
    var Note = $(this).data('note')
    var NumberId = $(this).data('id')
    $.post('https://rt-stripclub/Click', JSON.stringify({}))
    if (NumberId != null && Note!= null && Price != null) {
        $.post('https://rt-stripclub/PayReceipt', JSON.stringify({Price: Price, Note: Note, Id: NumberId}))
        $.post('https://rt-stripclub/CloseNui', JSON.stringify({}))
        $(".main-container").animate({"top": "-30vh"}, 250, function() {
            $('.items').html('');
            $('.main-container').css("display", "none");
        }) 
    } else {
        $.post('https://rt-stripclub/ErrorClick', JSON.stringify({}))
    }
});

$(document).on('click', '.songscreen', function(e) {
    e.preventDefault();
    var URL = $(this).data('songurl')
    var NumberId = $(this).data('id')
    $.post('https://rt-stripclub/Click', JSON.stringify({}))
    if (URL != null) {
        $.post('https://rt-stripclub/RemoveSong', JSON.stringify({Id: NumberId}))
        $.post('https://rt-stripclub/CloseNui', JSON.stringify({}))
        $(".main-container").animate({"top": "-30vh"}, 250, function() {
            $('.songs').html('');
            $('.main-container').css("display", "none");
        }) 
    } else {
        $.post('https://rt-stripclub/ErrorClick', JSON.stringify({}))
    }
});

SetupPayments = function(data) {
    for (const [key, value] of Object.entries(data)) {
        if (value != undefined && value != null) {
            var CurrentId = key
            var AddOption = '<div class="payment" data-price='+value['Price']+' data-note="'+value['Note']+'" data-id='+CurrentId+'><p>Price: $'+value['Price']+',- <br> Note: '+value['Note']+'</p></div>'
            $('.items').append(AddOption);
        }
    }
}

SetupSongs = function(data) {
    for (const [key, value] of Object.entries(data)) {
        if (value != undefined && value != null) {
            var CurrentId2 = key
            var AddOption2 = '<div class="songscreen" data-songurl="'+value['Songurl']+'" data-id='+CurrentId2+'><p>SongURL: '+value['Songurl']+'</p></div>'
            $('.songs').append(AddOption2);
        }
    }
}

OpenQueue = function() {
    $('.main-container').css("display", "block");
    $('.menu-items-container').hide()
    $('.payment-container').hide()
    $('.song-container').hide()
    $('.queue-container').show()
    $('.main-container').animate({"top": "30vh"}, 350)
}

OpenPayment = function() {
    $('.main-container').css("display", "block");
    $('.menu-items-container').hide()
    $('.song-container').hide()
    $('.queue-container').hide()
    $('.payment-container').show()
    $('.main-container').animate({"top": "30vh"}, 350)
}

OpenSongs = function() {
    $('.main-container').css("display", "block");
    $('.menu-items-container').hide()
    $('.payment-container').hide()
    $('.song-container').show()
    $('.queue-container').hide()
    $('.main-container').animate({"top": "30vh"}, 350)
}


window.addEventListener('message', function(event) {
    switch(event.data.action) {
        case "OpenRegister":
            OpenRegister();
        break;
        case "OpenPayment":
            SetupPayments(event.data.payments);
            OpenPayment();
        break;
        case "OpenSong":
            SetupSongs(event.data.activesongs);
            OpenSongs();
        break;
    }
});





