$(function() {
  var typeaheadCtrl;

  // prevent browser autocomplete from competing with Bootstrap typeahead
  $('.typeahead-lps-search').attr('autocomplete', 'off');
  
  // typing in search field clears uid field
  $('.typeahead-lps-search').keyup(function(evt) {
    if(evt.which != 13 && evt.which != 9) {
      var uidSelector = '#' + $(this).data('uid-dom-id');
      $(uidSelector).val('');      
    }
  });

  $('.typeahead-lps-search').keydown(function(evt) {
    if(evt.which == 13) {
      evt.preventDefault();
    } 
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

  typeaheadCtrl = $('.typeahead-lps-search').typeahead({
    minLength: 2,
    delay: 250,
    highlight: true,
    autoselect: true
  },
  {
    display: 'first_last_name',
    source: function(query, syncResults, asyncResults) {
      var url = this.$el.parents(".twitter-typeahead").find(".typeahead-lps-search").data('typeaheadUrl')
      if(!url)
        return;

      var localSrc = new Bloodhound({
        datumTokenizer: Bloodhound.tokenizers.whitespace,
        queryTokenizer: Bloodhound.tokenizers.whitespace,
        identify: function(obj) { return obj.uid; },
        remote: {
          url: url+"?query=%QUERY",
          wildcard: '%QUERY'
        }
      });
      localSrc.search(query, syncResults, asyncResults);
    }
  },
  {
    display: function(obj) { return obj.first_name + " " + obj.last_name },
    source: function(query, syncResults, asyncResults) {
      var url = this.$el.parents(".twitter-typeahead").find(".typeahead-lps-search").data('ldapSearchUrl');
      if(!url)
        return;

      var ldapSrc = new Bloodhound({
        datumTokenizer: Bloodhound.tokenizers.whitespace,
        queryTokenizer: Bloodhound.tokenizers.whitespace,
        identify: function(obj) { return obj.uid; },      
        remote: {
          url: url+"?query=%QUERY",
          wildcard: '%QUERY'
        }
      });
      ldapSrc.search(query, syncResults, asyncResults);      
    }
  })
  .on('typeahead:asyncrequest', function(){
    $(this).addClass('loading');
  })
  .on('typeahead:asynccancel typeahead:render typeahead:idle typeahead:close', function(){
    $(this).removeClass('loading');
  })
  .on('typeahead:select', function(evt, suggestion) {
    $("#"+$(evt.target).data('uid-dom-id')).val(suggestion.uid);
  }).on('typeahead:autocomplete', function(evt, suggestion) {
    console.log('autocomplete')
  })  


})
