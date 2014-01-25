Feature: Users

  Scenario: Creating a new user
       When they POST to "/api/users" with the "user" params:
            | email                 | jamesmay@example.com |
            | phone_number          | 5309136575           |
            | first_name            | James                |
            | last_name             | May                  |
            | password              | foobar               |
            | password_confirmation | foobar               |
       Then they should get a 201 status code
        And the JSON should have 2 keys

  Scenario: Creating new user with invalid data
       When they POST to "/api/users" with the "user" params:
            | email                 | jamesmay@example.com |
            | phone_number          | 5309136575           |
            | first_name            | James                |
            | last_name             | May                  |
            | password              | foobar               |
            | password_confirmation | wrong                |
       Then they should get a 400 status code
        And the JSON should be:
            """
            {
              "errors": {
                        "password_confirmation": [
                          "doesn't match Password"
                        ]
                      },
              "success": false
            }
            """
