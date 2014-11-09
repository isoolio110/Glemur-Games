require 'bundler'
Bundler.require

require_relative 'connection.rb'
require 'sinatra/activerecord/rake'

namespace :db do

  desc "create glemur_games_db database"
  task :create do
    conn = PG::Connection.open()
    conn.exec('CREATE DATABASE glemur_games_db;')
    conn.close
  end

  desc "drop federal_stimulus_db database"
   task :drop do
    conn = PG::Connection.open()
    conn.exec('DROP DATABASE glemur_games_db;')
    conn.close
   end

   desc "seed database with words"
   task :load_word_data do
    require 'csv'
    conn = PG::Connection.open({dbname: 'glemur_games_db'})
    CSV.foreach('words.csv', :headers => false) do |row|
      word_text = row[0]
      sql_statement = <<-eos
        INSERT INTO words
          (word_text)
        VAlUES
        ($1)
      eos
    conn.exec_params(sql_statement, [word_text])
     end
     conn.close
   end
end




