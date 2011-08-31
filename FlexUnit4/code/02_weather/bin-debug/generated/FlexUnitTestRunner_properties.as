package 
{

import mx.resources.ResourceBundle;

[ExcludeClass]

public class en_US$FlexUnitTestRunner_properties extends ResourceBundle
{

    public function en_US$FlexUnitTestRunner_properties()
    {
		 super("en_US", "FlexUnitTestRunner");
    }

    override protected function getContent():Object
    {
        var content:Object =
        {
            "titleString": "Executing FlexUnit Tests",
            "totalIgnoredTestRunCountLabel": "Ignored:",
            "totalSuccessTestRunCountLabel": "Passed:",
            "testOverMessage": "Completed",
            "closeTheWindowMessage": "It is now safe to close this window.",
            "versionMessage": "Runner Version:",
            "dontCloseWindowMessage": "Execution is in progress. Please do not close this window.",
            "totalFailureTestRunCountLabel": "Failed:",
            "seeResultInFlexBuilderLabel": "More details can be seen in 'FlexUnit Results' view inside Flash Builder.",
            "testRunningLabel": "Running",
            "totalErrorTestRunCountLabel": "Errors:",
            "totalTestRunCountLabel": "No. of Tests:",
            "statusLabel": "Status:"
        };
        return content;
    }
}



}
