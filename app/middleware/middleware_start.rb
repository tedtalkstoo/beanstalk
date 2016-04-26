class MiddlewareStart

  def initialize(app)
    @app = app
  end

  def call(env)
    timestamp = (Time.now.to_f * 1000).to_i
    env['HTTP_X_MIDDLEWARE_START'] = timestamp.to_s

    @app.call(env)
  end

end
