namespace :study do
  desc "studymodelを作成する"

  task create_study: :environment do
    User.all.each do |f|
      f.studies.create(count: 0)

    end

  end
end
