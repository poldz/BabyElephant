$("#bank_withdrawal_list").html("<%= escape_javascript(render :partial => 'list') %>");
$("#accounting_period_summary").html("<%= escape_javascript(render :partial => '/shared/accounting_period_summary') %>");
$.colorbox.close();
