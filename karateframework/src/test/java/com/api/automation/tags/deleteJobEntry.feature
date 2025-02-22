Feature: To test the delete end point
  DELETE /normal/webapi/remove/{id}

  Background: Create and Initialize base url
    Given url 'http://localhost:9897'
    
@Smoke
  Scenario: To delete the job entry from applicaton using job id
    # Create a new job entry
    # Delete the newly created job entry
    # Get request with query parameter and validate for 404
    * def getRandomValue = function() {return Math.floor((100)*Math.random());}
    * def createJobId = getRandomValue()
    * def createJob = call read("../createJobEntryWithVariables.feature") {_url:'http://localhost:9897', _path:'/normal/webapi/add', _id:'#(createJobId)'}
    # Delete request
    Given path '/normal/webapi/remove/' + createJobId
    And headers {Accept : 'application/json'}
    When method delete
    Then status 200
    # Get request
    Given path '/normal/webapi/find'
    And params {id : '#(createJobId)', jobTitle : 'Software Engg'}
    And header Accept = 'application/json'
    When method get
    Then status 404

@Regression
  Scenario: To delete the job entry from applicaton using job id
    # Create a new job entry
    # Delete the newly created job entry
    # Get request with query parameter and validate for 404
    * def getRandomValue = function() {return Math.floor((100)*Math.random());}
    * def createJobId = getRandomValue()
    * def createJob = call read("../createJobEntryWithVariables.feature") {_url:'http://localhost:9897', _path:'/normal/webapi/add', _id:'#(createJobId)'}
    # Delete request
    Given path '/normal/webapi/remove/' + createJobId
    And headers {Accept : 'application/json'}
    When method delete
    Then status 200
    # Delete request
    Given path '/normal/webapi/remove/' + createJobId
    And headers {Accept : 'application/json'}
    When method delete
    Then status 404

  Scenario: To demo request chaining
    # Create a new job entry
    # Extract job id and job title from the response of POST request
    # Send the path request, value of query paramater will be set by, info extracted from previous request
    # Extract job id and job title from the response of PATCH request
    # Get request with query parameter, value of query paramater is set by, info extracted from response of patch request
    # Add the validation on job description in the response of get request
    * def getRandomValue = function() {return Math.floor((100)*Math.random());}
    * def createJobId = getRandomValue()
    * def createJob = call read("../createJobEntryWithVariables.feature") {_url:'http://localhost:9897', _path:'/normal/webapi/add', _id:'#(createJobId)'}
    * def jobId = createJob.responseJobId
    * def jobTitle = createJob.responseJobTitle
    
    #PATCH request
    * def jobDes = 'To develop andrid and ios applications'
    Given path '/normal/webapi/update/details'
    And params {id:'#(jobId)', jobTitle:'#(jobTitle)', jobDescription:'#(jobDes)'}
    And header Accept = 'application/json'
    And request {}
    When method patch
    Then status 200
    * def jobId = response.jobId
    * def jobTitle = response.jobTitle
    
    # Get request
    Given path '/normal/webapi/find'
    And params {id : '#(jobId)', jobTitle : '#(jobTitle)'}
    And header Accept = 'application/json'
    When method get
    Then status 200
    And match response.jobDescription == jobDes	
