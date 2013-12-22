class Contact < ActiveRecord::Base
  validates :firstname, :lastname, presence: true
  validates :email, uniqueness: true

  class << self
    def by_letter(letter)
      where("lastname LIKE ?", "#{letter}%").order(:lastname)
    end
  end

  def name
    [firstname, lastname].join(" ")
  end
end
