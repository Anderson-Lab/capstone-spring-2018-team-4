# Currently it seems that this functionality is not generally supported by
# CapybaraWebkit. It seems that SeleniumWebdriver provides support for D&D
# but that would require several other changes to inplement Selenium.
#
# https://stackoverflow.com/questions/7796495/capybara-drag-drop-does-not-work
# https://github.com/SeleniumHQ/selenium/tree/master/rb

# require 'rails_helper'

# RSpec.describe "User adds a target to a chart", js: true do

#   let!(:current_user) { FactoryBot.create(:user) }

#   before :each do
#     current_user.confirm
#     sign_in(current_user)

#     @department = FactoryBot.create(:department)
#     @chart      = FactoryBot.create(:chart)
#     @target     = FactoryBot.create(:target, department: @department)
#                   FactoryBot.create(:indicator, target: @target)

#     visit dashboard_path
#   end

#   context 'for a valid chart for the target' do
#     it 'should render on the chart' do
#       find('#openTargetsSidebarButton').click
#       find(".targets-sidebar-department-header h2", text: @department.name).click

#       draggable_target = find("#target#{@target.id}Draggable")
#       droppable_chart  = find("#chart#{@chart.id}")

#       draggable_target.drag_to(droppable_chart)  

#       expect(page).to have_selector(".chart-target.target-#{@target.id} .card-title", text: @target.name)
#     end
#   end
# end
