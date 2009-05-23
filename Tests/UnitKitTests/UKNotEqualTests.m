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

#import "UKNotEqualTests.h"

@implementation UKNotEqualTests

#pragma mark LIFECYCLE

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

#pragma mark HELPER METHODS

- (void) runHelperMethodNamed:(NSString *)methodName
{
    NSArray *testMethodArray = [NSArray arrayWithObject:methodName];
    [runner performSelector:@selector(runTests:onClass:) 
                 withObject:testMethodArray withObject:[self class]];
}

- (NSString *) lastMessage 
{
    // this only works because we test only one macro at a time.
    
    if ([runner testsPassed] > 0) {
        return [[[[accumulator testPassedNotifications] objectAtIndex:0] 
            userInfo] objectForKey:@"msg"];
    } else if ([runner testsFailed] > 0){
        return [[[[accumulator testFailedNotifications] objectAtIndex:0] 
            userInfo] objectForKey:@"msg"];        
    } else {
        return @"";
    }
}

#pragma mark TEST METHODS

- (void) xtestLineNumberReporting
{
    UKNotEqual(1, 0);
}

- (void) testLineNumberReporting
{
    [self runHelperMethodNamed:@"xtestLineNumberReporting"];
    if ([[accumulator testPassedNotifications] count] == 1) {
        NSDictionary *dict = [[[accumulator testPassedNotifications] 
            objectAtIndex:0] userInfo];
        NSAssert([[dict objectForKey:@"line"] intValue] == 75, 
                 @"UKNotEqualTests testLineNumberReporting failed");
    } else {
        NSAssert(NO, @"UKNotEqualTests testLineNumberReporting failed");
    }     
}

- (void) xtestFilenameReporting
{
    UKNotEqual(1, 0);
}

- (void) testFilenameReporting
{
    [self runHelperMethodNamed:@"xtestFilenameReporting"];
    if ([[accumulator testPassedNotifications] count] == 1) {
        NSDictionary *dict = [[[accumulator testPassedNotifications] 
            objectAtIndex:0] userInfo];
        NSAssert([[dict objectForKey:@"file"] 
                    rangeOfString:@"UKNotEqualTests.m"].location > 0, 
                 @"UKNotEqualTests testFilenameReporting failed");
    } else {
        NSAssert(NO, @"UKNotEqualTests testFilenameReporting failed");
    }     
}

#pragma mark char

- (void) xTestCharsPositive
{
    char a = 'c';
    char b = 'd';
    UKNotEqual(a, b);
}

- (void) testCharsPositive
{
    [self runHelperMethodNamed:@"xTestCharsPositive"];    
    UKEqual(1, [runner testsPassed]);
    UKEqual(0, [runner testsFailed]);
    UKEqual(@"c != d", [self lastMessage]);
}

- (void) xTestCharsNegative
{
    char a = 'c';
    char b = 'c';
    UKNotEqual(a, b);
}

- (void) testCharsNegative 
{
    [self runHelperMethodNamed:@"xTestCharsNegative"];    
    UKEqual(0, [runner testsPassed]);
    UKEqual(1, [runner testsFailed]);
    UKEqual(@"c == c", [self lastMessage]);
}

- (void) xTestUnsignedCharsPositive
{
    unsigned char a = 'c';
    unsigned char b = 'd';
    UKNotEqual(a, b);
}

- (void) testUnsignedCharsPositive
{
    [self runHelperMethodNamed:@"xTestUnsignedCharsPositive"];  
    UKEqual(1, [runner testsPassed]);
    UKEqual(0, [runner testsFailed]);
    UKEqual(@"c != d", [self lastMessage]);
}

- (void) xTestUnsignedCharsNegative
{
    unsigned char a = 'c';
    unsigned char b = 'c';
    UKNotEqual(a, b);
}

