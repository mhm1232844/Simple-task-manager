# features/manage_tasks.feature
    Feature: Manage Tasks
      As a user
      I want to create, view, update, and delete tasks
      So that I can effectively manage my workload

      Background:
        Given I am on the tasks page

      Scenario: Viewing the list of tasks when none exist
        Then I should see "Tasks"
        And I should see "New task" # Link to create new tasks
        # Check specifically within the tasks container for absence of task items
        And I should not see ".task-item" within "#tasks"

      Scenario: Viewing the list of existing tasks
        Given the following tasks exist:
          | title         | description         | due_date   | completed |
          | Buy Groceries | Milk, Eggs, Bread   | 2024-12-20 | false     |
          | Finish Report | Complete mini project | 2024-12-18 | true      |
        When I visit the tasks page
        Then I should see "Buy Groceries"
        And I should see "Milk, Eggs, Bread"
        And I should see "Status: Incomplete" within the "Buy Groceries" task item
        And I should see "Finish Report"
        And I should see "Status: Complete" within the "Finish Report" task item
        And the "Finish Report" task item should have class "completed"

      # --- Add other scenarios for Add/Edit/Delete later ---