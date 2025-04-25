# Simple Task Manager – A SaaS App (Mini Project)

**Objective:** Build a cloud-ready Ruby on Rails SaaS application for managing personal or team tasks, while applying Agile development practices like Scrum, TDD, BDD, and Continuous Deployment basics.

**Project Description:** A minimal task management app where users can:
*   Add a new task (title, description, due date)
*   View all tasks on the homepage, ordered by creation date (newest first).
*   Mark tasks as complete/incomplete (toggle status) via a button on the index page.
*   Edit task details (title, description, due date, completed status).
*   Delete tasks with a confirmation prompt.

**Technology Stack:**
*   Ruby on Rails `[e.g., 7.0.8]`
*   Ruby `[e.g., 3.2.2]`
*   Database: PostgreSQL (Production/Heroku), SQLite (Development/Test)
*   Testing:
    *   RSpec / RSpec-Rails (`~> 6.x`) - Unit/Integration Tests
    *   Cucumber / Cucumber-Rails - Acceptance Tests (BDD)
    *   Capybara / Selenium WebDriver - Browser simulation for Cucumber
    *   FactoryBot / Faker - Test Data Generation
    *   Shoulda Matchers (`~> 5.x`) - Concise RSpec matchers
    *   Database Cleaner - Test database state management
    *   Rails Controller Testing - For `render_template` matchers
*   Version Control: Git / GitHub
*   Web Server: Puma
*   Frontend: Importmap-rails, Turbo-rails, Stimulus-rails (default Rails 7+)
*   Deployment (Optional): Heroku

**Features Implemented:**
*   Full Task CRUD (Create, Read, Update, Delete) operations.
*   Toggle task completion status directly from the index page using a PATCH request.
*   Root path (`/`) displays the task list.
*   Forms for creating and editing tasks with server-side validations (title presence).
*   User feedback via Rails flash messages (`notice`, `alert`).
*   Basic styling for task display and completion status.
*   Database migrations with constraints (`null: false`).
*   Use of `button_to` for actions requiring non-GET requests (Toggle, Delete).
*   JavaScript confirmation (`turbo_confirm`) for deletion.
*   Graceful handling of `RecordNotFound` errors (redirect with alert).

**Agile Practices / Scrum Artifacts:**
*   User stories tracked as GitHub Issues: [Link to your GitHub Issues page]
*   (Optional) GitHub Project Board: [Link to your GitHub Project board, if used]
*   Development followed TDD/BDD cycles for each feature (Cucumber -> RSpec -> Implementation).
*   Commit messages reference corresponding issues (e.g., `(closes #X)`).

**Setup Instructions:**
1.  Clone the repository: `git clone <your-repo-url>`
2.  Navigate to the directory: `cd simple-task-manager`
3.  Install dependencies: `bundle install`
4.  Setup the database: `rails db:setup` (This runs `db:create`, `db:schema:load`, `db:seed` if seeds exist)
    *   Alternatively: `rails db:create && rails db:migrate`
5.  Run the tests (see **Testing** section below).
6.  Start the Rails server: `rails server` or `./bin/dev` (if using Procfile.dev)
7.  Open your browser to `http://localhost:3000`

**Testing:**
*   **RSpec (Unit/Integration):** Run `bundle exec rspec`. covers model validations /methods and request specs for controller actions located in 'spec/'
*   **Cucumber (Acceptance):** Run `bundle exec cucumber`. Features cover main user flows (viewing, adding, editing, toggling status, deleting tasks) from a user's perspective. Located in `features/`.
*   **Run all tests:** You might configure a default `rake` task or run them sequentially: `bundle exec rspec && bundle exec cucumber`.

**Deployment:**
Soon

**Author:**
*  mhm1232844
