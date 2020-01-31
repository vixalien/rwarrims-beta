# frozen_string_literal: true

require "fileutils"
require "http"
require "pathname"
require "digest/md5"
require "active_support/core_ext/numeric/bytes"

module ActiveStorage
  # Use an http with a compliant api to upload files and save them

  class Service::RwarriService < Service
    attr_reader :server_url

    def initialize(server_url:)
      @server_url = server_url
    end

    def upload(key, io, checksum: nil, **)
      # Upload a file and raise an error if it occured
      instrument :upload, key: key, checksum: checksum do
        r = HTTP.get("http://#{server_url}/upload", :form => {io: io.read, key: key})
        raise r.to_s  unless r.status.to_i == 200
        ensure_integrity_of(key, checksum) if checksum
      end
    end

    def download(key, &block)
      # Get content of a file
      if !block_given?
        instrument :download, key: key do
          r = HTTP.get("http://#{server_url}/download", :form => {key: key})
          if r.status.to_i == 200
            r.to_s
          else
            raise r.to_s 
          end
        end
      else
        raise NotImplementedError
      end
    end

    def download_chunk(key, range)
      # Download a file partially
      instrument :download_chunk, key: key, range: range do
        r = HTTP.get("http://#{server_url}/download_chunk", :form => {key: key, begin: range.begin, size: range.size})
        if r.status.to_i == 200
          r.to_s
        else
          raise r.to_s 
        end
      end
    end

    def delete(key)
      instrument :delete, key: key do
        r = HTTP.get("http://#{server_url}/delete", :form => {key: key})
        if r.status.to_i == 200
          r.to_s
        else
          raise r.to_s 
        end
      end
    end

    def delete_prefixed(prefix)
      instrument :delete_prefixed, prefix: prefix do
        r = HTTP.get("http://#{server_url}/delete_prefixed", :form => {prefix: prefix})
        if r.status.to_i == 200
          r.to_s
        else
          raise r.to_s 
        end
      end
    end

    def exist?(key)
      instrument :exist, key: key do |payload|
        r = HTTP.get("http://#{server_url}/exist", :form => {key: key})
        answer = r.status.to_i == 200
        payload[:exist] = answer
        answer
      end
    end

    def url(key, expires_in:, filename:, disposition:, content_type:)
      instrument :url, key: key do |payload|
        
        generated_url = "http://#{server_url}/url/#{key}"
        payload[:url] = generated_url

        generated_url
      end
    end

    def url_for_direct_upload(key, expires_in:, content_type:, content_length:, checksum:)
      instrument :url, key: key do |payload|
        verified_token_with_expiration = ActiveStorage.verifier.generate(
          {
            key: key,
            content_type: content_type,
            content_length: content_length,
            checksum: checksum
          },
          { expires_in: expires_in,
          purpose: :blob_token }
        )

        generated_url = url_helpers.update_rails_disk_service_url(verified_token_with_expiration, host: current_host)

        payload[:url] = generated_url

        generated_url
      end
    end

    def headers_for_direct_upload(key, content_type:, **)
      { "Content-Type" => content_type }
    end
    private
      def ensure_integrity_of(key, checksum)
        true
      end

      def url_helpers
        @url_helpers ||= Rails.application.routes.url_helpers
      end

      def current_host
        ActiveStorage::Current.host
      end
  end
end
