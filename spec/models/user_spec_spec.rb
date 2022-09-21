require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validation' do

    it 'should save user when all requirements are met' do
      @user = User.new(name: 'Cristian', email: 'csl4402@hotmail.com', password: "Cristian1", password_confirmation: "Cristian1")
      expect(@user).to be_valid
    end

    it 'shouldnt save if password and password_confirmation dont match' do
      @user = User.new(name: 'Cristian', email: 'csl44@hotmail.com', password: "Cristian1", password_confirmation: "cristian2")
      @user.save 
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should give an error message if password is not present' do
      @user = User.new(name: 'Cristian', email: 'csl44@hotmail.com', password: nil, password_confirmation: nil)
      @user.save
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'should give an error message if name is not present' do
      @user = User.new(name: nil, email: 'csl44@hotmail.com', password: "Cristian1", password_confirmation: "Cristian1")
      @user.save
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end

    it 'should give an error message if email not set' do
      @user = User.new(name: 'Cristian', email: nil, password: "Cristian1", password_confirmation: "Cristian1")
      @user.save
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'should give an error message if email is not unique' do
      @user_1 = User.new(name: 'Cristian', email: 'csl44@hotmail.com', password: "Cristian1", password_confirmation: "Cristian1")
      @user_1.save
      @user_2 = User.new(name: 'Estuardo', email: 'csl44@hotmail.com', password: "sanchez1", password_confirmation: "sanchez1")
      @user_2.save
      expect(@user_2.errors.full_messages).to include("Email has already been taken")
    end

    it 'should have a minimun password length' do
      @user = User.new(name: 'Cristian', email: 'csl44@hotmail.com', password: "csl", password_confirmation: "csl")
      @user.save
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 5 characters)')
    end

  end

  describe '.authenticate_with_credentials' do
    
    it 'should only allow users to login with correct info' do
      @user = User.new(name: 'Cristian', email: 'csl4402@gmail.com', password: "Cristian1", password_confirmation: "Cristian1")
      @user.save
      @user_logged_in = User.authenticate_with_credentials('csl4402@gmail.com', "Cristian1")
      expect(@user_logged_in).to_not eq(nil)
    end

    it 'should authenticate user with incorrect email' do
      @user = User.new(name: 'Cristian', email: 'csl4402@gmail.com', password: "Cristian1", password_confirmation: "Cristian1")
      @user.save
      @user_logged_in = User.authenticate_with_credentials(' csl4402@gmail.com ', "Cristian1")
      expect(@user_logged_in).to_not eq(nil)
    end

    it 'should authenticate user if email in the wrong case' do
      @user = User.new(name: 'Cristian', email: 'CSL44@gmail.com', password: "Cristian1", password_confirmation: "Cristian1")
      @user.save
      @user_logged_in = User.authenticate_with_credentials('csl44@gmail.com', "Cristian1")
      expect(@user_logged_in).to_not eq(nil)
    end
  end

end