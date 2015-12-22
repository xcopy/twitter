(function ($) {
    var $status_form = $('form.js-status-form'),
        $status_modal = $('#status'),
        $status_real_content = $('.js-real-status-content', $status_form),
        $status_editable_content = $('.js-editable-status-content', $status_form),
        $status_toolbar = $('.toolbar', $status_form),
        $submit = $(':submit', $status_form),
        status_editable_placeholder = 'What\'s happening?',
        reset_status_form;

    reset_status_form = function () {
        // reset textarea value
        $status_real_content.val('');
        // reset editable div
        $status_editable_content.text(status_editable_placeholder).removeClass('expand');
        // hide toolbar
        $status_toolbar.removeClass('visible');
        // disable submit button
        $submit.prop('disabled', true);

        if ($status_modal.hasClass('in')) {
            // hide modal
            $status_modal.modal('hide');
        }
    };

    if (App.user_signed_in) {
        // reset status form when modal hidden
        $status_modal.on('hidden.bs.modal', function () {
            reset_status_form();
        });

        // reset status form when request complete
        $status_form.on('ajax:complete', function () {
            reset_status_form();
        });

        // when editable div is "focused"
        $status_editable_content.on('click', function () {
            var $this = $(this);

            // "hide placeholder"
            if ($.trim($this.text()) == status_editable_placeholder) {
                $this.empty();
            }

            // if div is in home page
            if ($this.closest('.home').length) {
                // expand it
                $this.addClass('expand');
                // show toolbar
                $status_toolbar.addClass('visible');
            }
        // when editable div contents "changed"
        }).on('keyup', function () {
            var $this = $(this),
                status_editable_content = $.trim($this.text());

            // disable/enable submit button
            $submit.prop('disabled', !status_editable_content.length);

            // set textarea value
            if (status_editable_content.length) {
                $status_real_content.val(status_editable_content);
            }
        });

        // when editable div is "unfocused"
        $(document).on('click', function (event) {
            // modal is hidden & clicked happen out of status form
            if (!$status_modal.hasClass('in') && !$(event.target).closest($status_form).length) {
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