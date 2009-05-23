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

#import <Cocoa/Cocoa.h>
#import <UnitKit/UnitKit.h>

/*!
 @class NotificationAccumulator
 @abstract Accumulates all of the various notifications that result from test macro execution.
 @discussion This class will slurp up and store all of the notifications that come from tests run by a UKRunner instance. It then makes them available for later inspection. This is used quite a bit in testing out the test macros where a fresh UKRunner is created, a single test class is set on it and run, and then we look at the resulting notifications to make sure that the right thing happens.   
*/


@interface NotificationAccumulator : NSObject <UKReporter> {
    UKRunner *runner;
    
    NSMutableArray *testClassAddedNotifications;
    NSMutableArray *testRunStartingNotifications;
    NSMutableArray *testRunEndedNotifications;
    NSMutableArray *testClassStartingNotifications;
    NSMutableArray *testClassEndedNotifications;
    NSMutableArray *testMethodStartingNotifications;
    NSMutableArray *testMethodEndedNotifications;
    NSMutableArray *testPassedNotifications;
    NSMutableArray *testFailedNotifications;
}

- (NSArray *) testClassAddedNotifications;
- (NSArray *) testRunStartingNotifications;
- (NSArray *) testRunEndedNotifications;
- (NSArray *) testClassStartingNotifications;
- (NSArray *) testClassEndedNotifications;
- (NSArray *) testMethodStartingNotifications;
- (NSArray *) testMethodEndedNotificiations;
- (NSArray *) testPassedNotifications;
- (NSArray *) testFailedNotifications;

@end

