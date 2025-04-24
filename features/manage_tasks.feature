# features/manage_tasks.feature
    Feature: Manage Tasks
      As a user
      I want to create, view, update, and delete tasks
      So that I can effectively manage my workload

      Background:
        Given I am on the tasks page

      Scenario: Viewing the list of tasks when none exist
        Then I should see "Tasks"
        And I should see "New task"
 # Link to create new tasks
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

# features/manage_tasks.feature
# ... (keep previous feature/background/scenarios) ...

  Scenario: Adding a valid new task
    When I click "New task"
    Then I should be on the new task page
 # Check we landed on the form page
    When I fill in "Title" with "Schedule meeting"
    And I fill in "Description" with "Meeting with the team about Q1 goals"
    And I fill in "Due date" with "2024-11-30"
    And I click "Create Task"
 # Button text from the form
    Then I should be on the tasks page
    And I should see "Task was successfully created." 
# Flash notice
    And I should see "Schedule meeting"
    And I should see "Meeting with the team about Q1 goals"
    And I should see "Status: Incomplete" within the "Schedule meeting" task item

  Scenario: Adding an invalid task (missing title)
    When I click "New task"
    Then I should be on the new task page
    When I fill in "Description" with "This task is missing a title"
    And I click "Create Task"
    Then I should see "Title can't be blank" 
# Validation error message
    # Check that we are still on the form page (re-rendered)
    And I should see "New task" 
# Heading of the new task form
    And I should not see "Task was successfully created."
 # No success flash


# features/manage_tasks.feature
# ... (keep previous scenarios) ...

  Scenario: Marking an incomplete task as complete
    Given a task exists with title "Task to Complete" and completed status "false"
    When I am on the tasks page 
# Ensure we start from the list
    And I find the task "Task to Complete" and click "Toggle Status"
 # Using button text
    Then I should see "Task status updated."
 # Flash notice
    And I should be on the tasks page
 # Still on the list page
    And I should see "Status: Complete" within the "Task to Complete" task item
    And the "Task to Complete" task item should have class "completed"

  Scenario: Marking a completed task as incomplete
    Given a task exists with title "Task to Uncomplete" and completed status "true"
    When I am on the tasks page
    And I find the task "Task to Uncomplete" and click "Toggle Status"
    Then I should see "Task status updated."
    And I should be on the tasks page
    And I should see "Status: Incomplete" within the "Task to Uncomplete" task item
    And the "Task to Uncomplete" task item should not have class "completed"









