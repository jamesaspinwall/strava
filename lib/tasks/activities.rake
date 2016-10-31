namespace :activities do
  desc "load from yaml to DB"
  task load: :environment do
    Activity.read_activities
  end

end
