namespace :activity do
    desc "load from yaml to DB"
    task load: :environment do
        Activity.load
    end

    desc 'download activities'
    task download: :environment do
        Activity.download
    end

end
