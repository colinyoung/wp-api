module FilesHelper
  def support_file(name)
    File.new(File.expand_path("spec/files/#{name}"), 'r')
  end
end
