class Activity < ApplicationRecord

  has_paper_trail
  cattr_accessor :objects

    class << self

        def download
            @client = Strava::Api::V3::Client.new(:access_token => "73b6162bfe06a314a443630c548b502627cb7dd9")
            activity_ids = Activity.data_file_names
            @client.list_athlete_activities.each do |activity|
                unless activity_ids.include?(activity['id'])
                    activity_details = @client.retrieve_an_activity(activity['id'])
                    File.open("data/#{activity['id']}_activity", 'w') { |f|
                        f.puts activity_details.to_yaml
                    }
                    %w[distance latlng altitude velocity_smooth heartrate watts moving grade_smooth].each do |stream_type|
                        details = @client.retrieve_activity_streams(activity['id'], stream_type, {series_type: 'time'})
                        File.open("data/#{activity['id']}_#{stream_type}", 'w') { |f|
                            f.puts details.to_yaml
                        }
                    end
                end
            end
        end

        def read_yamls
            @objects = []
            data_file_names.each do |f|
                %w[distance latlng altitude velocity_smooth heartrate watts moving grade_smooth].each do |stream_type|
                    file_name = "data/#{f}_#{stream_type}"
                    puts file_name
                    obj = YAML.load_file(file_name)
                    @objects << obj rescue @activities = [obj]
                end

            end
        end

        def read_activities
            data_file_names.each do |f|
                file_name = "data/#{f}_activity"

                activity = YAML.load_file(file_name)
                data ={
                    name: Time.parse(activity['start_date']).strftime('%m/%d %H'),
                    start_ts: Time.parse(activity['start_date']).to_i,
                    distance: activity['distance'] * 0.000621371,
                    speed: activity['average_speed'] * 2.23694,
                    watts: activity['average_watts'],
                    kj: activity['kilojoules'],
                    calories: activity['calories'],
                    moving: activity['moving_time'],
                    stopped: activity['elapsed_time'] - activity['moving_time'],
                    location: "#{activity['start_latitude']},#{activity['start_longitude']}"
                }
                Activity.create(data)
            end
        end

        def read_efforts
            data_file_names.each do |f|
                file_name = "data/#{f}_activity"

                activity = YAML.load_file(file_name)
                # id: 3936203
                # name: CJ Trail -- River to Bradley
                # distance: 1839.1
                # average_grade: 0.2
                # maximum_grade: 16.0
                # elevation_high: 60.9
                # elevation_low: 48.4
                # start_latlng:
                #     - 38.996756
                # - -77.1686
                # end_latlng:
                #     - 39.009581
                # - -77.167227

                activity['segment_efforts'].each do |effort|
                    segment = effort['segment']
                    data = {
                        id: segment['id'],
                        name: segment['name'],
                        distance: segment['distance'],
                        grade: segment['average_grade'],
                        grade_max: segment['maximum_grade'],
                        high: segment['elevation_high'],
                        low: segment['elevation_low'],
                        start_location: "#{segment['start_latlng'][0]}, #{segment['start_latlng'][1]}",
                        end_location: "#{segment['end_latlng'][0]}, #{segment['end_latlng'][1]}"
                    }
                    unless Segment.find(data[:id])
                        Segment.create data
                    end

                end
            end
            Activity.create(data)
        end

        def data_file_names
            Dir.entries("data")
                .select { |f| !File.directory?(f) and f =~ /activity$/ }
                .map { |n| n[0..8].to_i }
        end
    end

end
