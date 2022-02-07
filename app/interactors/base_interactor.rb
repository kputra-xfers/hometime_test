class BaseInteractor
  attr_reader :context

  def self.call(**kwargs)
    klass_instance = new(**kwargs)
    klass_instance.call

    klass_instance.context
  end

  def initialize(**kwargs)
    @context = OpenStruct.new(kwargs)
  end
end
