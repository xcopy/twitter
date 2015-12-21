(function ($) {
    var $status_form = $('form#new_status'),
        $status_editable = $('#new_status_editable', $status_form),
        $status_form_toolbar = $('.toolbar', $status_form),
        status_editable_placeholder = 'What\'s happening?';

    if (App.user_signed_in) {
        $status_editable.on('click', function () {
            var $this = $(this);

            if ($.trim($this.text()) == status_editable_placeholder) {
                $this.empty();
            }

            $this.addClass('expand');

            $status_form_toolbar.show();
        }).on('keyup', function () {
            var $this = $(this),
                status_editable_text = $.trim($this.text());

            $(':submit', $status_form).prop('disabled', !status_editable_text.length);

            if (status_editable_text.length) {
                $('#status_text').val(status_editable_text);
            }
        });

        $(document).on('click', function (event) {
            // reset status form
            if (!$(event.target).closest($status_form).length) {
                $status_editable.text(status_editable_placeholder).removeClass('expand');
                $status_form_toolbar.hide();
                $(':submit', $status_form).prop('disabled', true);
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