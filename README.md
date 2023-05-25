![Gem version](https://img.shields.io/gem/v/leadhypebot)![Gem downloads](https://img.shields.io/gem/dt/leadhypebot)

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

Getting the status of the "test" job.

```ruby
p b.sales_navigator_jobs('test').first[:status]
# => "Pending"
```

4. Downloading CSV

If the job 'test' is completed, download its CSV as "/tmp/text.csv"

```ruby
status = b.sales_navigator_jobs('test').first[:status]
b.download('test') if status == BlackStack::Bots::LeadHype::STATUS_COMPLETED
```

## 2. Log Tracking

This [LeadHypeBot]() is integrated with [Simple Cloud Login](https://github.com/leandrosardi/simple_cloud_logging), for tracking all methods internal activity.

```ruby
l = BlackStack::LocalLogger.new('./test.log')
b.submit(job_name, sales_navigator_url, l)
```

## 3. Getting Pending Jobs

```ruby
p b.pending_jobs.size
# => 1
```

## 4. Getting Error Jobs

```ruby
p b.error_jobs.size
# => 0
```

## 5. Getting Jobs with Custom Filters

```ruby
l = BlackStack::LocalLogger.new('./test.log')
page = 1
status = BlackStack::Bots::LeadHypeBot::STATUS_PENDING
b.sales_navigator_jobs('test', status, page, l)
```

## 6. Managing Pagination

Method `sales_navigator_jobs` is not managing pagination yet.

## Disclaimer

Use this gem at your own risk.