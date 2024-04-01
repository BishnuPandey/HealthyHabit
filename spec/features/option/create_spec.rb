require 'rails_helper'
require_relative '../../support/devise'

RSpec.feature "Option", :type => :feature do
  scenario "Create a new option" do
    login_as(create(:user, :admin_user))

    visit "/options/new"
    # save_and_open_page #launchy
    fill_in "option_question", :with => "How old are you?"
    fill_in "option_options", :with => "['10-20','20-30']"
    save_and_open_page
    click_button "Create Option"
    
    expect(page).to have_text("How old are you?")
  end
end