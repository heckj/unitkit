/*
 This source is part of UnitKit, a unit test framework for Mac OS X 
 development. You can find more information about UnitKit at:
 
 http://unitkit.org/
 
 Copyright ©2005 James Duncan Davidson, Mark Dalrymple
 
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

#import "UKBasicReporter.h"
#import <UnitKit/UnitKit.h>

@implementation UKBasicReporter

- (id) initWithRunner:(UKRunner *) testRunner
{
    self = [super init];
    reportLevel = kUKReportDetailLevelNormal;
    testsPassed = 0;
    testsFailed = 0;
    testClassesRun = 0;
    testMethodsRun = 0;
    
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
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [runner release];
    [super dealloc];
    
}

- (void) setReportDetailLevel:(UKReportDetailLevel) level
{
    reportLevel = level;
}

- (void) testClassAdded:(NSNotification *)notification
{
    if (reportLevel == kUKReportDetailLevelVerbose) {
        printf("Class %s added\n", 
               [[[notification userInfo] valueForKey:@"class"] UTF8String]);
    }
}

- (void) testRunStarting:(NSNotification *)notification
{
    if (reportLevel == kUKReportDetailLevelVerbose) {
        printf("Starting test run now\n");
    }
}

- (void) testRunEnded:(NSNotification *)notification
{
    if (reportLevel == kUKReportDetailLevelVerbose) {
        printf("Test run complete\n");
    }
    if (testsFailed == 0) {
        printf("PASS");
    } else {
        printf("FAIL");
    }
    if (reportLevel >= kUKReportDetailLevelNormal) {
        printf(": %i classes, %i methods, ",
               testClassesRun, testMethodsRun);
        printf("%i assertions: %i passed, %i failed\n", 
               (testsPassed + testsFailed), testsPassed, testsFailed);
    } else {
        printf("\n");
    }
    
    // talk to growl if it's there.
    
    [self performGrowlRegistration];
    [self performGrowlNotification];
}

- (void) performGrowlRegistration
{
    NSMutableArray *notificationArray = 
    [NSArray arrayWithObject:@"UnitKit Notification"];  
    
    NSDictionary *regDict = [NSDictionary dictionaryWithObjectsAndKeys:
        @"UnitKit", @"ApplicationName",
        notificationArray, @"AllNotifications",
        notificationArray, @"DefaultNotifications",
        nil];
    
    [[NSDistributedNotificationCenter defaultCenter]
        postNotificationName:@"GrowlApplicationRegistrationNotification" 
                      object:nil userInfo:regDict];
    
}

- (void) performGrowlNotification
{
    NSString *title;
    
    if (testsFailed == 0) {
        title = @"UnitKit Test Run Passed";
    } else {
        title = @"UnitKit Test Run Failed";
    }
    
    NSString *msg = [NSString stringWithFormat:
        @"%i test classes, %i methods\n%i assertions passed, %i failed",
        testClassesRun, testMethodsRun,  testsPassed, testsFailed];
    
    NSMutableDictionary *notiInfo = [NSMutableDictionary dictionary];
    [notiInfo setObject:@"UnitKit Notification" forKey:@"NotificationName"];
    [notiInfo setObject:@"UnitKit" forKey:@"ApplicationName"];
    [notiInfo setObject:title forKey:@"NotificationTitle"];
    [notiInfo setObject:msg forKey:@"NotificationDescription"];
    
    NSString *iconPath;
    
    if (testsFailed == 0) {
        iconPath = [[NSBundle bundleForClass:[self class]]
            pathForImageResource:@"Icon-Pass"];
    } else {
        iconPath = [[NSBundle bundleForClass:[self class]]
            pathForImageResource:@"Icon-Fail"];
    }
    
    NSData *icon = [NSData dataWithContentsOfFile:iconPath];
    
    [notiInfo setObject:icon forKey:@"NotificationIcon"];
    
    [[NSDistributedNotificationCenter defaultCenter]
        postNotificationName:@"GrowlNotification" 
                      object:nil userInfo:notiInfo];    
}

- (void) testClassStarting:(NSNotification *)notification
{
    testClassesRun++;
    if (reportLevel == kUKReportDetailLevelVerbose) {
        printf("Starting tests from class %s\n", 
               [[[notification userInfo] valueForKey:@"class"] UTF8String]);
    }    
}

- (void) testClassEnding:(NSNotification *)notification
{
    if (reportLevel == kUKReportDetailLevelVerbose) {
        printf("Tests from class %s complete\n", 
               [[[notification userInfo] valueForKey:@"class"] UTF8String]);
    }    
}

- (void) testMethodStarting:(NSNotification *)notification
{    
    testMethodsRun++;
    if (reportLevel >= kUKReportDetailLevelNormal) {
        printf("Executing [%s %s]\n", 
               [[[notification userInfo] valueForKey:@"class"] UTF8String],
               [[[notification userInfo] valueForKey:@"method"] UTF8String]);
    }
}

- (void) testMethodEnding:(NSNotification *)notification
{
    if (reportLevel == kUKReportDetailLevelVerbose) {
        printf("Completed [%s %s]\n", 
               [[[notification userInfo] valueForKey:@"class"] UTF8String],
               [[[notification userInfo] valueForKey:@"method"] UTF8String]);
    }         
}

- (void) testFailed:(NSNotification *)notification
{
    testsFailed++;
    if (reportLevel >= kUKReportDetailLevelNormal) {
        printf("%s:%i: error: %s\n", 
               [[[notification userInfo] valueForKey:@"file"] UTF8String],
               [[[notification userInfo] valueForKey:@"line"] intValue],
               [[[notification userInfo] valueForKey:@"msg"] UTF8String]);
    }
}

- (void) testPassed:(NSNotification *)notification
{
    testsPassed++;
    if (reportLevel == kUKReportDetailLevelVerbose) {
        printf("%s:%i passed %s\n", 
               [[[notification userInfo] valueForKey:@"file"] UTF8String],
               [[[notification userInfo] valueForKey:@"line"] intValue],
               [[[notification userInfo] valueForKey:@"msg"] UTF8String]);
    }
}

@end
