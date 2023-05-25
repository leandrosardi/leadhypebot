# download.rb
# This example access LeadHype and download the CSV of a given job into the /tmp folder.

require_relative '../lib/leadhypebot.rb'

l = BlackStack::LocalLogger.new('./submit.log')

b = BlackStack::Bots::LeadHype.new('leandro@connectionsphere.com', 'foo-password')

b.login(l)

b.submit(
    '252be07d-70f9-4477-ae07-9a2b1b583602', 
    'https://www.linkedin.com/sales/search/people?query=(filters:List((type:TITLE,values:List((text%3Aowner%2CselectionType%3AINCLUDED),(text%3Afounder%2CselectionType%3AINCLUDED),(text%3Aceo%2CselectionType%3AINCLUDED)),selectedSubFilter:CURRENT),(type:CURRENT_TITLE,values:List((text%3Aowner%2CselectionType%3AINCLUDED),(text%3Afounder%2CselectionType%3AINCLUDED),(text%3Aceo%2CselectionType%3AINCLUDED))),(type:REGION,values:List((id:103644278,text:United%20States,selectionType:INCLUDED)))),keywords:%22online%20coach%22%20OR%20%22consultant%22)&viewAllFilters=true', 
    l
)

i = 60
while i < 120
    l.logs "submitting #{i}... "
    b.submit(
        "test-#{i}", 
        'https://www.linkedin.com/sales/search/people?query=(filters:List((type:TITLE,values:List((text%3Aowner%2CselectionType%3AINCLUDED),(text%3Afounder%2CselectionType%3AINCLUDED),(text%3Aceo%2CselectionType%3AINCLUDED)),selectedSubFilter:CURRENT),(type:CURRENT_TITLE,values:List((text%3Aowner%2CselectionType%3AINCLUDED),(text%3Afounder%2CselectionType%3AINCLUDED),(text%3Aceo%2CselectionType%3AINCLUDED))),(type:REGION,values:List((id:103644278,text:United%20States,selectionType:INCLUDED)))),keywords:%22online%20coach%22%20OR%20%22consultant%22)&viewAllFilters=true', 
        l
    )
    l.done
    i += 1
end
