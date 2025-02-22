# @<user-define-keyword>
@Confidence
Feature: To create the Job entry in the application
  Use POST /normal/webapi/add to create job entry in the application

  Background: Create and Initialize base url
    Given url 'http://localhost:9897'

  Scenario: To create the Job Entry in JSON format
    Given path '/normal/webapi/add'
    And request {"jobId": 2,"jobTitle": "Software Engg","jobDescription": "To develop andriod application","experience": ["Google","Apple","Mobile Iron"],"project": [{"projectName": "Movie App","technology": ["Kotlin","SQL Lite","Gradle"]}]}
    And headers { Accept : 'application/json', Content-Type:'application/json'}
    When method post
    Then status 201
    And print response
    And match response.jobTitle == "Software Engg"

  Scenario: To create the Job Entry using XML request body format
    Given path '/normal/webapi/add'
    And request <item><jobId>1</jobId><jobTitle>Software Engg</jobTitle><jobDescription>To develop andriod application</jobDescription><experience><experience>Google</experience><experience>Apple</experience><experience>Mobile Iron</experience></experience><project><project><projectName>Movie App</projectName><technology><technology>Kotlin</technology><technology>SQL Lite</technology><technology>Gradle</technology></technology></project></project></item>
    And headers { Accept : 'application/json', Content-Type:'application/xml'}
    When method post
    Then status 201
    And print response
    And match response.jobId == 1

  Scenario: To create the Job Entry using XML request body format and receive the response in XML
    Given path '/normal/webapi/add'
    And request <item><jobId>10</jobId><jobTitle>Software Engg</jobTitle><jobDescription>To develop andriod application</jobDescription><experience><experience>Google</experience><experience>Apple</experience><experience>Mobile Iron</experience></experience><project><project><projectName>Movie App</projectName><technology><technology>Kotlin</technology><technology>SQL Lite</technology><technology>Gradle</technology></technology></project></project></item>
    And headers { Accept : 'application/xml', Content-Type:'application/xml'}
    When method post
    Then status 201
    And print response
    And match response/Job/jobId == "10"
    
      Scenario: To create the Job Entry in JSON format
    Given path '/normal/webapi/add'
    * def body = read("data/jobEntry.json") 
    And request body
    And headers { Accept : 'application/json', Content-Type:'application/json'}
    When method post
    Then status 201
    And print response
    And match response.jobTitle == "Software Engg"

  Scenario: To create the Job Entry using XML request body format
    Given path '/normal/webapi/add'
    * def body = read("data/jobEntry.xml")
    And request body
    And headers { Accept : 'application/json', Content-Type:'application/xml'}
    When method post
    Then status 201
    And print response
    And match response.jobId == 1
    
    Scenario: To create the Job Entry in JSON format with embedded expression
    Given path '/normal/webapi/add'
    * def getJobId = function() {return Math.floor((100)*Math.random());}
    And request {"jobId": '#(getJobId())',"jobTitle": "Software Engg","jobDescription": "To develop andriod application","experience": ["Google","Apple","Mobile Iron"],"project": [{"projectName": "Movie App","technology": ["Kotlin","SQL Lite","Gradle"]}]}
    And headers { Accept : 'application/json', Content-Type:'application/json'}
    When method post
    Then status 201
    And print response
    And match response.jobTitle == "Software Engg"
    
    Scenario: To create the Job Entry using XML request body format with embedded expression
    Given path '/normal/webapi/add'
    * def getJobId = function() {return Math.floor((100)*Math.random());}
    * def jobId = getJobId()
    And request <item><jobId>#(jobId)</jobId><jobTitle>Software Engg</jobTitle><jobDescription>To develop andriod application</jobDescription><experience><experience>Google</experience><experience>Apple</experience><experience>Mobile Iron</experience></experience><project><project><projectName>Movie App</projectName><technology><technology>Kotlin</technology><technology>SQL Lite</technology><technology>Gradle</technology></technology></project></project></item>
    And headers { Accept : 'application/json', Content-Type:'application/xml'}
    When method post
    Then status 201
    And print response
    And match response.jobId == '#(jobId)'
