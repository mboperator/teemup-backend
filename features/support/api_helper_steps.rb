Given(/^a registered api user$/) do
  @user = FactoryGirl.create(:user, id: 1)
end

When(/^they POST to "(.*?)"$/) do |url|
  page.driver.header('Authorization', 'Token token="token"')
  page.driver.submit :post, url, nil 
end

When(/^they (\w+) to (\/\S*?)$/) do |verb, url|
  page.driver.header('Authorization', 'Token token="token"')
  visit url
end

Then(/^they should get a (\d+) status code$/) do |status_code|
  expect(page.status_code).to eq(status_code.to_i)
end

When(/^they (\w+) to "(.*?)" with the "(.*?)" params:$/) do |verb, path, param_holder, table|
  json = Hash[*table.raw.flatten] 
  page.driver.header('Authorization', 'Token token="token"')
  page.driver.send(verb.downcase, path, { param_holder.to_sym  => json } )
end

When(/^they DELETE to "(.*?)"$/) do |url|
  page.driver.header('Authorization', 'Token token="token"')
  page.driver.submit :delete, url, {}
end

Given(/^they are home$/) do
  visit "/"
end

When(/^the auth token is set to "(.*?)"$/) do |arg1|
  User.first.api_keys.first.update_attributes(access_token: arg1)
end
