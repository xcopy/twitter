(function ($) {
    $(function () {
        if (App.user_signed_in) {
            $.get(Routes.who_to_follow_path({format: 'js'}));
        }
    });
})(jQuery);