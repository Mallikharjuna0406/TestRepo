Feature: To validate the GET End point
  To validate the GET End point response

  Background: Setup the base url
    Given url 'http://localhost:9897'

  Scenario: To get the  data in JSON format
    Given path '/normal/webapi/all'
    And header Accept = 'application/json'
    When method get
    Then status 200
    # Create a variable t store the data from external file
    * def actualResponse = read("../JsonResponse.json")
    And match response == actualResponse
    And print "File ==>", actualResponse

  Scenario: To get the  data in XML format
    Given path '/normal/webapi/all'
    And header Accept = 'application/xml'
    When method get
    Then status 200
    # Create a variable t store the data from external file
    * def actualResponse = read("../XmlResponse.xml")
    #And match response == actualResponse
    And print "File ==>", actualResponse
