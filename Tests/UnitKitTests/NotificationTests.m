/*
 This source is part of UnitKit, a unit test framework for Mac OS X 
 development. You can find more information about UnitKit at:
 
 http://unitkit.org/
 
 Copyright ©2005 James Duncan Davidson
 
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

#import "NotificationTests.h"
#import "SinglePass.h"
#import "SingleFail.h"

@implementation NotificationTests

- (id) init
{
    self = [super init];
    runner = [[UKRunner alloc] init];
    accumulator = [[NotificationAccumulator alloc]
        initWithRunner:runner];
    return self;
}

- (void) dealloc
{   
    [runner release];
    [accumulator release];
    [super dealloc];
}

- (void) testSinglePass
{
    [runner addTestClass:[SinglePass class]];
    [runner run];
    
    UKIntsEqual(1, [[accumulator testClassAddedNotifications] count]);
    UKStringsEqual(@"SinglePass", [[[[accumulator testClassAddedNotifications]
        objectAtIndex:0] userInfo] valueForKey:@"class"]);
    
    UKIntsEqual(1, [[accumulator testRunStartingNotifications] count]);
    UKIntsEqual(1, [[accumulator testRunEndedNotifications] count]);   
    
    UKIntsEqual(1, [[accumulator testClassStartingNotifications] count]);
    UKStringsEqual(@"SinglePass", [[[[
        accumulator testClassStartingNotifications]
        objectAtIndex:0] userInfo] valueForKey:@"class"]); 
    
    UKIntsEqual(1, [[accumulator testClassEndedNotifications] count]);
    UKStringsEqual(@"SinglePass", [[[[accumulator testClassEndedNotifications]
        objectAtIndex:0] userInfo] valueForKey:@"class"]);
    
    UKIntsEqual(1, [[accumulator testMethodStartingNotifications] count]);
    UKStringsEqual(@"testTest", [[[[accumulator 
        testMethodStartingNotifications]
        objectAtIndex:0] userInfo] valueForKey:@"method"]); 
    
    UKIntsEqual(1, [[accumulator testMethodEndedNotificiations] count]);
    UKStringsEqual(@"testTest", [[[[accumulator 
        testMethodEndedNotificiations]
        objectAtIndex:0] userInfo] valueForKey:@"method"]); 
    
    UKIntsEqual(1, [[accumulator testPassedNotifications] count]);
    UKIntsEqual(0, [[accumulator testFailedNotifications] count]);
 
}

- (void) testSingleFail
{
    [runner addTestClass:[SingleFail class]];
    [runner run];
    
    UKIntsEqual(1, [[accumulator testClassAddedNotifications] count]);
    UKStringsEqual(@"SingleFail", [[[[accumulator testClassAddedNotifications]
        objectAtIndex:0] userInfo] valueForKey:@"class"]);
    
    UKIntsEqual(1, [[accumulator testRunStartingNotifications] count]);
    UKIntsEqual(1, [[accumulator testRunEndedNotifications] count]);   
    
    UKIntsEqual(1, [[accumulator testClassStartingNotifications] count]);
    UKStringsEqual(@"SingleFail", [[[[
        accumulator testClassStartingNotifications]
        objectAtIndex:0] userInfo] valueForKey:@"class"]); 
    
    UKIntsEqual(1, [[accumulator testClassEndedNotifications] count]);
    UKStringsEqual(@"SingleFail", [[[[accumulator testClassEndedNotifications]
        objectAtIndex:0] userInfo] valueForKey:@"class"]);
    
    UKIntsEqual(1, [[accumulator testMethodStartingNotifications] count]);
    UKStringsEqual(@"testTest", [[[[accumulator 
        testMethodStartingNotifications]
        objectAtIndex:0] userInfo] valueForKey:@"method"]); 
    
    UKIntsEqual(1, [[accumulator testMethodEndedNotificiations] count]);
    UKStringsEqual(@"testTest", [[[[accumulator 
        testMethodEndedNotificiations]
        objectAtIndex:0] userInfo] valueForKey:@"method"]); 
    
    UKIntsEqual(0, [[accumulator testPassedNotifications] count]);
    UKIntsEqual(1, [[accumulator testFailedNotifications] count]);
    
}


@end
