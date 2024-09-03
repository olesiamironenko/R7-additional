require 'rails_helper'
RSpec.describe Customer, type: :model do
  subject { Customer.new(first_name: "Jack", last_name: "Smith", phone: "8889995678", email: "jsmith@sample.com" )}
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  it "is not valid without a first_name" do
    subject.first_name=nil
    expect(subject).to_not be_valid
  end
  it "is not valid without a last_name" do
    subject.last_name=nil
    expect(subject).to_not be_valid
  end
  it "is not valid without a phone number" do
    subject.phone=nil
    expect(subject).to_not be_valid
  end
  it "is not valid without an email" do
    subject.email=nil
    expect(subject).to_not be_valid
  end

  describe 'phone number validation' do 
    it 'is invalid with less than 10 digits or more than 10 digits' do invalid_phone_numbers = ['123456789', '12345678901'] # 9 digits and 11 digits 
      invalid_phone_numbers.each do |invalid_phone_number| 
        customer = Customer.new(phone: invalid_phone_number) 
        expect(customer).not_to be_valid 
        expect(customer.errors[:phone]).to include('is the wrong length (should be 10 characters)') 
      end 
    end 
  end

  it "is not valid if the phone number is not all digits" do
    subject.phone='abcdefg'
    expect(subject).to_not be_valid
  end
  it "is not valid if the email address doesn't have a @" do
    subject.email='smith.com'
    expect(subject).to_not be_valid
  end
  it "returns the correct full_name" do
    expect(subject.full_name).to eq("Jack Smith")
  end
end
