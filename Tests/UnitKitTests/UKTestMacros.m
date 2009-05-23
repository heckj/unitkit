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

#import "UKTestMacros.h"

@implementation UKTestMacros

- (id) init
{
    self = [super init];
    runner = [[UKRunner alloc] init];
    accumulator = [[NotificationAccumulator alloc] initWithRunner:runner];
    return self;
     
}

- (void) dealloc
{   
    [runner release];
    [accumulator release];
    [super dealloc];
}

- (void) testUKPass
{
    [runner addTestClass:NSClassFromString(@"TestUKPass")];
    [runner run];
    
    UKIntsEqual(1, [runner testsPassed]);
    UKIntsEqual(0, [runner testsFailed]);

    
    if ([[accumulator testPassedNotifications] count] == 1) {
        NSDictionary *dict = [[[accumulator testPassedNotifications] 
            objectAtIndex:0] userInfo];
        UKIntsEqual(32, [[dict objectForKey:@"line"] intValue]);
        UKStringsEqual(@"", [dict objectForKey:@"msg"]);
        UKStringContains([dict objectForKey:@"file"], @"TestUKPass.m");
    } else {
        UKFail();
    }
}

- (void) testUKFail
{
    [runner addTestClass:NSClassFromString(@"TestUKFail")];
    [runner run];
    
    UKIntsEqual(0, [runner testsPassed]);
    UKIntsEqual(1, [runner testsFailed]);

    
    if ([[accumulator testFailedNotifications] count] == 1) {
        NSDictionary *dict = [[[accumulator testFailedNotifications] 
            objectAtIndex:0] userInfo];
        UKIntsEqual(32, [[dict objectForKey:@"line"] intValue]);
        UKStringsEqual(@"", [dict objectForKey:@"msg"]);
        UKStringContains([dict objectForKey:@"file"], @"TestUKFail.m");
    } else {
        UKFail();
    }
}

- (void) testUKTrue_Positive
{
    [runner addTestClass:NSClassFromString(@"TestUKTrue_Positive")];
    [runner run];
    
    UKIntsEqual(1, [runner testsPassed]);
    UKIntsEqual(0, [runner testsFailed]);
    
    if ([[accumulator testPassedNotifications] count] == 1) {
        NSDictionary *dict = [[[accumulator testPassedNotifications] 
            objectAtIndex:0] userInfo];
        UKIntsEqual(31, [[dict objectForKey:@"line"] intValue]);
        UKStringsEqual(@"Got true", [dict objectForKey:@"msg"]);
        UKStringContains([dict objectForKey:@"file"], @"TestUKTrue_Positive.m");
    } else {
        UKFail();
    }
}

- (void) testUKTrue_Negative
{
    [runner addTestClass:NSClassFromString(@"TestUKTrue_Negative")];
    [runner run];
    
    UKIntsEqual(0, [runner testsPassed]);
    UKIntsEqual(1, [runner testsFailed]);
    
    if ([[accumulator testFailedNotifications] count] == 1) {
        NSDictionary *dict = [[[accumulator testFailedNotifications] 
            objectAtIndex:0] userInfo];
        UKIntsEqual(31, [[dict objectForKey:@"line"] intValue]);
        UKStringsEqual(@"Got false", [dict objectForKey:@"msg"]);
        UKStringContains([dict objectForKey:@"file"], @"TestUKTrue_Negative.m");
    } else {
        UKFail();
    }
}

- (void) testUKTrue_Conditional
{
    [runner addTestClass:NSClassFromString(@"TestUKTrue_Conditional")];
    [runner run];
    
    UKIntsEqual(1, [runner testsPassed]);
    UKIntsEqual(0, [runner testsFailed]);
    
    if ([[accumulator testPassedNotifications] count] == 1) {
        NSDictionary *dict = [[[accumulator testPassedNotifications] 
            objectAtIndex:0] userInfo];
        UKIntsEqual(31, [[dict objectForKey:@"line"] intValue]);
        UKStringsEqual(@"Got true", [dict objectForKey:@"msg"]);
        UKStringContains([dict objectForKey:@"file"], 
                         @"TestUKTrue_Conditional.m");
    } else {
        UKFail();
    }    
}

