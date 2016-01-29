$(function() {
  // NOTE if you get HTTP error 414 - Request too large
  //      Don't use webrick, use thin.
  $('#ucb_rails_users').dataTable({
    "processing": true,
    "serverSide": true,
    "ajax": {
      url: $('#ucb_rails_users').data('url'),
    },
    "stateSave": true,
    "pageLength": 20,
    "language": {
      "search": "First or Last Name starts with:"
    },
    "lengthMenu": [[20, 50, 100, 1000], [20, 50, 100, 1000]],
    "order": [[ 4, "desc" ]],
    "columnDefs": [
      { "orderData": [ 0, 2, 3 ], "targets": [ 0 ] }, // admin
      { "orderData": [ 1, 2, 3 ], "targets": [ 1 ] }, // active
      { "orderData": [ 2, 3 ], "targets": [ 2 ] }, // first name
      { "orderData": [ 3, 2], "targets": [ 3 ] },   // last name
      { "orderable": false, "targets": [ 8 ] },   // edit
      { "orderable": false, "targets": [ 9 ] },   // delete
    ]



  }).fnSetFilteringDelay(250);
  

  
});