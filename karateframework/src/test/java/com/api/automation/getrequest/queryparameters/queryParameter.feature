Feature: To test the Get end point with Query Parameter
  GET /normal/webapi/find

  Background: Create and Initialize base url
    Given url 'http://localhost:9897'

  Scenario: To get the data using Query Parameter
    # Create job entry
    # Get the newly created job entry using query param
    * def getRandomValue = function() {return Math.floor((100)*Math.random());}
    * def createJobId = getRandomValue()
    * def createJob = call read("../../createJobEntryWithVariables.feature") {_url:'http://localhost:9897', _path:'/normal/webapi/add', _id:'#(createJobId)'}
    # Send the Get request with query param
    Given path '/normal/webapi/find'
    #And param id = createJobId
    #And param jobTitle = 'Software Engg'
    And params {id : '#(createJobId)', jobTitle : 'Software Engg'}
    And headers {Accept:'application/json'}
    When method get
    Then status 200
    And match response.jobId == createJobId
    
Scenario: To get the data using Query Parameter wit Jobd not in the application
    # Create job entry
    # Get the newly created job entry using query param
    * def getRandomValue = function() {return Math.floor((100)*Math.random());}
    * def createJobId = getRandomValue()
    * def createJob = call read("../../createJobEntryWithVariables.feature") {_url:'http://localhost:9897', _path:'/normal/webapi/add', _id:'#(createJobId)'}
    # Send the Get request with query param
    Given path '/normal/webapi/find'
    And param id = 63468866
    And param jobTitle = 'Software Engg'
    And headers {Accept:'application/json'}
    When method get
    Then status 404
  