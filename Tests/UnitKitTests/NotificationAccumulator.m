/*
 This source is part of UnitKit, a unit test framework for Mac OS X 
 development. You can find more information about UnitKit at:
 
 http://unitkit.org/
 
 Copyright ©2004-2005 James Duncan Davidson
 
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

#import "NotificationAccumulator.h"

@implementation NotificationAccumulator

- (id) initWithRunner:(UKRunner *) testRunner
{
    self = [super init];
    testClassAddedNotifications = [[NSMutableArray alloc] init];
    testRunStartingNotifications = [[NSMutableArray alloc] init];
    testRunEndedNotifications = [[NSMutableArray alloc] init];
    testClassStartingNotifications = [[NSMutableArray alloc] init];
    testClassEndedNotifications = [[NSMutableArray alloc] init];
    testMethodStartingNotifications = [[NSMutableArray alloc] init];
    testMethodEndedNotifications = [[NSMutableArray alloc] init];
    testPassedNotifications = [[NSMutableArray alloc] init];
    testFailedNotifications = [[NSMutableArray alloc] init];
    
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
    [testClassAddedNotifications release];
    [testRunStartingNotifications release];
    [testRunEndedNotifications release];
    [testClassStartingNotifications release];
    [testClassEndedNotifications release];
    [testMethodStartingNotifications release];
    [testMethodEndedNotifications release];
    [testPassedNotifications release];
    [testFailedNotifications release];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [runner release];
    [super dealloc];
}

- (NSArray *) testClassAddedNotifications
{
    return testClassAddedNotifications;
}

- (NSArray *) testRunStartingNotifications
{
    return testRunStartingNotifications;
}

- (NSArray *) testRunEndedNotifications
{
    return testRunEndedNotifications;
}

- (NSArray *) testClassStartingNotifications
{
    return testClassStartingNotifications;
}

- (NSArray *) testClassEndedNotifications
{
    return testClassEndedNotifications;
}

- (NSArray *) testMethodStartingNotifications
{
    return testMethodStartingNotifications;
}

- (NSArray *) testMethodEndedNotificiations
{
    return testMethodEndedNotifications;
}

- (NSArray *) testPassedNotifications
{
    return testPassedNotifications;
}

- (NSArray *) testFailedNotifications
{
    return testFailedNotifications;
}

- (void) setReportDetailLevel:(UKReportDetailLevel) level
{
    // do nothing
}

- (void) testClassAdded:(NSNotification *)notification
{
    [testClassAddedNotifications addObject:notification];
}

- (void) testRunStarting:(NSNotification *)notification
{
    [testRunStartingNotifications addObject:notification];
}

- (void) testRunEnded:(NSNotification *)notification
{
    [testRunEndedNotifications addObject:notification];
}

- (void) testClassStarting:(NSNotification *)notification
{
    [testClassStartingNotifications addObject:notification];
}

- (void) testClassEnding:(NSNotification *)notification
{
    [testClassEndedNotifications addObject:notification];
}

- (void) testMethodStarting:(NSNotification *)notification
{    
    [testMethodStartingNotifications addObject:notification];
}

- (void) testMethodEnding:(NSNotification *)notification
{
    [testMethodEndedNotifications addObject:notification];
}

- (void) testPassed:(NSNotification *)notification
{
    [testPassedNotifications addObject:notification];
}

- (void) testFailed:(NSNotification *)notification
{
    [testFailedNotifications addObject:notification];
}

@end
