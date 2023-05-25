# download.rb
# This example access LeadHype with your credentials.

require_relative '../lib/leadhypebot.rb'

l = BlackStack::LocalLogger.new('./login.log')

b = BlackStack::Bots::LeadHype.new('leandro@connectionsphere.com', 'foo-password')

b.login(l)

