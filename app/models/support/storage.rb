# frozen_string_literal: true

require 'aws-sdk-s3'

class Storage
  def initialize(prefix = 'files')
    @prefix = prefix
    Aws.config.update region: region, credentials: credentials
  end

  def create_file(filename, file)
    key = "#{@prefix}/#{filename}"
    s3.put_object(bucket: bucket, key: key, body: file, acl: 'public-read')
  end

  private

  def s3
    Aws::S3::Client.new(profile: 'conscients', region: 'eu-west-3')
  end

  def credentials
    Aws::Credentials.new access_key_id, secret_access_key
  end

  def bucket
    creds.dig(:aws, :bucket)
  end

  def region
    creds.dig(:aws, :region)
  end

  def access_key_id
    creds.dig(:aws, :access_key_id)
  end

  def secret_access_key
    creds.dig(:aws, :secret_access_key)
  end

  def creds
    Rails.application.credentials
  end
end
