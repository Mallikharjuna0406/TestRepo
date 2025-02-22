Feature: To test the updation of Job entry in the application
  Use POST /normal/webapi/update to update job entry in the application

  Background: Create and Initialize base url
    Given url 'http://localhost:9897'

  Scenario: To create the Job Entry in JSON format
    # Create a new job entry
    # Update the entry using PUT request
    # Using jsonpath verify the updation of details in job entry
    Given path '/normal/webapi/add'
    * def getRandomValue = function() {return Math.floor((100)*Math.random());}
    * def id = getRandomValue()
    And request {"jobId": '#(id)',"jobTitle": "Software Engg","jobDescription": "To develop andriod application","experience": ["Google","Apple","Mobile Iron"],"project": [{"projectName": "Movie App","technology": ["Kotlin","SQL Lite","Gradle"]}]}
    And headers { Accept : 'application/json', Content-Type:'application/json'}
    When method post
    Then status 201
    # PUT request
    Given path '/normal/webapi/update'
    And request
      """
      {
          "jobId": '#(id)',
          "jobTitle": "Software Engg",
          "jobDescription": "To develop andriod and web applications",
          "experience": [
              "Google",
              "Apple",
              "Mobile Iron"
          ],
          "project": [
              {
                  "projectName": "Movie App",
                  "technology": [
                      "Kotlin",
                      "SQL Lite",
                      "Gradle"
                  ]
              },
              {
                  "projectName": "Movie App",
                  "technology": [
                      "Kotlin",
                      "SQL Lite",
                      "Gradle"
                  ]
              }     
          ]
      }
      """
    And headers { Accept : 'application/json', Content-Type:'application/json'}
    When method put
    Then status 200
    * def projectArray = karate.jsonPath(response, "$[?(@.jobId== "+id+")].project")
    And print projectArray
    And match projectArray[0] == '#[2]'

  Scenario: To create the Job Entry in JSON format
    # Create a new job entry
    # Update the entry using PUT request
    # Using jsonpath verify the updation of details in job entry
    Given path '/normal/webapi/add'
    * def getRandomValue = function() {return Math.floor((100)*Math.random());}
    * def id = getRandomValue()
    And request {"jobId": '#(getRandomValue())',"jobTitle": "Software Engg","jobDescription": "To develop andriod application","experience": ["Google","Apple","Mobile Iron"],"project": [{"projectName": "Movie App","technology": ["Kotlin","SQL Lite","Gradle"]}]}
    And headers { Accept : 'application/json', Content-Type:'application/json'}
    When method post
    Then status 201
    # PUT request
    Given path '/normal/webapi/update'
    And request
      """
      {
          "jobId": '#(id)',
          "jobTitle": "Software Engg",
          "jobDescription": "To develop andriod and web applications",
          "experience": [
              "Google",
              "Apple",
              "Mobile Iron"
          ],
          "project": [
              {
                  "projectName": "Movie App",
                  "technology": [
                      "Kotlin",
                      "SQL Lite",
                      "Gradle"
                  ]
              },
              {
                  "projectName": "Movie App",
                  "technology": [
                      "Kotlin",
                      "SQL Lite",
                      "Gradle"
                  ]
              }     
          ]
      }
      """
    And headers { Accept : 'application/json', Content-Type:'application/json'}
    When method put
    Then status 404

  Scenario: To create the Job Entry in JSON format by calling another feature file
    # <Gherkin keywor> <call> <read(<location of file>)>
    Given call read("../createJobEntry.feature")
    # PUT request
    Given path '/normal/webapi/update'
    And request
      """
      {
          "jobId": 125,
          "jobTitle": "Software Engg",
          "jobDescription": "To develop andriod and web applications",
          "experience": [
              "Google",
              "Apple",
              "Mobile Iron"
          ],
          "project": [
              {
                  "projectName": "Movie App",
                  "technology": [
                      "Kotlin",
                      "SQL Lite",
                      "Gradle"
                  ]
              },
              {
                  "projectName": "Movie App",
                  "technology": [
                      "Kotlin",
                      "SQL Lite",
                      "Gradle"
                  ]
              }     
          ]
      }
      """
    And headers { Accept : 'application/json', Content-Type:'application/json'}
    When method put
    Then status 200
    * def projectArray = karate.jsonPath(response, "$[?(@.jobId== 125)].project")
    And print projectArray
    And match projectArray[0] == '#[2]'

  Scenario: To create the Job Entry in JSON format by calling another feature file
    # <Gherkin keywor> <call> <read(<location of file>)>
    #Given call read("../createJobEntry.feature")
    * def postRequest = call read("../createJobEntry.feature")
    And print "Calling feature ==>", postRequest.id
    And print "Calling feature ==>", postRequest.getRandomValue()
    # PUT request
    Given path '/normal/webapi/update'
    And request
      """
      {
          "jobId": '#(postRequest.id)',
          "jobTitle": "Software Engg",
          "jobDescription": "To develop andriod and web applications",
          "experience": [
              "Google",
              "Apple",
              "Mobile Iron"
          ],
          "project": [
              {
                  "projectName": "Movie App",
                  "technology": [
                      "Kotlin",
                      "SQL Lite",
                      "Gradle"
                  ]
              },
              {
                  "projectName": "Movie App",
                  "technology": [
                      "Kotlin",
                      "SQL Lite",
                      "Gradle"
                  ]
              }     
          ]
      }
      """
    And headers { Accept : 'application/json', Content-Type:'application/json'}
    When method put
    Then status 200
    * def projectArray = karate.jsonPath(response, "$[?(@.jobId== "+ postRequest.id +")].project")
    And print projectArray
    And match projectArray[0] == '#[2]'

  Scenario: To create the Job Entry in JSON format by calling another feature file with variables
    # <Gherkin keywor> <call> <read(<location of file>)>
    #Given call read("../createJobEntry.feature") {var1:value, var2:value}
    * def getRandomValue = function() {return Math.floor((100)*Math.random());}
    * def id = getRandomValue()
    * def postRequest = call read("../createJobEntryWithVariables.feature") {_url:http://localhost:9897, _path:/normal/webapi/add, _id:'#(id)'}
    # PUT request
    Given path '/normal/webapi/update'
    And request
      """
      {
          "jobId": '#(id)',
          "jobTitle": "Software Engg",
          "jobDescription": "To develop andriod and web applications",
          "experience": [
              "Google",
              "Apple",
              "Mobile Iron"
          ],
          "project": [
              {
                  "projectName": "Movie App",
                  "technology": [
                      "Kotlin",
                      "SQL Lite",
                      "Gradle"
                  ]
              },
              {
                  "projectName": "Movie App",
                  "technology": [
                      "Kotlin",
                      "SQL Lite",
                      "Gradle"
                  ]
              }     
          ]
      }
      """
    And headers { Accept : 'application/json', Content-Type:'application/json'}
    When method put
    Then status 200
    * def projectArray = karate.jsonPath(response, "$[?(@.jobId== "+ id +")].project")
    And print projectArray
    And match projectArray[0] == '#[2]'
