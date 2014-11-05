require 'bundler'
Bundler.require 


require './models/user'
require './models/word'

require './helpers/authentication_helper'

require './controllers/application_controller'
require './controllers/sessions_controller'
require './controllers/users_controller'


map('/users'){ run UsersController }
map('/sessions'){ run SessionsController }
map('/'){ run ApplicationController }

