class Api::ApplicationController < ApplicationController
  private

  def success_response(data)
    render status: :ok, json: { data: data }
  end

  def error_response(key, error_message = nil)
    render_content = ErrorResponse.to_api(key, error_message).deep_dup
    render_content[:json].delete('app_code')
    render(render_content)
  end

  def serialize_response(serializer_name, resource, **options)
    controller_name = controller_path.classify
    serializer_class_name = "#{serializer_name.to_s.camelize}Serializer"
    serializer_class = controller_name.gsub(/Api::(\w+)::\S+$/, "Api::#{'\1'}::#{serializer_class_name}").safe_constantize || serializer_class_name.safe_constantize
    serializer = serializer_class.new(current_member: @member)
    render status: 200, json: { data: serializer.represent(resource, options) }
  end
end
