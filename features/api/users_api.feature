Feature: Users

  Scenario: Creating a new user
       When they POST to "/api/users" with the "user" params:
            | email                 | jamesmay@example.com |
            | phone_number          | 1234567891           |
            | first_name            | James                |
            | last_name             | May                  |
            | password              | foobar               |
            | password_confirmation | foobar               |
       Then they should get a 201 status code
        And the JSON should have 2 keys

  Scenario: Creating new user with invalid data
       When they POST to "/api/users" with the "user" params:
            | email                 | jamesmay@example.com |
            | phone_number          | 1234567891           |
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
             
  Scenario: Getting a User
      Given a registered api user
       When they GET to /api/users/1
       Then they should get a 200 status code
        And the JSON should be:
            """
            {
                "user": {
                    "id": 1,
                    "full_name": "John Doe",
                    "email": "johndoe@example.com",
                    "phone_number": "5551234567"
                }
            }
            """

  Scenario: Updating a User
      Given a registered api user
       When they PUT to "/api/users/1" with the "user" params:
            | email        | richardhammond@example.com |
            | phone_number | 1112223333                 |
            | first_name   | Richard                    |
       Then they should get a 202 status code
        And the JSON should be:
            """
            {
                "success": true
            }
            """
