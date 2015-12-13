
module GL
class Version
  getter :major, :minor

  def self.get
    self.new String.new(GL::C.get_string(GL::VERSION))
  end

  def initialize(@string)
    split = @string.split('.')
    @major = split[0].to_i
    @minor = split[2].to_i
  end

  def to_s
    @string
  end
end
end
