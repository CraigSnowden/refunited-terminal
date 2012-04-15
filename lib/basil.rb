require 'forwardable'
require 'basil/config'
require 'basil/storage'
require 'basil/utils'
require 'basil/email'
require 'basil/chat_history'
require 'basil/plugins'
require 'basil/servers/cli'
require 'basil/servers/skype'

module Basil
  class << self
    extend Forwardable

    def_delegator Basil::Plugin, :respond_to
    def_delegator Basil::Plugin, :watch_for
    def_delegator Basil::Plugin, :check_email
  end

  # Main program entry point. Loads plugins, instantiates your defined
  # server, and calls its run method which should loop forever.
  def self.run
    Plugin.load!
    server = Config.server
    server.run
  rescue Exception => e
    $stderr.puts e.message
    exit 1
  end

  # Basil's dipatch method will take a valid message and ask each
  # registered plugin (responders then watchers) if it wishes to act on
  # it. The first reply received is returned, otherwise nil.
  def self.dispatch(msg)
    return nil unless msg && msg.text != ''

    if msg.to_me?
      Plugin.responders.each do |p|
        reply = p.triggered(msg)
        return reply if reply
      end
    end

    Plugin.watchers.each do |p|
      reply = p.triggered(msg)
      return reply if reply
    end

    nil
  end

  # The main basil data type: the Message. Servers should construct
  # these and pass them through dispatch which will also return a
  # Message if a response is triggered.
  class Message
    include Basil

    attr_reader :to, :from, :from_name, :time, :text, :chat

    def initialize(to, from, from_name, text, chat = nil)
      @time = Time.now
      @chat, @to, @from, @from_name, @text = chat, to, from, from_name, text
    end

    # Is this message to my configured nick?
    def to_me?
      to.downcase == Config.me.downcase
    rescue
      false
    end
  end
end
