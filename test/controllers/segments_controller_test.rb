require 'test_helper'

class SegmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @segment = segments(:one)
  end

  test "should get index" do
    get segments_url
    assert_response :success
  end

  test "should get new" do
    get new_segment_url
    assert_response :success
  end

  test "should create segment" do
    assert_difference('Segment.count') do
      post segments_url, params: { segment: { distance: @segment.distance, end_location: @segment.end_location, grade: @segment.grade, grade_max: @segment.grade_max, high: @segment.high, low: @segment.low, name: @segment.name, start_location: @segment.start_location } }
    end

    assert_redirected_to segment_url(Segment.last)
  end

  test "should show segment" do
    get segment_url(@segment)
    assert_response :success
  end

  test "should get edit" do
    get edit_segment_url(@segment)
    assert_response :success
  end

  test "should update segment" do
    patch segment_url(@segment), params: { segment: { distance: @segment.distance, end_location: @segment.end_location, grade: @segment.grade, grade_max: @segment.grade_max, high: @segment.high, low: @segment.low, name: @segment.name, start_location: @segment.start_location } }
    assert_redirected_to segment_url(@segment)
  end

  test "should destroy segment" do
    assert_difference('Segment.count', -1) do
      delete segment_url(@segment)
    end

    assert_redirected_to segments_url
  end
end
