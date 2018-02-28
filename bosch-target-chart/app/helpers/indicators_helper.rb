module IndicatorsHelper
  def positive_indicator
    content_tag(:div,(
      content_tag(:span, 'TBP')+raw('<br>')+
      link_to('javascript:void(0)', class: 'btn btn-success text-white positive-indicator',
        title: '100/100', data: { toggle: 'tooltip', animation: 'false' }) do
        fa_icon('check-circle')
      end
      ),
      class: 'col-sm-4'
    )
  end

  def neutral_indicator
    content_tag(:div,(
      content_tag(:span, 'FC')+raw('<br>')+
      link_to('javascript:void(0)', class: 'btn btn-warning text-white neutral-indicator',
        title: '50/100%', data: { toggle: 'tooltip', animation: 'false' }) do
        fa_icon('minus-circle')
      end
      ),
      class: 'col-sm-4'
    )
  end

  def negative_indicator
    content_tag(:div,(
      content_tag(:span, 'CF')+raw('<br>')+
      link_to('javascript:void(0)', class: 'btn btn-danger text-white negative-indicator',
        title: 'Red', data: { toggle: 'tooltip', animation: 'false' }) do
        fa_icon('times-circle')
      end
      ),
      class: 'col-sm-4'
    )
  end
end
