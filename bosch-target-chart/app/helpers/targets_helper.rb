module TargetsHelper
  def update_frequency_select
    [
      t(:targets)[:fields][:update_frequency][:monthly],
      t(:targets)[:fields][:update_frequency][:yearly]
    ]
  end

  def edit_target_button(target)
    link_to 'javascript:void(0)', class: 'btn btn-warning text-white edit-target-button',
    title: t(:actions)[:edit], data: { toggle: 'tooltip', animation: 'false' } do
      fa_icon 'edit'
    end
  end

  def delete_target_button(target)
    link_to 'javascript:void(0)', class: 'btn btn-danger text-white delete-target-button',
    title: t(:actions)[:delete], data: { toggle: 'tooltip', animation: 'false' } do
      fa_icon 'trash'
    end
  end
end
