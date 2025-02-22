Feature: To create the Job Entry in the test application
  Helper file for POST /normal/webapi/add

  Scenario: To create the Job Entry with JSON data
    Given url _url
    And path _path
    And print "Helper url ==>", _url
    And print "Helper path ==>", _path
    And print "Helper url ==>", _id
    And request {"jobId": '#(_id)',"jobTitle": "Software Engg","jobDescription": "To develop andriod application","experience": ["Google","Apple","Mobile Iron"],"project": [{"projectName": "Movie App","technology": ["Kotlin","SQL Lite","Gradle"]}]}
    And headers { Accept : 'application/json', Content-Type:'application/json'}
    When method post
    Then status 201
    * def responseJobId = response.jobId
    * def responseJobTitle = response.jobTitle
