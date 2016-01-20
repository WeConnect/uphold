module Uphold
  module Transports
    class Local < Transport
      def initialize(params)
        super(params)
        @folder_within = params[:folder_within]
      end

      def fetch_backup
        file_path = File.join(@path, @filename)
        if File.file?(file_path)
          tmp_path = File.join(@dir, File.basename(file_path))
          logger.debug "Copying '#{file_path}' to '#{tmp_path}'"
          FileUtils.cp(file_path, tmp_path)
          decompress(tmp_path) do |_b|
          end
          File.join(@dir, @folder_within)
        else
          logger.fatal "No file exists at '#{file_path}'"
        end
      end

    end
  end
end
