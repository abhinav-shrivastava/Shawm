require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user = User.new(name: 'Abhinav', email: 'abhinav.srivastava@adwyze.com')
  end

  it 'is valid with valid attributes' do
    expect(@user).to be_valid
  end

  it 'is not valid without a name' do
    @user.name = nil
    expect(@user).to_not be_valid
  end

  it 'is not valid without an email' do
    @user.email = nil
    expect(@user).to_not be_valid
  end

  it 'is not valid if name to be too long' do
    @user.name = 'a' * 51
    expect(@user).to_not be_valid
  end

  it 'is not valid if email is too long' do
    @user.email = 'a' * 244 + '@example.com'
    expect(@user).to_not be_valid
  end

  it 'is accepts valid email address' do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      expect(@user).to be_valid
    end
  end

  it 'rejects invalid email address' do
    valid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                         foo@bar_baz.com foo@bar+baz.com]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      expect(@user).to_not be_valid
    end
  end

  it 'does not allow duplicate email address' do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    expect(duplicate_user).to_not be_valid
  end

  it 'should save email address in lowercase' do
    mixed_case_email = 'Foo@ExAMPle.CoM'
    @user.email = mixed_case_email
    @user.save
    mixed_case_email.downcase.should eq(@user.reload.email)
  end
end
