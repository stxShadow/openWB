/**
 * helper functions for setup-pages
 *
 * @author Michael Ortenstein
 */

function updateLabel(elementId) {
    /** @function updateLabel
     * sets the value-label (if exists) attached to the element to the element value
     * @param {string} elementId - the id of the element
     * @requires class:valueLabel assigned to the attached label
     */
    var element = $('#' + elementId);
    var label = $('label[for="' + element.attr('id') + '"].valueLabel');
    if ( label.length == 1 ) {
        var suffix = label.attr('suffix');
        var text = element.val();
        if ( suffix != '' ) {
            text += ' ' + suffix;
        }
        label.text(text);
    }
}

function setInputValue(elementId, value) {
    /** @function setInputValue
     * sets the value-label (if exists) attached to the element to the element value
     * @param {string} elementId - the id of the element
     * @param {string} value - the value the element has to be set to
     * if the element has data-attribute 'signcheckbox' the checkbox with the id of the attribute
     * will represent negative numbers by being checked
     */
    if ( !isNaN(value) ) {
        var element = $('#' + elementId);
        var signCheckboxName = element.data('signcheckbox');
        var signCheckbox = $('#' + signCheckboxName);
        if ( signCheckbox.length == 1 ) {
            // checkbox exists
            if ( value < 0 ) {
                signCheckbox.prop('checked', true);
                value *= -1;
            } else {
                signCheckbox.prop('checked', false);
            }
        }
        element.val(value);
        if ( element.attr('type') == 'range' ) {
            updateLabel(elementId);
        }
    }
}

function getTopicToSendTo (elementId) {
    var element = $('#' + elementId);
    var topicPrefix = element.data('topicprefix');
    var topicSubGroup = element.data('topicsubgroup');
    if ( typeof topicSubGroup == 'undefined' ) {
        // if no data-attribute for subgroup like /lp/1/ exists
        // topicIdentifier is the unique element id
        topicSubGroup = '';
        var topicIdentifier = element.attr('id');
    } else {
        // if data-attribute for subgroup like /lp/1/ exists
        // topicIdentifier is the non-unique element name
        var topicIdentifier = element.data('topicidentifier');
    }
    var topic = topicPrefix + topicSubGroup + topicIdentifier;
    topic = topic.replace('/get/', '/set/');
    return topic;
}

function setToggleBtnGroup(groupId, option) {
    /** @function setInputValue
     * sets the value-label (if exists) attached to the element to the element value
     * @param {string} elementId - the id of the button group
     * @param {string} option - the option the group btns will be set to
     * @requires data-attribute 'option' (unique for group) assigned to every radio-btn
     */
    $('input[name=' + groupId + '][data-option="' + option + '"]').prop('checked', true);
    $('input[name=' + groupId + '][data-option="' + option + '"]').closest('label').addClass('active');
    // and uncheck all others
    $('input[name=' + groupId + '][data-option!="' + option + '"]').each(function() {
        $(this).prop('checked', false);
        $(this).closest('label').removeClass('active');
    });
}
