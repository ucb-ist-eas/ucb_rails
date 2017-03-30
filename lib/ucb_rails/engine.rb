module UcbRails
  class Engine < ::Rails::Engine
    config.generators do |g|
      g.test_framework :rspec
      g.integration_tool :rspec
    end
  end

  def self.config(&block)
    yield Engine.config if block
    Engine.config
  end

  def self.[](key)
    setting = config.send(key)

    if setting.is_a?(Proc)
      setting.call
    else
      setting
    end

  rescue NameError
    Rails.logger.debug "[UcbRails] Tried to access unknown UcbRails.config key: #{key.inspect}"
    nil
  end
end