- (void) testUKFalse_Positive
{
    [runner addTestClass:NSClassFromString(@"TestUKFalse_Positive")];
    [runner run];
    
    UKIntsEqual(1, [runner testsPassed]);
    UKIntsEqual(0, [runner testsFailed]);
    
    if ([[accumulator testPassedNotifications] count] == 1) {
        NSDictionary *dict = [[[accumulator testPassedNotifications] 
            objectAtIndex:0] userInfo];
        UKIntsEqual(32, [[dict objectForKey:@"line"] intValue]);
        UKStringsEqual(@"Got false", [dict objectForKey:@"msg"]);
        UKStringContains([dict objectForKey:@"file"], @"TestUKFalse_Positive.m");
    } else {
        UKFail();
    }
}

- (void) testUKFalse_Negative
{
    [runner addTestClass:NSClassFromString(@"TestUKFalse_Negative")];
    [runner run];
    
    UKIntsEqual(0, [runner testsPassed]);
    UKIntsEqual(1, [runner testsFailed]);
    
    if ([[accumulator testFailedNotifications] count] == 1) {
        NSDictionary *dict = [[[accumulator testFailedNotifications] 
            objectAtIndex:0] userInfo];
        UKIntsEqual(32, [[dict objectForKey:@"line"] intValue]);
        UKStringsEqual(@"Got true", [dict objectForKey:@"msg"]);
        UKStringContains([dict objectForKey:@"file"], @"TestUKFalse_Negative.m");
    } else {
        UKFail();
    }
}

- (void) testUKFalse_Conditional
{
    [runner addTestClass:NSClassFromString(@"TestUKFalse_Conditional")];
    [runner run];
    
    UKIntsEqual(1, [runner testsPassed]);
    UKIntsEqual(0, [runner testsFailed]);
   
    if ([[accumulator testPassedNotifications] count] == 1) {
        NSDictionary *dict = [[[accumulator testPassedNotifications] 
            objectAtIndex:0] userInfo];
        UKIntsEqual(31, [[dict objectForKey:@"line"] intValue]);
        UKStringsEqual(@"Got false", [dict objectForKey:@"msg"]);
        UKStringContains([dict objectForKey:@"file"], 
                         @"TestUKFalse_Conditional.m");
    } else {
        UKFail();
    }
    
}

- (void) testUKNil_Positive
{
    [runner addTestClass:NSClassFromString(@"TestUKNil_Positive")];
    [runner run];
    
    UKIntsEqual(1, [runner testsPassed]);
    UKIntsEqual(0, [runner testsFailed]);
    
    if ([[accumulator testPassedNotifications] count] == 1) {
        NSDictionary *dict = [[[accumulator testPassedNotifications] 
            objectAtIndex:0] userInfo];
        UKIntsEqual(31, [[dict objectForKey:@"line"] intValue]);
        UKStringsEqual(@"Got nil", [dict objectForKey:@"msg"]);
        UKStringContains([dict objectForKey:@"file"], @"TestUKNil_Positive.m");
    } else {
        UKFail();
    }
}

- (void) testUKNil_Negative
{
    [runner addTestClass:NSClassFromString(@"TestUKNil_Negative")];
    [runner run];
    
    UKIntsEqual(0, [runner testsPassed]);
    UKIntsEqual(1, [runner testsFailed]);
    
    if ([[accumulator testFailedNotifications] count] == 1) {
        NSDictionary *dict = [[[accumulator testFailedNotifications] 
            objectAtIndex:0] userInfo];
        UKIntsEqual(31, [[dict objectForKey:@"line"] intValue]);
        UKStringsEqual(@"Got \"asdf\"", 
                       [dict objectForKey:@"msg"]);
        UKStringContains([dict objectForKey:@"file"], @"TestUKNil_Negative.m");
    } else {
        UKFail();
    }
}

- (void) testUKNotNil_Positive
{
    [runner addTestClass:NSClassFromString(@"TestUKNotNil_Positive")];
    [runner run];
    
    UKIntsEqual(1, [runner testsPassed]);
    UKIntsEqual(0, [runner testsFailed]);
    
    if ([[accumulator testPassedNotifications] count] == 1) {
        NSDictionary *dict = [[[accumulator testPassedNotifications] 
            objectAtIndex:0] userInfo];
        UKIntsEqual(31, [[dict objectForKey:@"line"] intValue]);
        UKStringsEqual(@"Got \"asdf\"", 
                       [dict objectForKey:@"msg"]);
        UKStringContains([dict objectForKey:@"file"], 
                         @"TestUKNotNil_Positive.m");
    } else {
        UKFail();
    }
}

