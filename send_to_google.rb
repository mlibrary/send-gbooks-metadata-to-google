require 'googleauth'
require 'google/apis/drive_v3'
require 'dotenv'
require 'logger'
Dotenv.load('.env')
logger = Logger.new(STDOUT)
file_path = ARGV[0]

logger.info("Starting script to send metadata to google for file: #{file_path}")
raise StandardError.new("\"#{file_path}\" is not a valid file") unless File.exist?(file_path)
name = File.basename(file_path)
raise StandardError.new("\"#{file_path}\" is not xml.gz") unless name.match?(/\.xml\.gz$/)


Drive = ::Google::Apis::DriveV3
drive = Drive::DriveService.new

scope = "https://www.googleapis.com/auth/drive"
authorizer = Google::Auth::ServiceAccountCredentials.from_env(scope)
drive.authorization = authorizer
metadata = Drive::File.new(name: name, parents: [ENV.fetch('FOLDER')])
metadata = drive.create_file(metadata, upload_source: file_path, content_type: 'application/x-gzip')
#for debugging
#puts metadata
#drive.delete_file(metadata.id)

logger.info("Finished sending #{file_path} to the google drive")
