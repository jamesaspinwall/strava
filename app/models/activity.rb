class Activity < ApplicationRecord
  cattr_accessor :objects

  class << self

    def download
      @client = Strava::Api::V3::Client.new(:access_token => "73b6162bfe06a314a443630c548b502627cb7dd9")
      @client.list_athlete_activities.each do |activity|
        activity_details = @client.retrieve_an_activity(activity['id'])
        File.open("data/#{activity['id']}_activity", 'w') { |f|
          f.puts activity_details.to_yaml
        }
        %w[distance latlng altitude velocity_smooth heartrate watts moving grade_smooth].each do |stream_type|
          details = @client.retrieve_activity_streams(activity['id'], stream_type, { series_type: 'time' })
          File.open("data/#{activity['id']}_#{stream_type}", 'w') { |f|
            f.puts details.to_yaml
          }
        end
      end
    end

    def read_yamls
      Dir.entries("data")
        .select { |f| !File.directory?(f) and f =~ /activity$/ }
        .map { |n| n[0..8] }.each do |f|
        %w[distance latlng altitude velocity_smooth heartrate watts moving grade_smooth].each do |stream_type|
          file_name = "data/#{f}_#{stream_type}"
          puts file_name
          #obj = YAML.load_file(file_name)
          #@objects << obj rescue @activities = [obj]
        end

      end
    end

  end
end
