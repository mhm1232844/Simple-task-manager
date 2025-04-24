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


# features/step_definitions/task_steps.rb
# ... (keep previous steps) ...

When("I click {string}") do |link_or_button_text|
  click_on link_or_button_text
end

When("I fill in {string} with {string}") do |field_label, value|
  # Capybara's fill_in works with label text, id, or name
  fill_in field_label, with: value
end

Then("I should be on the tasks page") do
  expect(current_path).to eq(tasks_path)
end

Then("I should be on the new task page") do
  # Check for a unique element on the new task page, like the H1 title or form ID
  expect(page).to have_selector("h1", text: "New task")
  # Or check the URL path (less reliable if POST fails and renders :new on /tasks)
  # expect(current_path).to eq(new_task_path)
end

# Can refine the check for form re-render vs redirect
Then("I should see {string} error message") do |error_message|
   # Assuming Rails renders errors in a standard way, adjust selector if needed
   error_div = find('#error_explanation') # Standard Rails error div ID
   within(error_div) do
     expect(page).to have_content(error_message)
   end
   # Or a simpler check if the structure is consistent
   expect(page).to have_content(error_message)
end

