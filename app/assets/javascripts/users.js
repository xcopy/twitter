(function ($) {
    $(document).on('mouseenter', '.js-unfollow', function () {
        $(this).children('span').text('Unfollow').end()
            .children('i.fa').removeClass('fa-check').addClass('fa-user-times').end()
            .removeClass('btn-info').addClass('btn-danger').end();
    }).on('mouseleave', '.js-unfollow', function () {
        $(this).children('span').text('Following').end()
            .children('i.fa').removeClass('fa-user-times').addClass('fa-check').end()
            .removeClass('btn-danger').addClass('btn-info').end();
    });
})(jQuery);