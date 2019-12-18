(function() {
  $(document).on('ajax:success', '#createTicket', function(xhr, data, status) {
    return location.reload();
  });

  $(document).on('ajax:error', '#createTicket', function(xhr, data, status) {
    var div, form, ul;
    form = $('#new_ticket .modal-body');
    div = $('<div id="createTicketErrors" class="alert alert-danger"></div>');
    ul = $('<ul></ul>');
    data.responseJSON.messages.forEach(function(message, i) {
      var li;
      li = $('<li></li>').text(message);
      return ul.append(li);
    });
    if ($('#createTicketErrors')[0]) {
      return $('#createTicketErrors').html(ul);
    } else {
      div.append(ul);
      return form.prepend(div);
    }
  });

}).call(this);
