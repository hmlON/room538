# to call: ApplicationService.(params)
#
class ApplicationService
  def self.perform(args)
    service = new(args)
    service.perform
    service
  end

  # def initialize(*args, **kwargs)
  #   kwargs.each do |method_name, method_value|
  #     define_method(method_name) { method_value }
  #   end
  # end

  def perform
    raise NotImplementedError, 'This is an abstract method'
  end

  def errors
    # http://api.rubyonrails.org/classes/ActiveModel/Errors.html
    {}
  end

  def success?
    errors.empty?
  end

  def failure?
    !success?
  end
end
