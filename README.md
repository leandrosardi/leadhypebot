# leadhypebot

Ruby bot for automating opearions on LeadHype Scraper

## 1. Getting Started

1. Install **LeadHypeBot** gem.

```bash
gem install leadhypebot
```

2. Submit a new Sales Navijator job

```ruby
require "leadhypebot"

job_name = "test" 

sales_navigator_url = "https://www.linkedin.com/sales/search/people?query=(filters:List((type:TITLE,values:List((text%3Aowner%2CselectionType%3AINCLUDED),(text%3Afounder%2CselectionType%3AINCLUDED),(text%3Aceo%2CselectionType%3AINCLUDED)),selectedSubFilter:CURRENT),(type:CURRENT_TITLE,values:List((text%3Aowner%2CselectionType%3AINCLUDED),(text%3Afounder%2CselectionType%3AINCLUDED),(text%3Aceo%2CselectionType%3AINCLUDED))),(type:REGION,values:List((id:103644278,text:United%20States,selectionType:INCLUDED)))),keywords:%22online%20coach%22%20OR%20%22consultant%22)&viewAllFilters=true"

b = BlackStack::Bots::LeadHype.new("leandro@connectionsphere.com", "foo-password")

b.login

b.submit(job_name, sales_navigator_url)
```

3. Checking job status

```ruby
```

4. Downloading CSV

```ruby
```

## 2. Log Tracking

## 3. Getting Pending Jobs

## 4. Getting Error Jobs

## 5. Getting Jobs with Custom Filters