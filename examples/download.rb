# download.rb
# This example access LeadHype and download the CSV of a given job into the /tmp folder.

require_relative '../lib/leadhypebot.rb'

l = BlackStack::LocalLogger.new('./download.log')

b = BlackStack::Bots::LeadHype.new('leandro@connectionsphere.com', 'foo-password')

b.login(l)

b.download('b3f2b156-c53a-4aea-8644-bffbb4c760b9', l)

