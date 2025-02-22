package com.api.automation.config.report;

import java.util.stream.Stream;

import com.aventstack.extentreports.ExtentReports;
import com.aventstack.extentreports.ExtentTest;
import com.aventstack.extentreports.gherkin.model.And;
import com.aventstack.extentreports.gherkin.model.Feature;
import com.aventstack.extentreports.gherkin.model.Given;
import com.aventstack.extentreports.gherkin.model.Scenario;
import com.aventstack.extentreports.gherkin.model.Then;
import com.aventstack.extentreports.gherkin.model.When;
import com.aventstack.extentreports.reporter.ExtentSparkReporter;
import com.aventstack.extentreports.reporter.configuration.Theme;
import com.intuit.karate.Results;
import com.intuit.karate.core.Result;
import com.intuit.karate.core.ScenarioResult;
import com.intuit.karate.core.Step;


public class CustomExtentReport {
	// Builder Design Report

	private ExtentReports extentReports;
	private ExtentSparkReporter extentSparkReporter;
	private String reportDir;
	private String reportTitle = "Karate Test Execution Report";
	private Results testResults;
	private ExtentTest featureNode;
	private String featureTitle = ""; 
	private ExtentTest scenarioNode;
	private String scenarioTitle = ""; 


	public CustomExtentReport() {
		extentReports = new ExtentReports();
	}

	public CustomExtentReport withReportDir(String reportDir) {
		this.reportDir = reportDir;
		return this;
	}

	public CustomExtentReport withKarateResult(Results testResults) {
		this.testResults = testResults;
		return this;
	}

	public CustomExtentReport withReportTitle(String reportTitle) {
		this.reportTitle = reportTitle;
		return this;
	}

	public void generateExtentReport() {
		// 1. Check for ReportDir and TestResults, if not present then throw Exception

		if(this.reportDir != null && !this.reportDir.isEmpty() && this.testResults != null ) {
			extentSparkReporter = new ExtentSparkReporter(reportDir);
			extentReports.attachReporter(extentSparkReporter);
			Stream<ScenarioResult> scenarioResults = getScenarioResults();
			scenarioResults.forEach((ScenarioResult)-> {
				String featureName = getFeatureName(ScenarioResult);
				String featureDesc = getFeatureDesc(ScenarioResult);
				ExtentTest featureNode = createFeatureNode(featureName, featureDesc);
				String scenarioTitle = getScenarioTitle(ScenarioResult);
				ExtentTest scenarioNode = createScenarioNode(featureNode, scenarioTitle);
				ScenarioResult.getStepResults().forEach((step)-> {
					// Adding the scenario step with scenario node
					addScenarioStep(scenarioNode, step.getStep(), step.getResult());
				});
			});
			extentReports.flush();
			return;
		}

		// 2. Using the testReults, Get the list of scenario results
		// 3. loop over list of scenario results
		// 4. Using scenario result, get the scenario object
		// 5. Using the scenario object, get the info about feature file
		// 6. Using the same scenario object, we will get the info about the scenario
		// 7. Using the scenario result get the list of step result
		// 8. loop over the step result list, get the info about scenario step and its execution status
		// 9. Use all the info to generate the extent report
		throw new RuntimeException("Missing the Karate Test Result / Report Dir Location");
	}

	private Stream<ScenarioResult> getScenarioResults(){
		return this.testResults.getScenarioResults();
	}

	private String getFeatureName(ScenarioResult scenarioResult) {
		return scenarioResult.getScenario().getFeature().getName();
	}

	private String getFeatureDesc(ScenarioResult scenarioResult) {
		return scenarioResult.getScenario().getFeature().getDescription();
	}

	private ExtentTest createFeatureNode(String featureName, String featureDesc) {
		// if the title of feature is same, I will return same instance of extent test
		// else I will create a new instance and then return it

		if(this.featureTitle.equalsIgnoreCase(featureTitle)) {
			return featureNode;
		}
		this.featureTitle = featureName;
		featureNode = extentReports.createTest(Feature.class, featureName, featureDesc);
		return featureNode;
	}

	private ExtentTest createScenarioNode(ExtentTest featureNode, String scenarioTitle) {
		// if the title of feature is same, I will return same instance of extent test
		// else I will create a new instance and then return it

		if(this.scenarioTitle.equalsIgnoreCase(scenarioTitle)) {
			return featureNode;
		}
		this.scenarioTitle = scenarioTitle;
		scenarioNode = featureNode.createNode(Scenario.class, scenarioTitle);
		return scenarioNode;
	}

	private String getScenarioTitle(ScenarioResult scenarioResult) {
		return scenarioResult.getScenario().getName();
	}

	private void addScenarioStep(ExtentTest scenarioNode, Step step, Result stepResult) {
		String type = step.getPrefix(); //Given, When and Then
		String stepTitle = step.getText();
		String status = stepResult.getStatus();
		Throwable error = stepResult.getError();
		ExtentTest stepNode;

		switch (type) {
		case "Given":
			stepNode = scenarioNode.createNode(Given.class, stepTitle);
			addStatus(stepNode, status, error);
			break;
		case "When":
			stepNode = scenarioNode.createNode(When.class, stepTitle);
			addStatus(stepNode, status, error);
			break;
		case "Then":
			stepNode = scenarioNode.createNode(Then.class, stepTitle);
			addStatus(stepNode, status, error);
			break;
		case "And":
			stepNode = scenarioNode.createNode(And.class, stepTitle);
			addStatus(stepNode, status, error);
			break;

		default:
			stepNode = scenarioNode.createNode(type + " " +stepTitle);
			addStatus(stepNode, status, error);
			break;
		}

	}

	private void addStatus(ExtentTest stepNode, String status, Throwable error) {
		switch (status) {
		case "passed":
			stepNode.pass("");
			break;
		case "failed":
			stepNode.fail(error);
			break;
		default:
			stepNode.skip("");
			break;
		}
	}

	private void setConfig() {
		extentSparkReporter.config().enableOfflineMode(true);
		extentSparkReporter.config().setDocumentTitle(reportTitle);
		extentSparkReporter.config().setTimelineEnabled(true);
		extentSparkReporter.config().setTheme(Theme.DARK);
	}
}