Template._entryExtraSignUpField.events({
  'keypress #referral, paste #referral': function(e){
    Meteor.setTimeout(function(){
      var currentCode = $(e.target).val();
      var currentTarget = $(e.target);
      if (currentCode.length >= 4){
        Meteor.call('checkPromoCodeZipCodeModal', currentCode, function(err, result){
          // console.log(result);
          if (err){
            console.log(err);
          }else{
            if (result.result){
              $(currentTarget).parent().removeClass("has-error");
              $(currentTarget).parent().addClass("has-success");
              Session.set("codeIsValid", true)
              $(currentTarget).siblings(".help-block").text(result.description)
            }else{
              $(currentTarget).parent().removeClass("has-success");
            //   $(currentTarget).parent().addClass("has-error");
            //   Session.set("codeIsValid", false)
              $(currentTarget).siblings(".help-block").text('')
            }
          }
        })
      }
    }, 300)
  },
})
