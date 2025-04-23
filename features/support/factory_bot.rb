        # features/support/factory_bot.rb
        require 'factory_bot_rails'

        # Include FactoryBot methods (build, create, etc.) into the Cucumber World
        World(FactoryBot::Syntax::Methods)