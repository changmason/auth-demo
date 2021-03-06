module IntegrationHelper
  def sign_up_with(email, password, password_confirmation)
    visit sign_up_path
    within('#registration-form') do
      fill_in 'Email', with: email
      fill_in 'Password', with: password, exact: true
      fill_in 'Password confirmation', with: password_confirmation, exact: true
      click_button 'Create Account'
    end
  end

  def login_with(email, password)
    visit login_path
    within('#login-form') do
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      click_button 'Login'
    end
  end
end