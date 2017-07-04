$(window).bind('page:change', function () {
    $(ClientSideValidations.selectors.forms).enableClientSideValidations();
    //iCheck initializer
    $('input').iCheck({
        checkboxClass: 'icheckbox_square-orange',
        radioClass: 'iradio_square-red',
        increaseArea: '20%' // optional
    });
    $('[data-toggle="tooltip"]').tooltip();
    $.AdminLTE.layout.fix();
    $.AdminLTE.pushMenu.activate($.AdminLTE.options.sidebarToggleSelector);

    $('.date-picker-form').datetimepicker({
        locale: locale,
        format: 'D/M/YYYY',
        showTodayButton: true
    });

    $('.generate-seed').on('click', function() {
       // Metronic.blockUI({
       //     boxed: true,
       //     message: I18n.processing_message
       // });
        $.ajax({
            url: '/permissions/generate_seeds',
            type: 'POST',
            dataType: 'json',
            success: function() {
                if (window.location.href.indexOf('?') > -1) {
                    window.location.href = '/permissions#done';
                } else {
                    window.location.href = '/permissions#done';
                    location.reload();
                }
            },
            error: function() {}
        });
    });
});
