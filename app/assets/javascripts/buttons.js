$(document).ready(function() {

// bind edit/delete buttons and create floater edit form
  $('.btn-edit').on('click', function(event) {
    event.preventDefault();
    // $(this).attr('disabled', 'disabled');
    if ( $(this).data("method") == "delete" ) {
      confirmDelete(this);
    } else {
      openEdit(this);
    };
  });

  // $('.content').on('click', '.complete-edit', function(event) {
  //   event.preventDefault();
  //   var itemId = $(this).parent().find('input[name="employer[id]"]').get(0).value;
  //   completeEdit(itemId, $(this).parent().serialize() );
  // });

// show button for completed job
  $('#show-button').on('click', function(event) {
    event.preventDefault();
    $('.not-visible').removeClass('not-visible');
    $(this).parent().addClass('not-visible');
  });

// close floater box
  $('.content .escape').on('click', function(event) {
    event.preventDefault();
    $('.floater form input').not('.persist').remove();
    $('.floater').removeClass('visible');
    $('.btn-edit').removeAttr('disabled');
  });

});

function confirmDelete(item) {
  var targetId = item.getAttribute('data-deleteId');
  var targetName = $(item).parents('.boss-edit').find('p[data-target="name"]').html();
  var userConfirm = confirm("Sure you want to delete " + targetName + "?");
  if (userConfirm) {
    $.ajax({
      method: "DELETE",
      url: "/employers/" + targetId,
      success: function(response) {
        $('.boss-edit[data-elemId="' + response.id + '"]').remove();
      }
    })
    .done(function(resp) {
      alert(resp.text);
    });
  } else {
    $('.btn-edit').removeAttr('disabled');
  };
}

function openEdit(item) {
  $('.floater').addClass('visible');
  var targetRow = $(item).parents('.boss-edit');
  var editId = targetRow.attr('data-elemId');
  var editName = targetRow.find('span[data-target="name"]').html();
  var editRate = targetRow.find('span[data-target="rate"]').html();
  addForm(editId, editName, editRate);
}

function completeEdit(itemId, editForm) {
  $.ajax({
    method: 'PUT',
    url: '/employers/' + itemId,
    data: editForm,
    success: function(response) {
      console.log(response);
    }
  })
  .done(function(resp) {

  });
}

function addForm(itemId, itemName, itemRate) {
  $('.floater form').attr('action', '/employers/' + itemId);
  $('.floater form').prepend("<input type='number' name='employer[rate]' value='" + stripDollar(itemRate) + "'>");
  $('.floater form').prepend("<input type='text' name='employer[name]' value='" + itemName + "'>");
  $('.floater form').prepend("<input type='hidden' name='employer[id]' value='" + itemId + "'>");
}

function stripDollar(curr) {
  return curr.replace(/\D/, "");
}