module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end

  def table_header(condition, classes, &block)
    classes << "hilite" if condition
    content_tag :th, :class => classes.compact.join(" "), &block
  end

end
