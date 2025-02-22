@ignore
Feature: To validate the GET End point
  To validate the GET End point response

  Background: Setup the base url
    Given url 'http://localhost:9897'

  Scenario: To get the  data in JSON format
    Given path '/normal/webapi/all'
    And header Accept = 'application/json'
    When method get
    Then status 200
    And print response
    And match response ==
      """
      [
      {
        "jobId": 1,
        "jobTitle": "Software Engg",
        "jobDescription": "To develop andriod application",
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
            }
        ]
      }
      ]
      """

  Scenario: To get the  data in JSON format
    Given path '/normal/webapi/all'
    And header Accept = 'application/xml'
    When method get
    Then status 200
    And print response
    And match response ==
      """
      <List>
      <item>
        <jobId>1</jobId>
        <jobTitle>Software Engg</jobTitle>
        <jobDescription>To develop andriod application</jobDescription>
        <experience>
            <experience>Google</experience>
            <experience>Apple</experience>
            <experience>Mobile Iron</experience>
        </experience>
        <project>
            <project>
                <projectName>Movie App</projectName>
                <technology>
                    <technology>Kotlin</technology>
                    <technology>SQL Lite</technology>
                    <technology>Gradle</technology>
                </technology>
            </project>
        </project>
      </item>
      </List>
      """

  Scenario: To get the  data in JSON format using negate condition
    Given path '/normal/webapi/all'
    And header Accept = 'application/json'
    When method get
    Then status 200
    And print response
    And match response !=
      """
      [
      {
        "jobId": 1,
        "jobTitle": "Software Engg",
        "jobDescription": "To develop andriod application",
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
            }
        ]
      }
      ]
      """

  Scenario: To get the  data in JSON format and validate a specific property
    Given path '/normal/webapi/all'
    And header Accept = 'application/json'
    When method get
    Then status 200
    And print response
    And match response contains deep {"experience":"Google"}
    And match response contains deep {"project":[{"projectName":"Movie App"}]}
    And match header Content-Type == 'application/json'
    And match header Connection == 'keep-alive'
