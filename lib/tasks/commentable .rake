require 'json'

namespace :commentable do
  namespace :weight do
  desc 'update the weight of post and comment'
    task :update => :environment do |_|
      [Post, Comment].each do |model|
        model.find_each(batch_size: 100) do |commentable|
          service = WeightCalculator.call(commentable.created_at)
          next if service.failed?

          commentable.update!(weight: service.result)
        end
      end
    end
  end
end
