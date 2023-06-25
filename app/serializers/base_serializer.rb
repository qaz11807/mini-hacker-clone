class BaseSerializer
  class << self
    attr_reader :entity_class

    def entity(entity_class)
      @entity_class ||= entity_class
    end
  end

  def initialize(params = {})
    @params = params
  end

  def represent(resource, opts = {})
    preload_associations(resource) if resource.is_a?(ActiveRecord)
    self.class.entity_class.represent(resource, opts.merge(@params)).as_json
  end

  protected

  def preload_associations(resource)
    ActiveRecord::Associations::Preloader.new.preload(resource, association_array)
  end

  def association_array; end
end