- (void) testUnsignedCharsNegative 
{
    [self runHelperMethodNamed:@"xTestUnsignedCharsNegative"];    
    UKEqual(0, [runner testsPassed]);
    UKEqual(1, [runner testsFailed]);
    UKEqual(@"c == c", [self lastMessage]);
}

#pragma mark int

- (void) xtestIntsPositive
{
    int a = 1;
    int b = 0;
    UKNotEqual(a, b);
}

- (void) testIntsPositive
{
    [self runHelperMethodNamed:@"xtestIntsPositive"];    
    UKEqual(1, [runner testsPassed]);
    UKEqual(0, [runner testsFailed]);
    UKEqual(@"1 != 0", [self lastMessage]);
}

- (void) xtestIntsNegative
{
    int a = 1;
    int b = 1;
    UKNotEqual(a, b);
}

- (void) testIntsNegative
{
    [self runHelperMethodNamed:@"xtestIntsNegative"];    
    UKEqual(0, [runner testsPassed]);
    UKEqual(1, [runner testsFailed]);
    UKEqual(@"1 == 1", [self lastMessage]);
}

- (void) xtestUnsignedIntsPositive
{
    unsigned int a = 1;
    unsigned int b = 0;
    UKNotEqual(a, b);
}

- (void) testUnsignedIntsPositive
{
    [self runHelperMethodNamed:@"xtestUnsignedIntsPositive"];    
    UKEqual(1, [runner testsPassed]);
    UKEqual(0, [runner testsFailed]);
    UKEqual(@"1 != 0", [self lastMessage]);
}

- (void) xtestUnsignedIntsNegative
{
    unsigned int a = 1;
    unsigned int b = 1;
    UKNotEqual(a, b);
}

- (void) testUnsignedIntsNegative
{
    [self runHelperMethodNamed:@"xtestUnsignedIntsNegative"];    
    UKEqual(0, [runner testsPassed]);
    UKEqual(1, [runner testsFailed]);
    UKEqual(@"1 == 1", [self lastMessage]);
}

#pragma mark long

- (void) xtestLongsPositive
{
    long a = 1;
    long b = 0;
    UKNotEqual(a, b);
}

- (void) testLongsPositive
{
    [self runHelperMethodNamed:@"xtestLongsPositive"];    
    UKEqual(1, [runner testsPassed]);
    UKEqual(0, [runner testsFailed]);
    UKEqual(@"1 != 0", [self lastMessage]);
}

- (void) xtestLongsNegative
{
    long a = 1;
    long b = 1;
    UKNotEqual(a, b);
}

- (void) testLongsNegative
{
    [self runHelperMethodNamed:@"xtestLongsNegative"];    
    UKEqual(0, [runner testsPassed]);
    UKEqual(1, [runner testsFailed]);
    UKEqual(@"1 == 1", [self lastMessage]);
}

- (void) xtestUnsignedLongsPositive
{
    unsigned long a = 1;
    unsigned long b = 0;
    UKNotEqual(a, b);
}

- (void) testUnsignedLongsPositive
{
    [self runHelperMethodNamed:@"xtestUnsignedLongsPositive"];    
    UKEqual(1, [runner testsPassed]);
    UKEqual(0, [runner testsFailed]);
    UKEqual(@"1 != 0", [self lastMessage]);
}

- (void) xtestUnsignedLongsNegative
{
    unsigned long a = 1;
    unsigned long b = 1;
    UKNotEqual(a, b);
}

- (void) testUnsignedLongsNegative
{
    [self runHelperMethodNamed:@"xtestUnsignedLongsNegative"];    
    UKEqual(0, [runner testsPassed]);
    UKEqual(1, [runner testsFailed]);
    UKEqual(@"1 == 1", [self lastMessage]);
}

#pragma mark short

- (void) xtestShortsPositive
{
    short a = 1;
    short b = 0;
    UKNotEqual(a, b);
}

