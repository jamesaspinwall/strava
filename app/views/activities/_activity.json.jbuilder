json.extract! activity, :id, :name, :location, :activity_start, :distance, :hr, :hr_max, :moving, :stop, :speed, :watts, :calories, :kj, :created_at, :updated_at
json.url activity_url(activity, format: :json)