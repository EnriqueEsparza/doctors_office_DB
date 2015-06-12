require("spec_helper")
require('capybara/rspec')
require('./app')
DB = PG.connect({:dbname => "doctors_office_test"})
include Capybara::DSL # Added to solve problem where capybara couldn't find visit method


Capybara.app = Sinatra::Application
set(:show_expections, false)

describe('adding a doctor', {:type => feature}) do
  it('allows a user to add a new doctor to a list') do
    visit('/')

    fill_in('name', :with => 'Dr. Jones')
    click_button('Add doctor')
    expect(page).to have_content('Dr. Jones')

  end
end
