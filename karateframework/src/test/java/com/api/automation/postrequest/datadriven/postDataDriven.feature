Feature: To create job description in the test application

  Background: Read the data for data driven
    * def testdata = read("testData.csv")

  Scenario Outline: To create job description in the test application <method>
    Given print '<url>'
    When print '<path>'
    Then print '<method>'
    And print '<status>'

    Examples: 
      | url                   | path               | method | status |
      | http://localhost:9897 | /normal/webapi/all | get    |    200 |
      | http://localhost:9897 | /normal/webapi/add | post   |    201 |
      | http://localhost:9897 | /normal/webapi/add | put    |    201 |

  Scenario Outline: Data Drven for the job description entry - <jobId>
    Given url 'http://localhost:9897'
    And path '/normal/webapi/add'
    And request {"jobId": '#(jobId)',"jobTitle": '#(jobTitle)',"jobDescription": '#(jobDescription)',"experience": ["Google","Apple","Mobile Iron"],"project": [{"projectName": "Movie App","technology": ["Kotlin","SQL Lite","Gradle"]}]}
    And headers { Accept : 'application/json', Content-Type:'application/json'}
    When method post
    Then status <status>

    Examples: 
      | jobId | jobTitle               | jobDescription                 | status |
      |  9980 | Software Engineer SDET | To develop andriod application |    201 |
      | id    | Software Engineer SDET | To develop andriod application |    400 |
      | false | Software Engineer SDET | To develop andriod application |    400 |

  Scenario Outline: Data Drven for the job description entry using csv file- <jobId>
    Given url 'http://localhost:9897'
    And path '/normal/webapi/add'
    And request {"jobId": '#(jobId)',"jobTitle": '#(jobTitle)',"jobDescription": '#(jobDescription)',"experience": ["Google","Apple","Mobile Iron"],"project": [{"projectName": "Movie App","technology": ["Kotlin","SQL Lite","Gradle"]}]}
    And headers { Accept : 'application/json', Content-Type:'application/json'}
    When method post
    Then status <status>

    Examples: 
      #| testdata |
      |read("testData.csv")|
