(function ($) {
    var $status_form = $('form.js-status-form'),
        $status_content = $('.js-status-content', $status_form),
        $status_editable_content = $('.editable', $status_form),
        $status_toolbar = $('.toolbar', $status_form),
        $submit = $(':submit', $status_form),
        status_editable_placeholder = 'What\'s happening?',
        reset_status_form;

    reset_status_form = function () {
        $status_content.val('');
        $status_editable_content.text(status_editable_placeholder).removeClass('expand');
        $status_toolbar.removeClass('visible');
        $submit.prop('disabled', true);
    };

    if (App.user_signed_in) {
        $status_form.on('ajax:complete', function () {
            reset_status_form();
        });

        $status_editable_content.on('click', function () {
            var $this = $(this);

            if ($.trim($this.text()) == status_editable_placeholder) {
                $this.empty();
            }

            $this.addClass('expand');

            $status_toolbar.addClass('visible');
        }).on('keyup', function () {
            var $this = $(this),
                status_editable_content = $.trim($this.text());

            $submit.prop('disabled', !status_editable_content.length);

            if (status_editable_content.length) {
                $status_content.val(status_editable_content);
            }
        });

        $(document).on('click', function (event) {
            if (!$(event.target).closest($status_form).length) {
                reset_status_form();
            }
        });
    }

    $(document).on('click', '.js-status', function (event) {
        // event.stopPropagation();
        // show feed status details
        if (!$(event.target).closest('a').length) {
            $(this).children('.details').slideToggle(300);
        }
    }).on('click', function (event) {
        var $details;

        // hide feed status details
        if ($('.feed').length) {
            $details = $('.status .details:visible');

            if (!$(event.target).closest('.js-status').length && $details.length) {
                $details.slideToggle(300);
            }
        }
    });
})(jQuery);