- (void) testUKNotNil_Negative
{
    [runner addTestClass:NSClassFromString(@"TestUKNotNil_Negative")];
    [runner run];
    
    UKIntsEqual(0, [runner testsPassed]);
    UKIntsEqual(1, [runner testsFailed]);
    
    if ([[accumulator testFailedNotifications] count] == 1) {
        NSDictionary *dict = [[[accumulator testFailedNotifications] 
            objectAtIndex:0] userInfo];
        UKIntsEqual(31, [[dict objectForKey:@"line"] intValue]);
        UKStringsEqual(@"Got nil", 
                       [dict objectForKey:@"msg"]);
        UKStringContains([dict objectForKey:@"file"], 
                         @"TestUKNotNil_Negative.m");
    } else {
        UKFail();
    }
}

- (void) testUKFloatsEqual_Positive
{
    [runner addTestClass:NSClassFromString(@"TestUKFloatsEqual_Positive")];
    [runner run];
    
    UKIntsEqual(1, [runner testsPassed]);
    UKIntsEqual(0, [runner testsFailed]);
    
    if ([[accumulator testPassedNotifications] count] == 1) {
        NSDictionary *dict = [[[accumulator testPassedNotifications] 
            objectAtIndex:0] userInfo];
        UKIntsEqual(31, [[dict objectForKey:@"line"] intValue]);
        // XXX sloppy compare because of float squish
        UKStringContains([dict objectForKey:@"msg"], @" == ");
        UKStringContains([dict objectForKey:@"msg"], @" within delta ");
        UKStringContains([dict objectForKey:@"file"], 
                         @"TestUKFloatsEqual_Positive.m");
    } else {
        UKFail();
    }
}

- (void) testUKFloatsEqual_Negative
{
    [runner addTestClass:NSClassFromString(@"TestUKFloatsEqual_Negative")];
    [runner run];
    
    UKIntsEqual(0, [runner testsPassed]);
    UKIntsEqual(1, [runner testsFailed]);
    
    if ([[accumulator testFailedNotifications] count] == 1) {
        NSDictionary *dict = [[[accumulator testFailedNotifications] 
            objectAtIndex:0] userInfo];
        UKIntsEqual(31, [[dict objectForKey:@"line"] intValue]);
        // XXX sloppy compare because of float squish
        UKStringContains([dict objectForKey:@"msg"], @" != ");
        UKStringContains([dict objectForKey:@"msg"], @" within delta ");
        UKStringContains([dict objectForKey:@"file"], 
                         @"TestUKFloatsEqual_Negative.m");
    } else {
        UKFail();
    }
}

- (void) testUKFloatsNotEqual_Positive
{
    [runner addTestClass:NSClassFromString(@"TestUKFloatsNotEqual_Positive")];
    [runner run];
    
    UKIntsEqual(1, [runner testsPassed]);
    UKIntsEqual(0, [runner testsFailed]);
    
    if ([[accumulator testPassedNotifications] count] == 1) {
        NSDictionary *dict = [[[accumulator testPassedNotifications] 
            objectAtIndex:0] userInfo];
        UKIntsEqual(31, [[dict objectForKey:@"line"] intValue]);
        // XXX sloppy compare because of float squish
        UKStringContains([dict objectForKey:@"msg"], @" != ");
        UKStringContains([dict objectForKey:@"msg"], @" within delta ");
        UKStringContains([dict objectForKey:@"file"], 
                         @"TestUKFloatsNotEqual_Positive.m");
    } else {
        UKFail();
    }
}

- (void) testUKFloatsNotEqual_Negative
{
    [runner addTestClass:NSClassFromString(@"TestUKFloatsNotEqual_Negative")];
    [runner run];
    
    UKIntsEqual(0, [runner testsPassed]);
    UKIntsEqual(1, [runner testsFailed]);
    
    if ([[accumulator testFailedNotifications] count] == 1) {
        NSDictionary *dict = [[[accumulator testFailedNotifications] 
            objectAtIndex:0] userInfo];
        UKIntsEqual(31, [[dict objectForKey:@"line"] intValue]);
        // XXX sloppy compare because of float squish
        UKStringContains([dict objectForKey:@"msg"], @" == ");
        UKStringContains([dict objectForKey:@"msg"], @" within delta ");
        UKStringContains([dict objectForKey:@"file"], 
                         @"TestUKFloatsNotEqual_Negative.m");
    } else {
        UKFail();
    }
}


