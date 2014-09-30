module JScrambler
  class Config

    DEFAULT_CONFIG_FILE = 'config/jscrambler_config.json'

    def initialize(config_file_path=nil)
      begin
        config_file_path ||= DEFAULT_CONFIG_FILE
        @config = JSON.parse(File.open(config_file_path, 'rb').read)
        if @config['keys']['accessKey'].empty? || @config['keys']['secretKey'].empty?
          raise JScrambler::MissingKeys, 'Missing Access Key or Secret Key'
        end
      rescue JSON::ParserError
        @config = JSON.parse(File.open(DEFAULT_CONFIG_FILE, 'rb').read)
      rescue Errno::ENOENT
        raise JScrambler::ConfigError, "Could not find config file in #{config_file_path}"
      end
    end

    def to_hash
      @config
    end
  end
end
