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
})