- (void) testUKObjectsSame_Positive
{
    [runner addTestClass:NSClassFromString(@"TestUKObjectsSame_Positive")];
    [runner run];
    
    UKIntsEqual(1, [runner testsPassed]);
    UKIntsEqual(0, [runner testsFailed]);
    
    if ([[accumulator testPassedNotifications] count] == 1) {
        NSDictionary *dict = [[[accumulator testPassedNotifications] 
            objectAtIndex:0] userInfo];
        UKIntsEqual(31, [[dict objectForKey:@"line"] intValue]);
        UKStringContains([dict objectForKey:@"msg"], @" same as ");
        UKStringContains([dict objectForKey:@"file"], 
                         @"TestUKObjectsSame_Positive.m");
    } else {
        UKFail();
    }
}

- (void) testUKObjectsSame_Negative
{
    [runner addTestClass:NSClassFromString(@"TestUKObjectsSame_Negative")];
    [runner run];
    
    UKIntsEqual(0, [runner testsPassed]);
    UKIntsEqual(1, [runner testsFailed]);
    
    if ([[accumulator testFailedNotifications] count] == 1) {
        NSDictionary *dict = [[[accumulator testFailedNotifications] 
            objectAtIndex:0] userInfo];
        UKIntsEqual(31, [[dict objectForKey:@"line"] intValue]);
        UKStringContains([dict objectForKey:@"msg"], @" not same as ");
        UKStringContains([dict objectForKey:@"file"], 
                         @"TestUKObjectsSame_Negative.m");
    } else {
        UKFail();
    }
}


- (void) testUKStringContains_Positive
{
    [runner addTestClass:NSClassFromString(@"TestUKStringContains_Positive")];
    [runner run];
    
    UKIntsEqual(1, [runner testsPassed]);
    UKIntsEqual(0, [runner testsFailed]);
    
    if ([[accumulator testPassedNotifications] count] == 1) {
        NSDictionary *dict = [[[accumulator testPassedNotifications] 
            objectAtIndex:0] userInfo];
        UKIntsEqual(31, [[dict objectForKey:@"line"] intValue]);
        UKStringContains([dict objectForKey:@"msg"], @" contains ");
        UKStringContains([dict objectForKey:@"file"], 
                         @"TestUKStringContains_Positive.m");
    } else {
        UKFail();
    }
}

- (void) testUKStringContains_Negative
{
    [runner addTestClass:NSClassFromString(@"TestUKStringContains_Negative")];
    [runner run];
    
    UKIntsEqual(0, [runner testsPassed]);
    UKIntsEqual(1, [runner testsFailed]);
    
    if ([[accumulator testFailedNotifications] count] == 1) {
        NSDictionary *dict = [[[accumulator testFailedNotifications] 
            objectAtIndex:0] userInfo];
        UKIntsEqual(31, [[dict objectForKey:@"line"] intValue]);
        UKStringContains([dict objectForKey:@"msg"], @" doesn't contain ");
        UKStringContains([dict objectForKey:@"file"], 
                         @"TestUKStringContains_Negative.m");
    } else {
        UKFail();
    }
}

- (void) testUKStringDoesNotContain_Positive
{
    [runner addTestClass:NSClassFromString(@"TestUKStringDoesNotContain_Positive")];
    [runner run];
    
    UKIntsEqual(1, [runner testsPassed]);
    UKIntsEqual(0, [runner testsFailed]);
    
    if ([[accumulator testPassedNotifications] count] == 1) {
        NSDictionary *dict = [[[accumulator testPassedNotifications] 
            objectAtIndex:0] userInfo];
        UKIntsEqual(31, [[dict objectForKey:@"line"] intValue]);
        UKStringContains([dict objectForKey:@"msg"], @" doesn't contain ");
        UKStringContains([dict objectForKey:@"file"], 
                         @"TestUKStringDoesNotContain_Positive.m");
    } else {
        UKFail();
    }
}

- (void) testUKStringDoesNotContain_Negative
{
    [runner addTestClass:NSClassFromString(@"TestUKStringDoesNotContain_Negative")];
    [runner run];
    
    UKIntsEqual(0, [runner testsPassed]);
    UKIntsEqual(1, [runner testsFailed]);
    
    if ([[accumulator testFailedNotifications] count] == 1) {
        NSDictionary *dict = [[[accumulator testFailedNotifications] 
            objectAtIndex:0] userInfo];
        UKIntsEqual(31, [[dict objectForKey:@"line"] intValue]);
        UKStringContains([dict objectForKey:@"msg"], @" contains ");
        UKStringContains([dict objectForKey:@"file"], 
                         @"TestUKStringDoesNotContain_Negative.m");
    } else {
        UKFail();
    }
}

