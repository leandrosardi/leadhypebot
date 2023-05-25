require 'blackstack-core'
require 'blackstack-deployer'
require 'simple_command_line_parser'
require 'simple_cloud_logging'
require 'mechanize'
require 'colorize'
require 'pry'

module BlackStack
    module Bots
        class LeadHype
            attr_accessor :email, :password, :agent

            NINJA_SALES_NAVIGATOR = "Sales Navigator"

            STATUS_ALL = 'All'
            STATUS_COMPLETED = 'Completed'
            STATUS_RUNNING = 'Running'
            STATUS_ERROR = 'Error'
            STATUS_PENDING = 'Pending'

            # constructor
            def initialize(init_email, init_password)
                self.email = init_email
                self.password = init_password
                self.agent = Mechanize.new
            end

            # login to LeadHype.
            # this method is for internal use only. End users should not call this method.
            def login(l=nil)
                l = BlackStack::DummyLogger.new(nil) if l.nil?

                # visit LeadHype login page
                l.logs "visiting LeadHype login page... "
                page = self.agent.get('https://tool.leadhype.com')
                l.done

                # get the form with id='login_form'
                l.logs "getting login form... "
                form = page.form_with(:id => 'login_form')
                l.done

                # getting the text-field with name='email'
                l.logs "getting email field... "
                form.field_with(:name => 'email').value = email
                l.done

                # getting the text-field with name='password'
                l.logs "getting password field... "
                form.field_with(:name => 'password').value = password
                l.done

                # getting the button with name='login'
                l.logs "getting login button... "
                button = form.button_with(:name => 'login')
                l.done

                # click the button
                l.logs "clicking login button... "
                page = agent.submit(form, button)
                l.done

                # getting the pagetitle to check I logged into successfully
                l.logs "checking login... "
                title = page.title
                if title == 'Membership Dashboard'
                    l.logf 'success'.green
                else
                    l.logf 'failed'.red
                    raise 'login failed'
                end

                # return the agent
                #agent
            end # def login

            def submit(job_name, sales_navigator_url, l=nil)
                l = BlackStack::DummyLogger.new(nil) if l.nil?
                url = 'https://tool.leadhype.com/dashboard/'

                # visit LeadHype history page
                l.logs "visiting LeadHype dashboard page... "
                page = self.agent.get(url)
                l.done

                # send a post request from this page to https://tool.leadhype.com/view/front/controller.php
                l.logs "sending post request... "
                page = self.agent.post('https://tool.leadhype.com/view/front/controller.php', {
                    'mode' => '16',
                    'keyword' => job_name,
                    'location' => sales_navigator_url,
                    'keyword_beta_dropdown' => '',
                    'locations' => '',
                    'account' => '',
                    'titles' => '',
                    'isautosalesnavjob' => 'on',
                    'action' => 'addJob'
                })
                l.done
                
                # validate response
                l.logs "validating response... "
                h = JSON.parse(page.content)
                if h['type'] == 'success'
                    l.logf 'success'.green
                else
                    l.logf 'failed'.red
                    raise 'failed to submit job'
                end
            end # def submit

            # getting SalesNavigator jobs from LeadHype.
            def sales_navigator_jobs(search=nil, status=nil, page=1, l=nil)
                ret = []
                l = BlackStack::DummyLogger.new(nil) if l.nil?
                url = 'https://tool.leadhype.com/dashboard/history/?'

                # apply filters
                url += "search=#{CGI.escape(search.to_s)}&"
                url += "status=#{CGI.escape(status)}&" unless status.nil?

                # visit LeadHype history page
                l.logs "visiting LeadHype history page... "
                page = self.agent.get(url)
                l.done

                # checking page title
                l.logs "checking page title... "
                title = page.title
                if title == 'Jobs'
                    l.logf 'success'.green
                else
                    l.logf 'failed'.red
                    raise 'failed to get history page'
                end

                # getting the first table
                l.logs "getting first table... "
                table = page.search('table').first
                l.done

                # no results = no table
                return ret if table.nil?

                # getting the rows into the table
                l.logs "getting rows into the table... "
                rows = table.search('tr')
                l.done

                # iterating from the second row (the frist one is the header)
                i = 1
                while i < rows.length
                    # getting the row
                    row = rows[i]
                    # getting cells
                    tds = row.search('td')
                    # build the hash descriptor
                    job = {}
                    job[:ninja] = tds[2].text.strip 
                    job[:parameter] = tds[3].text.strip
                    job[:status] = tds[5].text.strip
                    job[:id] = tds[6].search('a').first['href'] 
                    job[:link] = "https://tool.leadhype.com/view/front/controller.php?getResult&id=#{job[:id]}&filename=#{CGI.escape(job[:parameter])}"
                    ret << job if job[:ninja] == NINJA_SALES_NAVIGATOR
                    # hop to the next row
                    i += 1
                end # while

                # return 
                ret
            end

            # return array of pending jobs
            def pending_jobs(page=1, l=nil)
                self.sales_navigator_jobs(nil, STATUS_PENDING, page, l)
            end

            # return array of pending jobs
            def error_jobs(page=1, l=nil)
                self.sales_navigator_jobs(nil, STATUS_ERROR, page, l)
            end

            # download the CSV of a given job with the parameter `s` into the file "/tmp/#{s}.csv"
            def download(s, l=nil)
                l = BlackStack::DummyLogger.new(nil) if l.nil?
                
                # jobs
                jobs = self.sales_navigator_jobs(s, nil, 1, l)

                # validate: must find no more than 1 job
                raise 'More than 1 job found' if jobs.length > 1

                # validate: must find 1 job
                raise 'Job not found' if jobs.length == 0

                # download the file
                l.logs "downloading the file... "
                page = self.agent.get(jobs[0][:link])
                l.done

                # save the file
                l.logs "saving the file... "
                f = File.open("/tmp/#{s}.csv", 'w')
                f.write(page.content)
                f.close
                l.done
            end # def download



        end # class LeadHype
    end # module Bots
end