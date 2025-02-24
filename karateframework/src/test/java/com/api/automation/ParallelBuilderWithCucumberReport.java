package com.api.automation;
 
import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
 
import org.apache.commons.io.FileUtils;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
 
import com.intuit.karate.Results;
import com.intuit.karate.Runner.Builder;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
 
public class ParallelBuilderWithCucumberReport {
 
    @Test
    public void executeKarateTest() {
        Builder aRunner = new Builder();
        aRunner.path("classpath:com/api/automation");
        aRunner.outputCucumberJson(true);
 
        Results result = aRunner.parallel(1);
 
        System.out.println("Total Feature => " + result.getFeaturesTotal());
        System.out.println("Total Scenarios => " + result.getScenariosTotal());
        System.out.println("Passed Scenarios => " + result.getScenariosPassed());
 
        generateCucumberReport(result.getReportDir());
        Assertions.assertEquals(0, result.getFailCount(), "There are Some Failed Scenarios");
    }
 
    private void generateCucumberReport(String reportDirLocation) {
        File reportDir = new File(reportDirLocation);
        if (!reportDir.exists()) {
            System.out.println("Report directory does not exist. Creating directory...");
            reportDir.mkdirs();
        }
        System.out.println("Report Directory: " + reportDir.getAbsolutePath());
 
        Collection<File> jsonCollection = FileUtils.listFiles(reportDir, new String[] { "json" }, true);
 
        if (jsonCollection.isEmpty()) {
            System.out.println("No JSON files found in the report directory!");
        } else {
            jsonCollection.forEach(file -> System.out.println("Found JSON file: " + file.getAbsolutePath()));
        }
 
        List<String> jsonFiles = new ArrayList<>();
        jsonCollection.forEach(file -> jsonFiles.add(file.getAbsolutePath()));
 
        Configuration configuration = new Configuration(reportDir, "Karate Run");
        ReportBuilder reportBuilder = new ReportBuilder(jsonFiles, configuration);
        reportBuilder.generateReports();
    }
}