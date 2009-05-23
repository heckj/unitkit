/*
 This source is part of UnitKit, a unit test framework for Mac OS X 
 development. You can find more information about UnitKit at:
 
 http://unitkit.org/
 
 Copyright ©2005 Joseph Heck, James Duncan Davidson
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 
 The use of the Apache License does not indicate that this project is
 affiliated with the Apache Software Foundation.
 */

#import "UKXMLReporter.h"
#import <UnitKit/URLEscape.h>


@implementation UKXMLReporter

- (id) initWithRunner:(UKRunner *) testRunner
{
    self = [super init];
    reportLevel = kUKReportDetailLevelNormal;
    testsPassed = 0;
    testsFailed = 0;
    testClassesRun = 0;
    testMethodsRun = 0;
    outputPath = nil;
    
    assertionInfos = [[NSMutableArray alloc] init];
    
    runner = [testRunner retain];
    NSNotificationCenter* noticenter = [NSNotificationCenter defaultCenter];
    [noticenter addObserver:self selector:@selector(testClassAdded:) 
                       name:UKTestClassAddedNotification object:runner ];
    [noticenter addObserver:self selector:@selector(testRunStarting:) 
                       name:UKTestRunStartingNotification object:runner ];
    [noticenter addObserver:self selector:@selector(testRunEnded:) 
                       name:UKTestRunEndedNotification object:runner ];
    [noticenter addObserver:self selector:@selector(testClassStarting:) 
                       name:UKTestClassStartingNotification object:runner ];
    [noticenter addObserver:self selector:@selector(testClassEnding:) 
                       name:UKTestClassEndedNotification object:runner ];
    [noticenter addObserver:self selector:@selector(testMethodStarting:) 
                       name:UKTestMethodStartingNotification object:runner ];
    [noticenter addObserver:self selector:@selector(testMethodEnding:) 
                       name:UKTestMethodEndedNotification object:runner ];
    [noticenter addObserver:self selector:@selector(testFailed:) 
                       name:UKTestFailureNotification object:runner ];
    [noticenter addObserver:self selector:@selector(testPassed:) 
                       name:UKTestSuccessNotification object:runner ];
    return self;
}

- (void) dealloc
{
    [self setReportOutputPath:nil];
    [assertionInfos release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [runner release];
    [super dealloc];
    
}

- (void) setReportDetailLevel:(UKReportDetailLevel) level
{
    reportLevel = level;
}

- (void) setReportOutputPath:(NSString *) anOutputPath
{
    if (outputPath != anOutputPath) {
        [outputPath release];
        outputPath = [anOutputPath copy];
    }
}

- (void) testClassAdded:(NSNotification *)notification
{

}

- (void) testRunStarting:(NSNotification *)notification
{

}

- (void) testRunEnded:(NSNotification *)notification
{
    NSMutableString * xmlResults = [[NSMutableString alloc] init];
    [xmlResults appendString:@"<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n"];
    [xmlResults appendFormat:@"<testsuite tests=\"%d\" failures=\"%d\">\n", 
           (testsPassed + testsFailed), testsFailed];
    
    NSEnumerator *e = [assertionInfos objectEnumerator];
    NSDictionary *info;
    while (info = [e nextObject]) {
        [xmlResults appendString:@"<testresult"];
        if (([info valueForKey:@"file"] != nil) && 
            ([[info valueForKey:@"line"] intValue] > 0)) 
        {
            [xmlResults appendFormat:@" name=\"%s\" line=\"%d\">", 
                   [[info valueForKey:@"file"] UTF8String],
                   [[info valueForKey:@"line"] intValue]];
        } else {
            [xmlResults appendString:@">"];
        }
        if ([info valueForKey:@"msg"] != nil) {
            [xmlResults appendFormat:@"%s", [[[info valueForKey:@"msg"] escapedString] UTF8String]];
        }
        [xmlResults appendString:@"</testresult>\n"];
    }
    [xmlResults appendString:@"</testsuite>"];
    
    if (outputPath != nil) {
        [xmlResults writeToFile:outputPath atomically:YES];        
    }
    [xmlResults release];
}

- (void) testClassStarting:(NSNotification *)notification
{
  
}

- (void) testClassEnding:(NSNotification *)notification
{
  
}

- (void) testMethodStarting:(NSNotification *)notification
{    

}

- (void) testMethodEnding:(NSNotification *)notification
{
        
}

- (void) testFailed:(NSNotification *)notification
{
    testsFailed++;
    [assertionInfos addObject:[notification userInfo]];
}

- (void) testPassed:(NSNotification *)notification
{
    testsPassed++;
    [assertionInfos addObject:[notification userInfo]];
}


@end
