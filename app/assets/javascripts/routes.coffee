$(document).on 'turbolinks:load', ->
  setTimeout(->
    alert('This alert should appear on iOS!') # TODO: This is just a test, remove-me!

    sharedClasses = [
      'FlashMessages'
    ]

    $.each sharedClasses, (_, klass) ->
      new Modules[klass]()

    $body = $('body')

    moduleNames = $.map $body.data('controller').split('/'), (name) ->
      $.map(name.split('_'), (string) -> string.charAt(0).toUpperCase() + string.slice(1)).join('')

    moduleClass = moduleNames.reduce ((klass, moduleName) ->
      if klass then klass[moduleName] else undefined
    ), Modules

    if moduleClass isnt undefined
      module = new moduleClass()

      action = $body.data('action')
      module[action]() if $.isFunction(module[action])
  , 100) # Not sure why, but iOS Safari won't work properly without it
