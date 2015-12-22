(function ($) {
    $(function () {
        if (App.user_signed_in) {
            if ($('.who-to-follow', '.sidebar').length) {
                $.get(Routes.who_to_follow_path({format: 'js'}));
            }
        }
    });
})(jQuery);