require 'active_support/core_ext'
require 'progressbar'
require 'net/http'
require 'uri'
require 'fileutils'

class Airenv::Downloader

  def initialize(uri, simple_name)
    @uri = URI.parse(uri)
    @simple_name = simple_name
  end

  def start
    FileUtils.mkdir_p Settings.temporary_sdk_file_directory

    bar = nil

    Net::HTTP.start(@uri.host, @uri.port) do |http|
      request = Net::HTTP::Get.new(@uri.request_uri)

      http.request(request) do |response|
        size = response["Content-Length"].to_f
        bar = ProgressBar.new(@simple_name, size) if bar.blank?

        File.open(temporary_sdk_file_path, "wb") do |file|
          response.read_body do |data|
            file.write data
            bar.set(file.tell)
          end

          if file.tell == size
            bar.finish
          end
        end
      end
    end
  end

  def temporary_sdk_file_path
    Settings.temporary_sdk_file_path(@simple_name)
  end

end