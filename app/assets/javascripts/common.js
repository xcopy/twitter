// http://stackoverflow.com/a/20398132/1530725
(function ($) {
    // todo: <div>...</div> to new line
    $('[contenteditable="true"]').on('keypress', function (event) {
        var fragment, element, range, selection;

        if (event.which != 13) {
            return true;
        }

        fragment = document.createDocumentFragment();

        // add a new line
        element = document.createTextNode('\n');
        fragment.appendChild(element);
        // add the br, or p, or something else
        element = document.createElement('br');
        fragment.appendChild(element);

        // make the br replace selection
        range = window.getSelection().getRangeAt(0);
        range.deleteContents();
        range.insertNode(fragment);

        // create a new range
        range = document.createRange();
        range.setStartAfter(element);
        range.collapse(true);

        // make the cursor there
        selection = window.getSelection();
        selection.removeAllRanges();
        selection.addRange(range);

        return false;
    });
})(jQuery);