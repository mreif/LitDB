module ApplicationHelper
  
  def title(page_title)
    content_for(:title) { page_title }
  end
  
  def simple_format_span(text, html_options={}, options={})
    text = '' if text.nil?
    text = text.dup
    start_tag = tag('span', html_options, true)
    text = sanitize(text) unless options[:sanitize] == false
    text = text.to_str
    text.gsub!(/\r\n?/, "\n")                    # \r\n and \r -> \n
    text.gsub!(/\n\n+/, "</p>\n\n#{start_tag}")  # 2+ newline  -> paragraph
    text.gsub!(/([^\n]\n)(?=[^\n])/, '\1<br />') # 1 newline   -> br
    text.insert 0, start_tag
    text.html_safe.safe_concat("</span>")
  end
end
