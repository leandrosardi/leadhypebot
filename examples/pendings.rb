# download.rb
# This example access LeadHype and checks the number of pending jobs.

require_relative '../lib/leadhypebot.rb'

l = BlackStack::LocalLogger.new('./pendings.log')

b = BlackStack::Bots::LeadHype.new('leandro@connectionsphere.com', 'foo-password')

b.login(l)

l.logs 'pending jobs... '
l.logf b.pending_jobs.size.to_s

