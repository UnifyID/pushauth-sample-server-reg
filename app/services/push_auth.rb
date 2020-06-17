class PushAuth
  include HTTParty
  base_uri Rails.configuration.x.pushauth.base_uri

  @@options = {
    headers: {
      "Content-Type": "application/json",
      "X-API-Key": Rails.application.credentials.unifyid[:server_api_key]
    }
  }

  def self.create_session(user_id, notification_title, notification_body)
    body = {
      "user" => user_id,
      "notification" => {
        "title" => notification_title,
        "body" => notification_body
      }
    }
    post("/v1/push/sessions", @@options.merge({body: body.to_json}))
  end

  def self.get_session_status(api_id)
    get("/v1/push/sessions/#{api_id}", @@options)
  end
end
