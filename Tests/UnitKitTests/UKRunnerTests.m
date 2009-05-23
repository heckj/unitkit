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

#import "UKRunnerTests.h"
#import "SinglePass.h"
#import "SingleFail.h"
#import "MixedTestBag.h"

@implementation UKRunnerTests

- (void) testTestsPassed
{
    UKRunner *runner = [UKRunner runner];
    [runner addTestClass:[SinglePass class]];
    [runner run];
    UKIntsEqual(1, [runner testsPassed]);
    UKIntsEqual(0, [runner testsFailed]);
}

- (void) testTestsFailed
{
    UKRunner *runner = [UKRunner runner];
    [runner addTestClass:[SingleFail class]];
    [runner run];
    UKIntsEqual(0, [runner testsPassed]);
    UKIntsEqual(1, [runner testsFailed]);    
}

- (void) testMethodNamesFromClassSingle
{
    NSArray *testMethods = UKTestMethodNamesFromClass([SinglePass class]);
    UKIntsEqual(1, [testMethods count]);
    UKTrue([testMethods containsObject:@"testTest"]);
}

- (void) testMethodNamesFromClassMixed
{
    NSArray *testMethods = UKTestMethodNamesFromClass([MixedTestBag class]);
    UKIntsEqual(3, [testMethods count]);
    UKTrue([testMethods containsObject:@"testOne"]);  
    UKTrue([testMethods containsObject:@"testTwo"]);  
    UKTrue([testMethods containsObject:@"testThree"]);  
}

- (void) testClassesFromBundle
{        
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *bundleDir = [[bundle bundlePath] 
        stringByDeletingLastPathComponent];
    
    NSString *testBundlePath = [bundleDir
        stringByAppendingPathComponent:@"UnitKitTestBundle.bundle"];

    NSBundle* testBundle = [NSBundle bundleWithPath:testBundlePath];
    if ( ! [testBundle load]) {
        // can't load test bundle
        // XXX put a message into this failure message once we get that 
        // functionality
        UKFail();
    }
    
    NSArray *testClasses = UKTestClassesFromBundle(testBundle);
    UKIntsEqual(2, [testClasses count]);
    UKTrue([testClasses containsObject:
        NSClassFromString(@"TestOne")]);
    UKTrue([testClasses containsObject:
        NSClassFromString(@"TestTwo")]);
}

/*
 XXX things remaining to be tests
 localizedString
 displayStringForException
 notification triggered for adding a test class
 notification triggered for each class triggered
 notification triggered for each method triggered
 */
@end
