Feature: To use the JSON path expression

  Background: Setup the Base path
    Given url 'http://localhost:9897'

  Scenario: To get the value of property using json path expression
    Given path '/normal/webapi/all'
    When method get
    Then status 200
    # karate.jsonPath(doc, jsonPathExpression)
    * def jobId = 1
    * def jobTitle = karate.jsonPath(response, "$[?(@.jobId == "+jobId+")].jobTitle")
    # * def jobTitle = karate.jsonPath(response, "$[?(@.jobId == 1)].jobTitle")
    * def jobDescription = karate.jsonPath(response, "$[?(@.jobId == "+jobId+")].jobDescription")
    # * def jobDescription = karate.jsonPath(response, "$[?(@.jobId == 1)].jobDescription")
    * def experience = karate.jsonPath(response, "$[?(@.jobId == "+jobId+")].experience")
    # * def experience = karate.jsonPath(response, "$[?(@.jobId == 1)].experience")
    And print "jobTitle ==> ", jobTitle
    And print "jobDescription ==> ", jobDescription
    And print "experience ==> ", experience
