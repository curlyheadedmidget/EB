# Setup
```
git clone git@orahub.oraclecorp.com:compendium/selenium-ruby.git
cd selenium-ruby
bundle install
```

# run full stack:
```
rake selenium:all
```

# run suite:
```
rake selenium:calendar

rake selenium:create_content

rake selenium:file_upload

rake selenium:language

rake selenium:project

rake selenium:repurpose_content
```

## Suites:

- :best_practice
- :calendar
- :create_content
- :create_expiring_content
- :delete_content
- :keyword_suggestion
- :language
- :moderate_content
- :navigation
- :persona
- :project
- :repurpose_content
- :sign_in_out
- :social_share
- :translate_content


## run individual test:
```
ruby tests/content/create_content.rb --name test_create_file_content_admin

ruby tests/content/create_content.rb --name test_create_idea_admin

ruby tests/content/repurpose_content.rb --name test_repurpose_content_image_admin

ruby tests/navigation.rb --name test_settings_license
```

# Clean Up
```
rake clear_data:all
```

## Other options:

- :best_practice
- :calendar
- :content
- :keyword_suggestion
- :language
- :persona
- :project


# Environment Options

BROWSER=chrome *, firefox, chrome-remote, firefox-remote

TARGET_URL=https://app.compendium.com *, https://dev.cpdm.oraclecorp.com, https://app.test-cpdm.oraclecorp.com

SELENIUM_PROXY - if a runner is behind a proxy

TIMEOUT - Timeout for selenium executions.  Looking for element, etc. Default is 30 seconds.

HTTPARTY_TIMEOUT - Timeout for Cleanup and setup requests.  Default is 30 seconds.

(* default)


# Setup for Chrome:

Copy chromedriver to /usr/local/bin

The Following scripts will put the results of the tests in a results directory:

# Scripts

## Script to run all tests:
```
./runall.sh
```
```
./runall.sh -t 'http://app.test-cpdm.oraclecorp.com' -b 'remote-firefox'
```

## Script to run Random Test Suite: This will choose a random remote Browser option and a random test suite and run it.
```
./random.sh
```
```
./random.sh -t 'http://app.test-cpdm.oraclecorp.com' -d 'true'
```
```
-b :: Browser
-t :: Target Url
-d :: Debug
```

# Examples:
```
BROWSER=firefox rake selenium:all

BROWSER=chrome-remote rake selenium:all

TARGET_ENV=prod rake selenium:all

TARGET_ENV=den3 rake selenium:all

TARGET_ENV=dev rake selenium:all

TARGET_URL=https://dev.cpdm.oraclecorp.com BROWSER=chrome ruby tests/moderate_content.rb --name test_moderate_content_workflow

TARGET_URL=https://dev.cpdm.oraclecorp.com BROWSER=chrome ruby tests/create_content.rb --name test_create_content_admin

TARGET_URL=https://dev.cpdm.oraclecorp.com BROWSER=chrome ruby tests/navigation.rb --name test_promote_navigation

BROWSER=firefox ruby tests/create_content.rb --name test_create_image_content_user
```


# env.rb
To get added to root dir to set usernames and keys


```ruby
ENV["CPDM_USER_USERNAME"] = "username"
ENV["CPDM_USER_PASSWORD"] = "selenium"
ENV["CPDM_USER_KEY"] = "api key"
ENV["CPDM_ADMIN_USERNAME"] = "username"
ENV["CPDM_ADMIN_PASSWORD"] = "selenium"
ENV["CPDM_ADMIN_KEY"] = "api key"
ENV["CPDM_ROOT_USERNAME"] = "username"
ENV["CPDM_ROOT_PASSWORD"] = "selenium"
ENV["CPDM_ROOT_KEY"] = "api key"
SUGGESTIONS = ['Add a video','Get on Balmer\'s level','Add an Image','Add 500 words','Use an unordered list', 'Use an ordered list']
ENV["CONTENT_TYPE_ID"] = '490e96f6-4a90-44c7-ac81-9259d331dddb'
ENV["TWITTER"] = "signldapp,tlam1970"
ENV["FACEBOOK"] = "P Art Ygo Rilla"
ENV["LINKEDIN"] = "Thomas Lambert"
ENV['TARGET_URL'] = "https://dev.cpdm.oraclecorp.com"
```


# Other Notes:

## To run on master-cooler remotely you need to specify a DISPLAY:
```
DISPLAY=:0 bundle exec rake selenium:navigation
```
