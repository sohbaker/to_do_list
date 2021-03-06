ENV['RACK_ENV'] = 'test'

require './todo_controller.rb'
require 'test/unit'
require 'rack/test'

class ToDoListTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_it_says_welcome_to_todo_list
    get '/'
    assert last_response.ok?
    assert last_response.body.include?('WELCOME TO YOUR TO DO LIST')
  end

  def test_it_adds_an_action_to_the_list
    get '/', :add_item => 'test'
    assert last_response.body.include?('test')
  end

  def test_it_will_edit_an_action_in_the_list
    get '/', :find => 'test', :edit => 'passed'
    assert last_response.body.include?('passed')
  end

  def test_it_will_mark_an_action_as_complete
    get '/', :complete => 'passed'
    assert last_response.body.include?('complete')
  end

  def test_it_will_store_more_than_one_action
    get '/', :add_item => 'cuppa'
    assert last_response.body.include?('cuppa')
  end

  def test_filter_by_all_will_display_all_actions_in_list
    get '/', :add_item => 'test', :display_all => 'all'
    assert last_response.body.include?('test')
  end

  def test_filter_by_all_will_display_all_actions_in_list
    get '/', :add_item => 'cuppa', :display_all => 'all'
    assert last_response.body.include?('cuppa')
  end

  def test_filter_by_completed_will_display_only_completed_action
    get '/', :add_item => 'cuppa', :complete => 'cuppa', :display_complete => 'complete'
    assert last_response.body.include?('cuppa')
  end

  def test_filter_by_active_will_display_active_action
    get '/', :add_item => 'biscuits for cuppa', :display_active => 'active'
    assert last_response.body.include?('biscuits for cuppa')
  end
end
