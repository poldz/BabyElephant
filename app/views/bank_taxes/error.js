$("#entryForm").html("<%= escape_javascript(render :partial => 'form') %>");
$("#entryForm").colorbox.resize();
