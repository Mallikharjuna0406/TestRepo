Feature: To validate the GET End point
  To validate the GET End point response

  Background: Setup the base url
    Given url 'http://localhost:9897'

  Scenario: To get the  data in JSON format
    Given path '/normal/webapi/all'
    And header Accept = 'application/json'
    When method get
    Then status 200
    And match response.[0].jobId == 1
    And match response.[0].jobTitle  == "Software Engg"
    And match response.[0].experience[0] == "Google"
    And match response.[0].project[0].projectName == "Movie App"
    And match response.[0].project[0].technology[0] =="Kotlin"
    #validate the size of array
    And match response.[0].experience == '#[3]'
    And match response.[0].project[0].technology == '#[3]'
    #Using wld card char
    And match response.[0].experience[*] == ['Google','Apple','Mobile Iron']
    And match response.[0].project[0].technology[*] == ['Kotlin','SQL Lite','Gradle']
    # Contains keyword
    And match response.[0].experience[*] contains ['Google','Mobile Iron','Apple',]
    And match response.[0].project[0].technology[*] contains ['Kotlin','Gradle','SQL Lite']
    And match response.[*].jobId contains 1

  Scenario: To get the  data in JSON format and validate using fuzzy matcher
    Given path '/normal/webapi/all'
    And header Accept = 'application/json'
    When method get
    Then status 200
    And match response.[0].jobId == '#present'
    And match response.[0].jobTitle  == '#notnull'
    And match response.[0].experience == '#array'
    And match response.[0].experience[0] == '#string'
    And match response.[0].project[0].projectName == '#string'
    And match response.[0].project[0].technology =='#array'
    And match response.[0].project[0].technology[0] =='#string'
    And match response.[0].jobId == '#number'
    #Complex Fuzzy matcher
    And match response.[0].jobId == '#? _ == 1'
    And match response.[0].jobTitle == '#string'
    And match response.[0].experience == '#array? _.length >=1'
    #To validate the array
    And match response.[0].experience == '#[]'
    And match response.[0].experience == '#[3]'
    And match response.[0].project[0].technology =='#[]'
    And match response.[0].project[0].technology =='#[3]'
    #Make sure it is an arry of string
    And match response.[0].experience == '#[3] #string'
    And match response.[0].experience == '#[3] #string? _.length>=2'
