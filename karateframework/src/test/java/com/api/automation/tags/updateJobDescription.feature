Feature: To test the patch end point for updating the job description
  Use PATCH /normal/webapi/update/details

  Background: Create and Initialize base url
    Given url 'http://localhost:9897'

@Smoke @Regression
  Scenario: To update the job descripton for newly added job entry
    # Create a new job entry
    # Using the patch request update the job description of newly added job entry
    * def getRandomValue = function() {return Math.floor((100)*Math.random());}
    * def createJobId = getRandomValue()
    * def createJob = call read("../createJobEntryWithVariables.feature") {_url:'http://localhost:9897', _path:'/normal/webapi/add', _id:'#(createJobId)'}
    # Patch request
    * def jobDes = 'To develop andrid and ios applications'
    Given path '/normal/webapi/update/details'
    And params {id:'#(createJobId)', jobTitle:'Software Engg', jobDescription:'#(jobDes)'}
    And header Accept = 'application/json'
    And request {}
    When method patch
    Then status 200
    And match response.jobDescription == jobDes

  Scenario: To update the job descripton for newly added job entry with non-existing job id
    # Create a new job entry
    # Using the patch request update the job description of newly added job entry
    * def getRandomValue = function() {return Math.floor((100)*Math.random());}
    * def createJobId = getRandomValue()
    * def createJob = call read("../createJobEntryWithVariables.feature") {_url:'http://localhost:9897', _path:'/normal/webapi/add', _id:'#(createJobId)'}
    # Patch request
    * def jobDes = 'To develop andrid and ios applications'
    Given path '/normal/webapi/update/details'
    And params {id:'-1', jobTitle:'Software Engg', jobDescription:'#(jobDes)'}
    And header Accept = 'application/json'
    And request {}
    When method patch
    Then status 404

@Smoke @Regression
  Scenario: To update the job descripton for newly added job entry without job title
    # Create a new job entry
    # Using the patch request update the job description of newly added job entry
    * def getRandomValue = function() {return Math.floor((100)*Math.random());}
    * def createJobId = getRandomValue()
    * def createJob = call read("../createJobEntryWithVariables.feature") {_url:'http://localhost:9897', _path:'/normal/webapi/add', _id:'#(createJobId)'}
    # Patch request
    * def jobDes = 'To develop andrid and ios applications'
    Given path '/normal/webapi/update/details'
    And params {id:'#(createJobId)', jobDescription:'#(jobDes)'}
    And header Accept = 'application/json'
    And request {}
    When method patch
    Then status 400
    And match response.message == "Required String parameter 'jobTitle' is not present"
