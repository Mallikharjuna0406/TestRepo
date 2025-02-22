Feature: To upload the file using the Karate Framework

  Background: Setup the Base path
    Given url 'http://localhost:9897'

  Scenario: To upload file in the test application
    Given path '/normal/webapi/upload'
    # location of file, name of the file, content-type header value
    And multipart file file = { read:'FileUpload.txt', filename:'FileUpload.txt', Content-type:'multipart/form-data'}
    When method post
    Then status 200
    And print response

    Scenario: To upload file in the test application with json data
    Given path '/normal/webapi/upload'
    # location of file, name of the file, content-type header value
    * def fileLocation = '../data/jobEntry.json'
    And multipart file file = { read:'#(fileLocation)', filename:'jobEntry.json', Content-type:'multipart/form-data'}
    When method post
    Then status 200
    And print response
    And match response.message contains 'jobEntry.json'
    