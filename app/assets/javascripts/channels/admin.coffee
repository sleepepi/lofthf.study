App.admin = App.cable.subscriptions.create "AdminChannel",
  connected: ->
    console.log "connected: AdminChannel"
    # Called when the subscription is ready for use on the server

  disconnected: ->
    console.log "disconnected: AdminChannel"
    # Called when the subscription has been terminated by the server

  received: (data) ->
    console.log "received: AdminChannel"
    console.log data
    # $("[data-channel=files-count]").append(data.files_count)
    $("[data-channel=files-count]").html(data.files_count)

  refresh_count: ->
    console "refresh_count: AdminChannel"
    @perform "refresh_count"
