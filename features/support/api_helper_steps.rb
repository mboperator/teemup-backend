Given(/^a registered api user$/) do
  @user = FactoryGirl.create(:user, id: 1)
end

When(/^they (\w+) to (\/\S*?)$/) do |verb, url|
  page.driver.header('Authorization', 'Token token="token"')
  visit url
end

Then(/^they should get a (\d+) status code$/) do |status_code|
  expect(page.status_code).to eq(status_code.to_i)
end

When(/^they POST to "(.*?)" with the "(.*?)" params:$/) do |path, param_holder, table|
  json = Hash[*table.raw.flatten] 
  page.driver.post(path, { param_holder.to_sym  => json } )
end

