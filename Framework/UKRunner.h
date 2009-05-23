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

#import <Foundation/Foundation.h>

@interface UKRunner : NSObject {
    NSMutableArray *testClasses;
    NSMutableArray *testPassedNotifications;
    NSMutableArray *testFailedNotifications;
    int testClassesRun;
    int testMethodsRun;
}

/*!
 @method runner
 @abstract Creates returns a fresh UKRunner instance
 @discussion
 */
+ (UKRunner *) runner;

/*!
 @method addTestsFromClass:
 @abstract Adds a class to a list of test classes that will be executed.
 @discussion
 */
- (void) addTestClass:(Class) testClass;

/*!
 @method addTestsFromBundle:
 @abstract Adds all of the test classes, tagged with the UKTest protocol, into the list of test classes that wil be executed.
 @discussion 
 @result returns the number of test classes found in the bundle
 */
- (void) addTestsFromBundle:(NSBundle *)bundle;

/*!
 @method run
 @abstract Executes the tests that have been added to the runner.
 @discussion
 */
- (void) run;

/*!
 @method testsPassed
 @abstract 
 @discussion
 @result Returns the number of tests run that passed
 */
- (int) testsPassed;

/*!
 @method testsFailed
 @abstract
 @discussion
 @result Returns the number of tests that failed
 */
- (int) testsFailed;

@end

/*!
 @function UKTestClassesFromBundle
 @abstract   
 @discussion 
 @param      bundle A bundle that contains test classes
 @result     An array containing the test classes
*/

NSArray *UKTestClassesFromBundle(NSBundle *bundle);

/*!
 @function UKTestMethodNamesFromClass
 @abstract
 @discussion
 @param class Class that contains test methods
 @result An array containing the method names as NSString objects
 */

NSArray *UKTestMethodNamesFromClass(Class class);

#pragma mark NOTIFICATIONS

extern NSString *UKTestClassAddedNotification;
extern NSString *UKTestRunStartingNotification;
extern NSString *UKTestRunEndedNotification;
extern NSString *UKTestClassStartingNotification;
extern NSString *UKTestClassEndedNotification;
extern NSString *UKTestMethodStartingNotification;
extern NSString *UKTestMethodEndedNotification;
extern NSString *UKTestSuccessNotification;
extern NSString *UKTestFailureNotification;
