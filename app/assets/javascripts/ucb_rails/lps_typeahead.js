$(function() {
  
  // prevent browser autocomplete from competing with Bootstrap typeahead
  $('.typeahead-lps-search').attr('autocomplete', 'off');
  
  // typing in search field clears uid field
  $('.typeahead-lps-search').keyup(function() {
    var uidSelector = '#' + $(this).data('uid-dom-id');
    $(uidSelector).val('');
  });
  
  // default handler for ldap search result link when used with typeahead
  $(document).on('click', 'a.lps-typeahead-item', function (e) {
    var link = $(this);
    var searchFieldSelector = '#' + link.parents('.modal').find('form input#search-field-name').val();
    var searchField = $(searchFieldSelector);
    var uidSelector = '#' + searchField.data('uid-dom-id');
    $(uidSelector).val(link.data('uid'));
    $(searchFieldSelector).val(link.data('first-name') + ' ' + link.data('last-name'));
    e.preventDefault();
    hideLpsModal();
  });
  
  function loadTypeahead(uid_name_json, asyncResults) {
    var names = [];
    var map = {};          
    $.each(uid_name_json, function (i, person) {
      map[person.first_last_name] = person;
      names.push(person.first_last_name);
    });

    asyncResults(names);
  } 
  
  function asyncTypeaheadSource(query, url, asyncResults) {
    if(typeof(url) === 'undefined') {
      return;
    }

    $.ajax({
      url: url, 
      type: 'get', 
      data: {query: query},
      dataType: 'json',
      success: function(uid_name_json) {
        loadTypeahead(uid_name_json, asyncResults);
      }
    });
  }

  var typeaheadCtrl = $('.typeahead-lps-search').typeahead({
    minLength: 2,
    delay: 250,
    highlight: true
  },
  {
    name: 'local-dataset',
    source: function(query, syncResults, asyncResults) {
      var url  = this.$el.parents(".twitter-typeahead").find(".typeahead-lps-search").data('typeaheadUrl');
      asyncTypeaheadSource(query, url, asyncResults);      
    }
  },
  {
    name: 'ldap-dataset',
    source: function(query, syncResults, asyncResults) {
      var url  = this.$el.parents(".twitter-typeahead").find(".typeahead-lps-search").data('ldapSearchUrl');
      asyncTypeaheadSource(query, url, asyncResults);
    }
  })
  .on('typeahead:asyncrequest', function(){
    $(this).addClass('loading');
  })
  .on('typeahead:asynccancel typeahead:asyncreceive', function(){
    $(this).removeClass('loading');
  });  


})