- (void) testShortsPositive
{
    [self runHelperMethodNamed:@"xtestShortsPositive"];    
    UKEqual(1, [runner testsPassed]);
    UKEqual(0, [runner testsFailed]);
    UKEqual(@"1 != 0", [self lastMessage]);
}

- (void) xtestShortsNegative
{
    short a = 1;
    short b = 1;
    UKNotEqual(a, b);
}

- (void) testShortsNegative
{
    [self runHelperMethodNamed:@"xtestShortsNegative"];    
    UKEqual(0, [runner testsPassed]);
    UKEqual(1, [runner testsFailed]);
    UKEqual(@"1 == 1", [self lastMessage]);
}

- (void) xtestUnsignedShortsPositive
{
    unsigned short a = 1;
    unsigned short b = 0;
    UKNotEqual(a, b);
}

- (void) testUnsignedShortsPositive
{
    [self runHelperMethodNamed:@"xtestUnsignedShortsPositive"];    
    UKEqual(1, [runner testsPassed]);
    UKEqual(0, [runner testsFailed]);
    UKEqual(@"1 != 0", [self lastMessage]);
}

- (void) xtestUnsignedShortsNegative
{
    unsigned short a = 1;
    unsigned short b = 1;
    UKNotEqual(a, b);
}

- (void) testUnsignedShortsNegative
{
    [self runHelperMethodNamed:@"xtestUnsignedShortsNegative"];        
    UKEqual(0, [runner testsPassed]);
    UKEqual(1, [runner testsFailed]);
    UKEqual(@"1 == 1", [self lastMessage]);
}

#pragma mark float

- (void) xtestFloatsPositive
{
    float a = 2.12;
    float b = 2.13;
    UKNotEqual(a, b);
}

- (void) testFloatsPositive
{
    [self runHelperMethodNamed:@"xtestFloatsPositive"];    
    UKEqual(1, [runner testsPassed]);
    UKEqual(0, [runner testsFailed]);
    UKEqual(@"2.120000 != 2.130000", [self lastMessage]);
}

- (void) xtestFloatsNegative
{
    float a = 2.12;
    float b = 2.12;
    UKNotEqual(a, b);
}

- (void) testFloatsNegative
{
    [self runHelperMethodNamed:@"xtestFloatsNegative"]; 
    UKEqual(0, [runner testsPassed]);
    UKEqual(1, [runner testsFailed]);
    UKEqual(@"2.120000 == 2.120000", [self lastMessage]);

}

#pragma mark double

- (void) xtestDoublesPositive
{
    double a = 6.022e+23;
    double b = 1.380e-23;
    UKNotEqual(a, b);
}

- (void) testDoublesPositive
{
    [self runHelperMethodNamed:@"xtestDoublesPositive"];    
    UKEqual(1, [runner testsPassed]);
    UKEqual(0, [runner testsFailed]);
    UKEqual(@"6.022e+23 != 1.38e-23", [self lastMessage]);
}

- (void) xtestDoublesNegative
{
    double a = 6.022e+23;
    double b = 6.022e+23;
    UKNotEqual(a, b);
}


- (void) testDoublesNegative
{
    [self runHelperMethodNamed:@"xtestDoublesNegative"];    
    UKEqual(0, [runner testsPassed]);
    UKEqual(1, [runner testsFailed]);
    UKEqual(@"6.022e+23 == 6.022e+23", [self lastMessage]);
}


#pragma mark bool

- (void) xtestBoolsPositive
{
    bool a = true;
    bool b = false;
    UKNotEqual(a, b);
}

- (void) testBoolsPositive
{
    [self runHelperMethodNamed:@"xtestBoolsPositive"];    
    UKEqual(1, [runner testsPassed]);
    UKEqual(0, [runner testsFailed]);
    UKEqual(@"true != false", [self lastMessage]);
}

- (void) xtestBoolsNegative
{
    bool a = true;
    bool b = true;
    UKNotEqual(a, b);
}


