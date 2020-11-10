$(document).on('turbolinks:load', function() {
    $(".owl-carousel").owlCarousel({
        items:1,
        loop:true,
        margin:30
    });

    $("#product_category_id").change( function(e) {
        let categoryId = $(this).val()
        $.ajax({url: `/categories/${categoryId}/products/new`,
            dataType: "html",
        success: function(data){
            $(".nested-fields").html($(data).find(".nested-fields").html())
            $(".links").html($(data).find(".links").html())
        }})
    })

    $('#add-to-cart').on('ajax:success', function(e) {
        // let cartItemsNumber = parseInt($("span#cart-count").text()) + 1
        // console.log(e.detail[0])
        $("span#cart-count").text(e.detail[0])

    })
})