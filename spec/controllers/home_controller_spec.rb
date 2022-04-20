require_relative "../rails_helper"

describe HomeController do
  render_views

  before do
    User.create(age: 10, role: 'admin', salary: 100)
    User.create(age: 20, role: 'moderator', salary: 20)
    User.create(age: 30, role: 'user', salary: 50)
    DataPoint.create(value: 50, event_date: Date.yesterday)
    DataPoint.create(value: 100, event_date: Date.current)
    Account.create(name: 'One', priority: 100)
    Account.create(name: 'Two', priority: 200)
  end

  describe "#index" do
    it "works" do
      get :index
      expect(response).to be_successful
    end
  end

end