module CategoriesHelper
  def color_select_options
    color_options = {}
    t(:categories)[:chart_colors].each{ |color_key, color_name| color_options.merge!(color_name => Category::COLOR_HEX_VALUES_HASH[color_key]) }
    color_options
  end
end
