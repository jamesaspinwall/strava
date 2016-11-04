namespace :util do
    desc "load from yaml to DB"
    task load: :environment do
        Activity.read_activities
    end

    desc 'download activities'
    task download: :environment do
        Activity.download
    end
end