- (void) testUKRaisesException_Positive
{
    [runner addTestClass:NSClassFromString(@"TestUKRaisesException_Positive")];
    [runner run];
    
    UKIntsEqual(1, [runner testsPassed]);
    UKIntsEqual(0, [runner testsFailed]);
    
    if ([[accumulator testPassedNotifications] count] == 1) {
        NSDictionary *dict = [[[accumulator testPassedNotifications] 
            objectAtIndex:0] userInfo];
        UKIntsEqual(31, [[dict objectForKey:@"line"] intValue]);
        UKStringsEqual([dict objectForKey:@"msg"], @"Exception raised");
        UKStringContains([dict objectForKey:@"file"], 
                         @"TestUKRaisesException_Positive.m");
    } else {
        UKFail();
    }
}

- (void) testUKRaisesException_Negative
{
    [runner addTestClass:NSClassFromString(@"TestUKRaisesException_Negative")];
    [runner run];
    
    UKIntsEqual(0, [runner testsPassed]);
    UKIntsEqual(1, [runner testsFailed]);
    
    if ([[accumulator testFailedNotifications] count] == 1) {
        NSDictionary *dict = [[[accumulator testFailedNotifications] 
            objectAtIndex:0] userInfo];
        UKIntsEqual(31, [[dict objectForKey:@"line"] intValue]);
        UKStringsEqual([dict objectForKey:@"msg"], @"No exception raised");
        UKStringContains([dict objectForKey:@"file"], 
                         @"TestUKRaisesException_Negative.m");
    } else {
        UKFail();
    }
}

- (void) testUKDoesNotRaiseException_Positive
{
    [runner 
        addTestClass:NSClassFromString(@"TestUKDoesNotRaiseException_Positive")];
    [runner run];
    
    UKIntsEqual(1, [runner testsPassed]);
    UKIntsEqual(0, [runner testsFailed]);
    
    if ([[accumulator testPassedNotifications] count] == 1) {
        NSDictionary *dict = [[[accumulator testPassedNotifications] 
            objectAtIndex:0] userInfo];
        UKIntsEqual(31, [[dict objectForKey:@"line"] intValue]);
        UKStringsEqual([dict objectForKey:@"msg"], @"No exception raised");
        UKStringContains([dict objectForKey:@"file"], 
                         @"TestUKDoesNotRaiseException_Positive.m");
    } else {
        UKFail();
    }
}

- (void) testUKDoesNotRaiseException_Negative
{
    [runner 
        addTestClass:NSClassFromString(@"TestUKDoesNotRaiseException_Negative")];
    [runner run];
    
    UKIntsEqual(0, [runner testsPassed]);
    UKIntsEqual(1, [runner testsFailed]);
    
    if ([[accumulator testFailedNotifications] count] == 1) {
        NSDictionary *dict = [[[accumulator testFailedNotifications] 
            objectAtIndex:0] userInfo];
        UKIntsEqual(31, [[dict objectForKey:@"line"] intValue]);
        UKStringsEqual([dict objectForKey:@"msg"], @"Exception raised");
        UKStringContains([dict objectForKey:@"file"], 
                         @"TestUKDoesNotRaiseException_Negative.m");
    } else {
        UKFail();
    }
}

- (void) testUKRaisesExceptionNamed_Positive
{
    [runner     
        addTestClass:NSClassFromString(@"TestUKRaisesExceptionNamed_Positive")];
    [runner run];
    
    UKIntsEqual(1, [runner testsPassed]);
    UKIntsEqual(0, [runner testsFailed]);
    
    if ([[accumulator testPassedNotifications] count] == 1) {
        NSDictionary *dict = [[[accumulator testPassedNotifications] 
            objectAtIndex:0] userInfo];
        UKIntsEqual(32, [[dict objectForKey:@"line"] intValue]);
        UKStringsEqual([dict objectForKey:@"msg"],
                       @"Exception named Foo was raised");
        UKStringContains([dict objectForKey:@"file"], 
                         @"TestUKRaisesExceptionNamed_Positive.m");
    } else {
        UKFail();
    }
}

