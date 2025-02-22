Feature: Variables in Karate Framework

  Background: Create and Initialize Variables
    * def app_name = "Google"
    * def page_load_timeout = 20

  # <Gherkin Keyword> <def> <Variable_name> = <Value>
  # * <def> <Variable_name> = <Value>
  Scenario: To create a Variable
    # Use variable for repeating value
    # Storing the data from a external file
    # In the matcher expression
    # Passing the data from one feature file to another feature file
    Given def var_int = 10
    And def var_string = "Karate"
    Then print "Int Variable ==>", var_int
    And print "String Variable ==>", var_string
    * def var_int_2 = var_int + 10
    And print "New Variable ==>", var_int_2
    And print "Background Section Variables ==>", app_name, page_load_timeout

  Scenario: Access the variable
    * def var_int = 1
    * def var_string = "New"
    * def var_int_2 = var_int+1
    Given print "Previous scenario ==>", var_int
    And print "Previous scenario ==>", var_string
    And print "Previous scenario ==>", var_int_2
    And print "Background Section Variables ==>", app_name, page_load_timeout
