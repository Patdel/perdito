require 'pry'
require 'redis'
require 'sinatra/base'
require 'sinatra/reloader'


require_relative 'server'

run Perdito::Server