class User < ActiveRecord::Base
  has_many :hangman_games
  has_many :words, through: :hangman_games

  include BCrypt

  def password
    @password ||= Password.new(self.password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end