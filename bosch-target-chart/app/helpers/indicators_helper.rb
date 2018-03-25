module IndicatorsHelper
  def indicator_display(indicator)
    link_to(determine_button_icon(indicator), 'javascript:void(0)',
      class: determine_button_classes(indicator), role: 'button', tabindex: 0,
      data: {
        toggle: 'popover', container: 'body', placement: 'top', trigger: 'manual', animation: 'false',
        html: 'true', content: render('indicators/forms/indicator_form', indicator: indicator)
      }
    )
  end

  def determine_button_icon(indicator)
    if indicator.new_record?
      fa_icon('plus-circle')
    elsif indicator.is_positive?
      fa_icon('check-circle')
    elsif indicator.is_neutral?
      fa_icon('minus-circle')
    else
      fa_icon('times-circle')
    end
  end

  def determine_button_classes(indicator)
    if indicator.new_record?
      'btn btn-secondary text-white indicator new-indicator'
    elsif indicator.is_positive?
      'btn btn-success text-white indicator positive-indicator'
    elsif indicator.is_neutral?
      'btn btn-warning text-white indicator neutral-indicator'
    else
      'btn btn-danger text-white indicator negative-indicator'
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