- (void) testBoolsNegative
{
    [self runHelperMethodNamed:@"xtestBoolsNegative"];    
    UKEqual(0, [runner testsPassed]);
    UKEqual(1, [runner testsFailed]);
    UKEqual(@"true == true", [self lastMessage]);
}

- (void) xtest_BoolsPositive
{
    _Bool a = true;
    _Bool b = false;
    UKNotEqual(a, b);
}

- (void) test_BoolsPositive
{
    [self runHelperMethodNamed:@"xtest_BoolsPositive"];    
    UKEqual(1, [runner testsPassed]);
    UKEqual(0, [runner testsFailed]);
    UKEqual(@"true != false", [self lastMessage]);
}

- (void) xtest_BoolsNegative
{
    _Bool a = true;
    _Bool b = true;
    UKNotEqual(a, b);
}


- (void) test_BoolsNegative
{
    [self runHelperMethodNamed:@"xtest_BoolsNegative"];    
    UKEqual(0, [runner testsPassed]);
    UKEqual(1, [runner testsFailed]);
    UKEqual(@"true == true", [self lastMessage]);
}

#pragma mark char *

- (void) xtestCharStarsPositive
{
    char *a = "foo";
    char *b = "bar";
    UKNotEqual(a, b);
}

- (void) testCharStarsPositive
{
    [self runHelperMethodNamed:@"xtestCharStarsPositive"];    
    UKEqual(1, [runner testsPassed]);
    UKEqual(0, [runner testsFailed]);
    UKEqual(@"\"foo\" != \"bar\"", [self lastMessage]);
}

- (void) xtestCharStarsNegative
{
    char *a = "foo";
    char *b = "foo";
    UKNotEqual(a, b);
}


- (void) testCharStarsNegative
{
    [self runHelperMethodNamed:@"xtestCharStarsNegative"];    
    UKEqual(0, [runner testsPassed]);
    UKEqual(1, [runner testsFailed]);
    UKEqual(@"\"foo\" == \"foo\"", [self lastMessage]);
}

#pragma mark array

/*
 XXX not testing yet. Preprocessing is busted on the machine I'm using, so I
 need to look at it on a different machine
 - (void) xtestArraysPositive
 {
     int a[] = {1, 2, 3};
     int b[] = {1, 2, 3};
     UKNotEqual(a, b);
 }
 
 - (void) testArraysPositive
 {
     [self runHelperMethodNamed:@"xtestArraysPositive"];    
     NSAssert(1 == [runner testsPassed],
              @"UKNotEqualTests testArraysPositive failed");
     NSAssert(0 == [runner testsFailed],
              @"UKNotEqualTests testArraysPositive failed");
     // XXX no message check yet -- hard to do
 }
 
 - (void) xtestArraysNegative
 {
     int a[] = {1, 2, 3};
     int b[] = {3, 2, 1};
     UKNotEqual(a, b);
 }
 
 
 - (void) testArraysNegative
 {
     [self runHelperMethodNamed:@"xtestArraysNegative"];    
     NSAssert(0 == [runner testsPassed],
              @"UKNotEqualTests testArraysNegative failed");
     NSAssert(1 == [runner testsFailed],
              @"UKNotEqualTests testArraysNegative failed");
     // XXX no message check yet -- hard to do
 }
 */

#pragma mark struct

- (void) xtestStructsPositive
{
    NSRange a = NSMakeRange(0, 1);
    NSRange b = NSMakeRange(1, 2);
    UKNotEqual(a, b);
}

- (void) testStructsPositive
{
    [self runHelperMethodNamed:@"xtestStructsPositive"];    
    UKEqual(1, [runner testsPassed]);
    UKEqual(0, [runner testsFailed]);
    // XXX no message check yet -- hard to do
}

- (void) xtestStructsNegative
{
    NSRange a = NSMakeRange(0, 1);
    NSRange b = NSMakeRange(0, 1);
    UKNotEqual(a, b);
}

