module IndicatorsHelper
  def indicator_display(indicator)
    link_to(determine_button_icon(indicator), 'javascript:void(0)',
      class: determine_button_classes(indicator), role: 'button', tabindex: 0,
      data: {
        toggle: 'popover', container: 'body', placement: 'top', trigger: 'manual', animation: 'false',
        html: 'true', content: render('targets/forms/indicator_form', indicator: indicator)
      }
    )
  end

  def color_select(indicator)
    index = 0
    options_for_select(
      Indicator::COLORS.map do |color|
        index += 1
        [color, (index - 1).to_d]
      end,
      indicator.value
    )
  end

  def determine_button_icon(indicator)
    if indicator.is_positive?
      fa_icon('check-circle')
    elsif indicator.is_neutral?
      fa_icon('minus-circle')
    else
      fa_icon('times-circle')
    end
  end

  def determine_button_classes(indicator)
    if indicator.is_positive?
      'btn btn-success text-white positive-indicator'
    elsif indicator.is_neutral?
      'btn btn-warning text-white neutral-indicator'
    else
      'btn btn-danger text-white negative-indicator'
    end
  end

  def determine_select_classes(indicator)
    if indicator.is_positive?
      'bg-success text-white'
    elsif indicator.is_neutral?
      'bg-warning text-white'
    elsif indicator.is_negative?
      'bg-danger text-white'
    else
      ''
    end
  end
end
