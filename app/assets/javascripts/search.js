function bindSortByLinks() {
  $('a.sort_by').click(function(event){
      event.preventDefault();
      loadSearch(this.dataset.sort_by, this.dataset.sort_type);
  });
}

function bindPrevNextButtons() {
  $('ul.pager li:not(.disabled) a').click(function(event){
      event.preventDefault();
      var sort_by = $('#dropdownMenu1').data()['sort_by'];
      var sort_type = $('#dropdownMenu1').data()['sort_type'];
      loadSearch(sort_by, sort_type, this.dataset.offset);
  });
}

function bindAddToMyAuctions() {
  $('a.add_to_my_auctions').click(function(event){
      event.preventDefault();
      var request = $.post("auctions", {auction: {name: this.dataset.name, url: this.dataset.url}})
      request.done(function() {
        alert("Added");
      })
      request.fail(function(xhr){
        var errors = $.parseJSON(xhr.responseText).errors;
        var message = "Not added. Something went wrong. " + errors.join('. ');
        alert(message);
      })
  });
}

function loadSearch(order_by, order_type, offset) {
    if($('#query').val() == ''){
        alert('Empty search query');
        return;
    }
    var search_params = '?category_id=' + $('#category_id').val();
    search_params += '&query=' + $('#query').val().replace(/ /g, '+');

    var price_from = $('#price_from').val() == '' ? '0' : $('#price_from').val();
    var price_to = $('#price_to').val() == '' ? '0' : $('#price_to').val();
    search_params += '&price_from=' + price_from + '&price_to=' + price_to;

    if(typeof(order_by) !== 'undefined'){
      search_params += '&order_by=' + order_by;
    }
    if(typeof(order_type) !== 'undefined'){
      search_params += '&order_type=' + order_type;
    }
    if(typeof(offset) !== 'undefined'){
      search_params += '&offset=' + offset;
    }
    $.blockUI({message: 'Searching...'});
    $("#search_results").load("search/search" + search_params, function(){
        bindSortByLinks();
        bindPrevNextButtons();
        bindAddToMyAuctions();
        $.unblockUI();
    })
}

var ready;
ready = function() {
  $("input[type='submit'][name='commit']").click(function() {
    loadSearch();
  });

  $("#price input").on("keyup", function(){
    var valid = /^\d{1,8}((\.|\,)\d{0,2})?$/.test(this.value),
    val = this.value;

  if(!valid){
    this.value = val.substring(0, val.length - 1);
  }
  });
};

$(document).ready(ready);
$(document).on('page:load', ready);

