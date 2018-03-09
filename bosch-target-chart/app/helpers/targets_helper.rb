module TargetsHelper
  def update_frequency_select
    [
      t(:targets)[:fields][:update_frequency][:monthly],
      t(:targets)[:fields][:update_frequency][:yearly]
    ]
  end

  def delete_target_button(target)
    link_to 'javascript:void(0)', class: 'btn btn-danger text-white delete-target-button',
      data: { target_id: target.id } do
        fa_icon 'trash'
      end
  end
end
