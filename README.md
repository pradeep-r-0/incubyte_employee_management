# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

1) created new project using rails new incubyte
2) Scafollded Employee using this command
  rails generate scaffold Employee \
 full_name:string \
  job_title:string \
   country:string \
  salary:decimal
3) Migrated using rails db:migrate

4) To view all Employees
    http://localhost:3000/employees.json
5) Create Employee request
   postman request POST 'http://localhost:3000/employees.json' \
  --header 'Content-Type: application/json' \
  --header 'Cookie: _incubyte_session=sOG%2BbcaQD1Su%2BLlsTFoc2r0FD9XrkWOFBKoyRpWIoIhkv7kjN0P%2BcQt7UQjeuaPaJemYkHc%2BYip8gCAEXEcObgqsYRMyynOT1zFGoKFtVn303EIDDEJehDpkMDHybS3YtQI%2BkHLTZgHTTSJoL66bHTKHqRpZeUbaUE6%2BX0USAayfDzZk6yX44skKuJ%2B43dnpFg2VFBQIM4yXbVb5pSRStaX6tbGprJxDiXL0P9JosjnxSo7EuMNJW3BO%2F60R4OJtIIjVnS6207vxqTHoTgkeC9i8CbzHkEzIZA%3D%3D--FvTw%2F5OHWtHGaztP--uw072ZWp%2BWDa%2BHOShT2t5w%3D%3D' \
  --body '{
  "employee": {
    "full_name": "Pradeep",
    "country": "India",
    "job_title": "SDE",
    "salary": 250000
  }
}
'
6) Delete request for employee
  postman request DELETE 'http://localhost:3000/employees/1' \
  --header 'Content-Type: application/json' \
  --header 'Cookie: _incubyte_session=sOG%2BbcaQD1Su%2BLlsTFoc2r0FD9XrkWOFBKoyRpWIoIhkv7kjN0P%2BcQt7UQjeuaPaJemYkHc%2BYip8gCAEXEcObgqsYRMyynOT1zFGoKFtVn303EIDDEJehDpkMDHybS3YtQI%2BkHLTZgHTTSJoL66bHTKHqRpZeUbaUE6%2BX0USAayfDzZk6yX44skKuJ%2B43dnpFg2VFBQIM4yXbVb5pSRStaX6tbGprJxDiXL0P9JosjnxSo7EuMNJW3BO%2F60R4OJtIIjVnS6207vxqTHoTgkeC9i8CbzHkEzIZA%3D%3D--FvTw%2F5OHWtHGaztP--uw072ZWp%2BWDa%2BHOShT2t5w%3D%3D' \
7) Patch (partial Update) request for employee
  postman request PATCH 'http://localhost:3000/employees/2.json' \
  --header 'Content-Type: application/json' \
  --header 'Cookie: _incubyte_session=V2Ojx75lSbMgluzr8YR%2BsLeYjqT5Bb5PYBQqLaFr8wKBnXnGGpp9Y6NBZ5VL1VJ02yje6z0fdPb9oIkpPHr9LzyGuVzBPg%2FN0ffqAAAmVsiyjTOmsukRwaLKRyKn215vM0tELfZTovPy40oPrPaUc%2FWeGOMZBFmkiH%2BP3v65ZQ1%2FTGduYYVUYfZMzRGMAI59Te4cThFcw2Xh20l9VwXUqvCRmyEsdbkNalpjJB%2BJ33WKDqDL87OjqsoSD%2Bddrd9folLg2zrTZiXBWFXQNrrfUNztdhmxFOL4jQ%3D%3D--JQdL%2FGG6whZJW8dM--cWaK5HJPZaSmOFNR5KhUBQ%3D%3D' \
  --body '{
  "employee": {
    "full_name": "Pradeep Repudi"
  }
}
'
8) For calculate_net_salary, created a member route for employee
  resources :employees do
    member do
      get :calculate_net_salary
    end
  end

9) Added 2 collection routes
    collection do
      get :min_max_salary_in_country
      get :avg_salary_by_job_title
    end
    and implemented the methods in the controller.

    9-a: Request to get min_max_salary_in_country
        postman request 'http://localhost:3000/employees/min_max_salary_in_country.json' \
      --header 'Content-Type: application/json' \
      --header 'Cookie: _incubyte_session=viNWj9BoRGyFkj%2B3vUjflsxFlCKIQ2KWRhlI0ox3Bj6EZ2pXJWXTVOu2YaE3OhVlThAavp1JxhDWO5GzBUZ%2FzHcSFaitwk5%2BMlBbriQHEpOXQv54TFQqyI3cplRqlOMSo1tCWimxdDk%2FemAie1Zz8TXuHiZ%2BKLpSrUtnMlh0SzwyNCzZQzOyb1d4ZonfBFfZOdcViJ8R6Sr1hSu7q6XY3pEmq7KYaog4grJU04NuzOaQFJhOwcMzGz%2BFPf9E%2BA4YTfI6ozOSUvzVGpDM%2BQqR6FCLNGVX26uByw%3D%3D--mCZwCe7op5QFqpdR--8%2BrMJYCQ%2Ffms69Y6%2F70Iyg%3D%3D' \
      --body '{

        "country": "India"
    }
    '
    9-b: Request to get avg_salary_by_job_title
        postman request 'http://localhost:3000/employees/avg_salary_by_job_title.json' \
        --header 'Content-Type: application/json' \
        --header 'Cookie: _incubyte_session=viNWj9BoRGyFkj%2B3vUjflsxFlCKIQ2KWRhlI0ox3Bj6EZ2pXJWXTVOu2YaE3OhVlThAavp1JxhDWO5GzBUZ%2FzHcSFaitwk5%2BMlBbriQHEpOXQv54TFQqyI3cplRqlOMSo1tCWimxdDk%2FemAie1Zz8TXuHiZ%2BKLpSrUtnMlh0SzwyNCzZQzOyb1d4ZonfBFfZOdcViJ8R6Sr1hSu7q6XY3pEmq7KYaog4grJU04NuzOaQFJhOwcMzGz%2BFPf9E%2BA4YTfI6ozOSUvzVGpDM%2BQqR6FCLNGVX26uByw%3D%3D--mCZwCe7op5QFqpdR--8%2BrMJYCQ%2Ffms69Y6%2F70Iyg%3D%3D' \
        --body '{

          "job_title": "SDE"
      }
      '
10) Included tests in employees_controller_test