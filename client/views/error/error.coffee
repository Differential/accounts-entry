Template.entryError.helpers
  error: ->
    Session.get('entryError')

      
UI.registerHelper 'hasError', -> 
    rE = new RegExp("password");
    if (Session.equals("entryError", undefined))
      return ""
    if rE.test(Session.get('entryError'))
      return ""
    else
      return "has-error"
      
UI.registerHelper 'hasErrorPW', -> 
    rE = new RegExp("password");
    if (Session.equals("entryError", undefined))
      return ""
    if rE.test(Session.get('entryError'))
      return "has-error"
    else
      return ""
      

