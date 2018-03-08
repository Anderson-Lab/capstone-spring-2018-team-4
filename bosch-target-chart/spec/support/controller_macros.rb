module ControllerMacros
  def login_user(current_user)
    before :each do
      allow(controller).to receive(:authenticate_user!) do
      end

      allow(controller).to receive(:current_user) do
        current_user
      end
    end
  end
end