namespace :history do
  desc "studymodelを作成する"

  task destroy_study: :environment do
    User.all.each do |f|
      f.histories.destroy_all

    end

  end
end
