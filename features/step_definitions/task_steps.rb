# features/step_definitions/task_steps.rb
Given("I am on the tasks page") do
  visit tasks_path # This will be our root path
end

Given("no tasks exist") do
  Task.destroy_all # Ensure a clean slate if needed
end

Given("the following tasks exist:") do |table|
  table.hashes.each do |task_attributes|
    # Convert string 'true'/'false' to boolean
    task_attributes['completed'] = task_attributes['completed'] == 'true'
    # Use FactoryBot to create tasks with specific attributes
    FactoryBot.create(:task, task_attributes)
  end
end

When("I visit the tasks page") do
  visit tasks_path
end

Then("I should see {string}") do |content|
  expect(page).to have_content(content)
end

Then("I should not see {string}") do |content|
  expect(page).not_to have_content(content)
end

# More specific step using a CSS selector within a scope
Then("I should not see {string} within {string}") do |selector, scope_selector|
  within(scope_selector) do
    expect(page).not_to have_css(selector)
  end
end

# Step to check content within a specific task item identified by title
Then("I should see {string} within the {string} task item") do |expected_text, task_title|
  # Find the div containing the task title (adjust selector if needed)
  task_div = find('.task-item', text: /#{Regexp.escape(task_title)}/)
  within(task_div) do
    expect(page).to have_content(expected_text)
  end
end

# Step to check for a CSS class on a specific task item
Then("the {string} task item should have class {string}") do |task_title, css_class|
  task_div = find('.task-item', text: /#{Regexp.escape(task_title)}/)
  expect(task_div[:class]).to include(css_class)
end

# Step to check for the absence of a CSS class on a specific task item
Then("the {string} task item should not have class {string}") do |task_title, css_class|
   task_div = find('.task-item', text: /#{Regexp.escape(task_title)}/)
   expect(task_div[:class]).not_to include(css_class)
end