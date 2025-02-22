Feature: To get the variables set by karate-config.js file

  Background: To get the value of myVarName
    * def localmyVarName = myVarName
    Given print "Background variable value ==> ", localmyVarName

  Scenario: To get the value of username and password from karate-config.js
    * def localusername = username
    Given print "Scenario variable value ==> ", localusername
    And print "Scenario variable value ==> ", password
