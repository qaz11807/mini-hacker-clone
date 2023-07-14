namespace :weightable do
  namespace :weight do
  desc 'update the weight of post and comment'
    task :update => :environment do |_|
      [Post, Comment].each do |model|
        model.find_each(batch_size: 100) do |weightable|
          service = WeightCalculator.call(weightable.created_at)
          next if service.failed?

          weightable.update!(weight: service.result)
        end
      end
    end
  end
end
