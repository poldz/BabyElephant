$("#bank_deposit_list").html("<%= escape_javascript(render :partial => 'list') %>");
$.colorbox.close();

$.get('<%= summary_account_accounting_period_path(@accounting_period.account, @accounting_period) -%>', function(data) {
  $('#accounting_period_summary').html(data);
});
