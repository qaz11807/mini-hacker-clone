class BaseSummaryEntity < BaseEntity
  present_collection true

  expose :current_page
  expose :total_pages
  expose :total_count

  private

  def pagination_items
    object[:items]
  end

  def current_page
    pagination_items.current_page
  end

  def total_count
    pagination_items.total_count
  end

  def total_pages
    pagination_items.total_pages
  end
end
