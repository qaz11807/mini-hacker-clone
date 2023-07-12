class Api::V1::PostSummaryEntity < BaseSummaryEntity
  present_collection true

  expose :post_entities, as: :posts

  private

  def post_entities
    @post_entities ||= Api::V1::PostEntity.represent(pagination_items, options)
  end
end
