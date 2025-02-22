Feature: To test the get end point of the application
  To test different get end point with different data formate supported by the application

  Background: Setup the Base path
    Given url 'http://localhost:9897'
    And print "============ This is Background Keyword ============"

  Scenario: To get all the  data from application in JSON format
    #Given url 'https://reqres.in/api/users?page=2'
    #Base Path + Context Path
    Given path '/normal/webapi/all'
    When method get # Send the get request
    #Then status 201 # the status code response should be 200
    Then status 200 # the status code response should be 200

  @ignore
  Scenario: To get all the  data from application in JSON format using path variable
    #Given url 'https://reqres.in'
    And path '/normal/webapi/all'
    And header Accept = 'application/json'
    #Base Path + Context Path
    When method get # Send the get request
    #Then status 201 # the status code response should be 200
    Then status 200 # the status code response should be 200

  Scenario: To get all the  data from application in XML format using path variable
    #Given url 'https://reqres.in'
    And path '/normal/webapi/all'
    And header Accept = 'application/xml'
    #Base Path + Context Path
    When method get # Send the get request
    #Then status 201 # the status code response should be 200
    Then status 200 # the status code response should be 200
