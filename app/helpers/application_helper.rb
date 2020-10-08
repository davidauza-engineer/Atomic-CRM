module ApplicationHelper
  def display_svg(path)
    # rubocop:disable Rails/OutputSafety
    File.open("app/assets/images/#{path}", 'rb') do |file|
      raw file.read
    end
    # rubocop:enable Rails/OutputSafety
  end
end