- (void) testStructsNegative
{
    [self runHelperMethodNamed:@"xtestStructsNegative"];    
    UKEqual(0, [runner testsPassed]);
    UKEqual(1, [runner testsFailed]);
    // XXX no message check yet -- hard to do
}

#pragma mark union

// XXX not yet implemented

#pragma mark bit field

// XXX not yet implemented

#pragma mark pointer to type

// XXX not yet implemented

#pragma mark id

- (void) xtestIdsPositive
{
    id a = self;
    id b = [NSArray array];
    UKNotEqual(a, b);
}

- (void) testIdsPositive
{
    [self runHelperMethodNamed:@"xtestIdsPositive"];    
    UKEqual(1, [runner testsPassed]);
    UKEqual(0, [runner testsFailed]);
    // XXX no message check yet -- hard to do
}

- (void) xtestIdsNegative
{
    id a = self;
    id b = self;
    UKNotEqual(a, b);
}


- (void) testIdsNegative
{
    [self runHelperMethodNamed:@"xtestIdsNegative"];    
    UKEqual(0, [runner testsPassed]);
    UKEqual(1, [runner testsFailed]);
    // XXX no message check yet -- hard to do
}

#pragma mark Class

- (void) xtestClassesPositive
{
    Class a = [self class];
    Class b = [NSArray class];
    UKNotEqual(a, b);
}

- (void) testClassesPositive
{
    [self runHelperMethodNamed:@"xtestClassesPositive"];    
    UKEqual(1, [runner testsPassed]);
    UKEqual(0, [runner testsFailed]);
    // XXX no message check yet -- hard to do
}

- (void) xtestClassesNegative
{
    Class a = [self class];
    Class b = [self class];
    UKNotEqual(a, b);
}


- (void) testClassesNegative
{
    [self runHelperMethodNamed:@"xtestClassesNegative"];    
    UKEqual(0, [runner testsPassed]);
    UKEqual(1, [runner testsFailed]);
    // XXX no message check yet -- hard to do
}

#pragma mark SEL

- (void) xtestSELsPositive
{
    SEL a = _cmd;
    SEL b = NSSelectorFromString(@"description");
    UKNotEqual(a, b);
}

- (void) testSELsPositive
{
    [self runHelperMethodNamed:@"xtestSELsPositive"];    
    UKEqual(1, [runner testsPassed]);
    UKEqual(0, [runner testsFailed]);
    // XXX no message check yet -- hard to do
}

- (void) xtestSELsNegative
{
    SEL a = _cmd;
    SEL b = _cmd;
    UKNotEqual(a, b);
}


- (void) testSELsNegative
{
    [self runHelperMethodNamed:@"xtestSELsNegative"];    
    UKEqual(0, [runner testsPassed]);
    UKEqual(1, [runner testsFailed]);
    // XXX no message check yet -- hard to do
}

#pragma mark NSString *

- (void) xtestNSStringsPositive
{
    NSString *a = @"foo";
    NSString *b = @"bar";
    UKNotEqual(a, b);
}

- (void) testNSStringsPositive
{
    [self runHelperMethodNamed:@"xtestNSStringsPositive"];    
    UKEqual(1, [runner testsPassed]);
    UKEqual(0, [runner testsFailed]);
    UKEqual(@"\"foo\" != \"bar\"", [self lastMessage]);
}

- (void) xtestNSStringsNegative
{
    NSString *a = @"foo";
    NSString *b = @"foo";
    UKNotEqual(a, b);
}


- (void) testNSStringsNegative
{
    [self runHelperMethodNamed:@"xtestNSStringsNegative"];    
    UKEqual(0, [runner testsPassed]);
    UKEqual(1, [runner testsFailed]);
    UKEqual(@"\"foo\" == \"foo\"", [self lastMessage]);
}


@end