- (void) testUKRaisesExceptionNamed_Negative
{
    [runner 
        addTestClass:NSClassFromString(@"TestUKRaisesExceptionNamed_Negative")];
    [runner run];
    
    UKIntsEqual(0, [runner testsPassed]);
    UKIntsEqual(1, [runner testsFailed]);
    
    if ([[accumulator testFailedNotifications] count] == 1) {
        NSDictionary *dict = [[[accumulator testFailedNotifications] 
            objectAtIndex:0] userInfo];
        UKIntsEqual(31, [[dict objectForKey:@"line"] intValue]);
        UKStringsEqual([dict objectForKey:@"msg"],
                       @"Exception named Bar was not raised, got Foo");
        UKStringContains([dict objectForKey:@"file"], 
                         @"TestUKRaisesExceptionNamed_Negative.m");
    } else {
        UKFail();
    }
}

- (void) testUKRaisesExceptionNamed_NoException
{
    [runner 
        addTestClass:NSClassFromString(
                                    @"TestUKRaisesExceptionNamed_NoException")];
    [runner run];
    
    UKIntsEqual(0, [runner testsPassed]);
    UKIntsEqual(1, [runner testsFailed]);
    
    if ([[accumulator testFailedNotifications] count] == 1) {
        NSDictionary *dict = [[[accumulator testFailedNotifications] 
            objectAtIndex:0] userInfo];
        UKIntsEqual(31, [[dict objectForKey:@"line"] intValue]);
        UKStringsEqual([dict objectForKey:@"msg"],
                       @"Exception named Foo was not raised");
        UKStringContains([dict objectForKey:@"file"], 
                         @"TestUKRaisesExceptionNamed_NoException.m");
    } else {
        UKFail();
    }
}

- (void) testUKRaisesExceptionClass_Positive
{
    [runner addTestClass:
        NSClassFromString(@"TestUKRaisesExceptionClass_Positive")];
    [runner run];
    
    UKIntsEqual(1, [runner testsPassed]);
    UKIntsEqual(0, [runner testsFailed]);
    
    if ([[accumulator testPassedNotifications] count] == 1) {
        NSDictionary *dict = [[[accumulator testPassedNotifications] 
            objectAtIndex:0] userInfo];
        UKIntsEqual(36, [[dict objectForKey:@"line"] intValue]);
        UKStringsEqual([dict objectForKey:@"msg"], 
                       @"Exception TestUKRaisesExceptionClass_Positive was raised");
        UKStringContains([dict objectForKey:@"file"], 
                         @"TestUKRaisesExceptionClass_Positive.m");
    } else {
        UKFail();
    }
}

- (void) testUKRaisesExceptionClass_Negative
{
    [runner addTestClass:
        NSClassFromString(@"TestUKRaisesExceptionClass_Negative")];
    [runner run];
    
    UKIntsEqual(0, [runner testsPassed]);
    UKIntsEqual(1, [runner testsFailed]);
    
    if ([[accumulator testFailedNotifications] count] == 1) {
        NSDictionary *dict = [[[accumulator testFailedNotifications] 
            objectAtIndex:0] userInfo];
        UKIntsEqual(36, [[dict objectForKey:@"line"] intValue]);
        UKStringsEqual([dict objectForKey:@"msg"],
                       @"Exception NSThread was not raised, got TestUKRaisesExceptionClass_Negative");
        UKStringContains([dict objectForKey:@"file"], 
                         @"TestUKRaisesExceptionClass_Negative.m");
    } else {
        UKFail();
    }
}

- (void) testUKRaisesExceptionClass_NoException
{
    [runner addTestClass:
        NSClassFromString(@"TestUKRaisesExceptionClass_NoException")];
    [runner run];
    
    UKIntsEqual(0, [runner testsPassed]);
    UKIntsEqual(1, [runner testsFailed]);
    
    if ([[accumulator testFailedNotifications] count] == 1) {
        NSDictionary *dict = [[[accumulator testFailedNotifications] 
            objectAtIndex:0] userInfo];
        UKIntsEqual(37, [[dict objectForKey:@"line"] intValue]);
        UKStringsEqual([dict objectForKey:@"msg"],
                       @"Exception NSThread was not raised");
        UKStringContains([dict objectForKey:@"file"], 
                         @"TestUKRaisesExceptionClass_NoException.m");
    } else {
        UKFail();
    }
}

@end
