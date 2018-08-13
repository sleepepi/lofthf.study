class FilesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "files_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    ActionCable.server.broadcast("files_channel", data)
  end
end
