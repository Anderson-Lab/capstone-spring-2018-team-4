require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

  login_user(FactoryBot.create(:user))

  describe 'POST #create' do
    context 'with valid inputs' do
      context 'without image' do
        before :each do
          @category = FactoryBot.build(:category)

          post :create, params: {
            category: {
              name: @category.name,
              color: @category.color,
              icon: nil
            }
          }, format: :js
        end

        it { is_expected.to respond_with :ok }

        it { is_expected.to render_template :create }

        it 'should save the category' do
          expect(Category.count).to eq(1)
        end
      end

      context 'with image' do
        before :each do
          @category = FactoryBot.build(:category)

          post :create, params: {
            category: {
              name: @category.name,
              color: @category.color,
              icon: Rack::Test::UploadedFile.new(File.join('spec/example_files', 'default_category_icon.png'),'image/png')
            }
          }, format: :js
        end

        it { is_expected.to respond_with :ok }

        it { is_expected.to render_template :create }

        it 'should save the category' do
          expect(Category.count).to eq(1)
        end
      end
    end

    context 'with invalid inputs, no image' do
      context 'without image' do
        before :each do
          @category = FactoryBot.build(:category)

          post :create, params: {
            category: {
              name: nil,
              color: nil,
              icon: nil
            }
          }, format: :js
        end

        it { is_expected.to respond_with :ok }

        it { is_expected.to render_template :create }

        it 'should not save the category' do
          expect(Category.count).to eq(0)
        end

        it 'should assign @errors' do
          expect(:errors).to_not be_nil
        end
      end

      context 'with image' do
        before :each do
          @category = FactoryBot.build(:category)

          post :create, params: {
            category: {
              name: nil,
              color: nil,
              icon: Rack::Test::UploadedFile.new(File.join('spec/example_files', 'text_file.txt'),'text/plain')
            }
          }, format: :js
        end

        it { is_expected.to respond_with :ok }

        it { is_expected.to render_template :create }

        it 'should not save the category' do
          expect(Category.count).to eq(0)
        end

        it 'should assign @errors' do
          expect(:errors).to_not be_nil
        end
      end
    end
  end
end