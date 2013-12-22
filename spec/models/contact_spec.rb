require 'spec_helper'

describe Contact do
  it 'is valid with a firstname, lastname and email address' do
    expect(build(:contact)).to be_valid
  end

  it 'is invalid without a firstname' do
    contact = build(:contact, firstname: nil)
    expect(contact).to have(1).errors_on(:firstname)
  end

  it 'is invalid without a lastname' do
    contact = build(:contact, lastname: nil)
    expect(contact).to have(1).errors_on(:lastname)
  end

  it 'is invalid with a duplicate email address' do
    create(:contact, email: 'bobsen@gmail.com')
    contact = build(:contact, firstname: 'Betty', email: 'bobsen@gmail.com')
    expect(contact).to have(1).errors_on(:email)
  end

  it "returns a contact's full name a string" do
    contact = build(:contact, firstname: 'Bob', lastname: 'Bobsen')
    expect(contact.name).to eq 'Bob Bobsen'
  end

  describe 'filter last name by letter' do
    before :each do
      @smith = create(:contact, firstname: 'John', lastname: 'Smith',
        email: 'jsmith@example.com')
      @jones = create(:contact, firstname: 'Tim', lastname: 'Jones',
        email: 'tjones@example.com')
      @johnson = create(:contact, firstname: 'John', lastname: 'Johnson',
        email: 'jjohnson@example.com')
    end

    context 'matching letters' do
      it 'returns a sorted array of results that match' do
        expect(Contact.by_letter("J")).to eq [@johnson, @jones]
      end
    end

    context 'non-matching letters' do
      it 'only returns contacts with the provided starting letter' do
        expect(Contact.by_letter("J")).to_not include @smith
      end
    end
  end
end
