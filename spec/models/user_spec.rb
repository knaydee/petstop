require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it "is valid" do
      expect(create(:user)).to be_valid
    end
    it "is invalid without a username" do
      expect(build(:user, username: nil)).to be_invalid
    end
  end
end
