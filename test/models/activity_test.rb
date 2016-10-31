require 'test_helper'

class ActivityTest < ActiveSupport::TestCase
  test "data file names" do
    names = Activity.data_file_names
    assert names.is_a?(Array)
    assert names.size > 0
  end

  test "download strava" do
    assert Activity.download
  end

  test "read activities" do
    assert Activity.read_activities
  end
end
