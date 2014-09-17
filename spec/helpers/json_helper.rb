module JSONHelper
  def parse_json(file_or_string)
    Yajl::Parser.new.parse(file_or_string)
  end
end
