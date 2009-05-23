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

#import "UKEqualTests.h"

@implementation UKEqualTests

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
    UKEqual(1, 1);
}

- (void) testLineNumberReporting
{
    [self runHelperMethodNamed:@"xtestLineNumberReporting"];
    if ([[accumulator testPassedNotifications] count] == 1) {
        NSDictionary *dict = [[[accumulator testPassedNotifications] 
            objectAtIndex:0] userInfo];
        NSAssert([[dict objectForKey:@"line"] intValue] == 75, 
                 @"UKEqualTests testLineNumberReporting failed");
    } else {
        NSAssert(NO, @"UKEqualTests testLineNumberReporting failed");
    }     
}

- (void) xtestFilenameReporting
{
    UKEqual(1, 1);
}

- (void) testFilenameReporting
{
    [self runHelperMethodNamed:@"xtestFilenameReporting"];
    if ([[accumulator testPassedNotifications] count] == 1) {
        NSDictionary *dict = [[[accumulator testPassedNotifications] 
            objectAtIndex:0] userInfo];
        NSAssert([[dict objectForKey:@"file"] 
                    rangeOfString:@"UKEqualTests.m"].location > 0, 
                 @"UKEqualTests testFilenameReporting failed");
    } else {
        NSAssert(NO, @"UKEqualTests testFilenameReporting failed");
    }     
}

#pragma mark char

- (void) xTestCharsPositive
{
    char a = 'c';
    char b = 'c';
    UKEqual(a, b);
}

- (void) testCharsPositive
{
    [self runHelperMethodNamed:@"xTestCharsPositive"];    
    NSAssert(1 == [runner testsPassed], 
             @"UKEqualTests testCharsPositive failed");
    NSAssert(0 == [runner testsFailed],
             @"UKEqualTests testCharsPositive failed");
    NSAssert([@"c == c" isEqualToString:[self lastMessage]],
             @"UKEqualTests testCharsPositive failed");
}

- (void) xTestCharsNegative
{
    char a = 'c';
    char b = 'b';
    UKEqual(a, b);
}

- (void) testCharsNegative 
{
    [self runHelperMethodNamed:@"xTestCharsNegative"];    
    NSAssert(0 == [runner testsPassed],
             @"UKEqualTests testCharsNegative failed");
    NSAssert(1 == [runner testsFailed],
             @"UKEqualTests testCharsNegative failed");
    NSAssert([@"c != b" isEqualToString:[self lastMessage]],
             @"UKEqualTests testCharsNegative failed");
}

- (void) xTestUnsignedCharsPositive
{
    unsigned char a = 'c';
    unsigned char b = 'c';
    UKEqual(a, b);
}

- (void) testUnsignedCharsPositive
{
    [self runHelperMethodNamed:@"xTestUnsignedCharsPositive"];    
    NSAssert(1 == [runner testsPassed],
             @"UKEqualTests testUnsignedCharsPositive failed");
    NSAssert(0 == [runner testsFailed],
             @"UKEqualTests testUnsignedCharsPositive failed");
    NSAssert([@"c == c" isEqualToString:[self lastMessage]],
             @"UKEqualTests testUnsignedCharsPositive failed");
}

- (void) xTestUnsignedCharsNegative
{
    unsigned char a = 'c';
    unsigned char b = 'b';
    UKEqual(a, b);
}

- (void) testUnsignedCharsNegative 
{
    [self runHelperMethodNamed:@"xTestUnsignedCharsNegative"];    
    NSAssert(0 == [runner testsPassed],
             @"UKEqualTests testUnsignedCharsNegative failed");
    NSAssert(1 == [runner testsFailed],
             @"UKEqualTests testUnsignedCharsNegative failed");
    NSAssert([@"c != b" isEqualToString:[self lastMessage]],
             @"UKEqualTests testUnsignedCharsNegative failed");
}

#pragma mark int

- (void) xtestIntsPositive
{
    int a = 1;
    int b = 1;
    UKEqual(a, b);
}

- (void) testIntsPositive
{
    [self runHelperMethodNamed:@"xtestIntsPositive"];    
    NSAssert(1 == [runner testsPassed],
             @"UKEqualTests testIntsPositive failed");
    NSAssert(0 == [runner testsFailed],
             @"UKEqualTests testIntsPositive failed");
    NSAssert([@"1 == 1" isEqualToString:[self lastMessage]],
             @"UKEqualTests testIntsPositive failed");
}

- (void) xtestIntsNegative
{
    int a = 1;
    int b = 0;
    UKEqual(a, b);
}

- (void) testIntsNegative
{
    [self runHelperMethodNamed:@"xtestIntsNegative"];    
    NSAssert(0 == [runner testsPassed],
             @"UKEqualTests testIntsNegative failed");
    NSAssert(1 == [runner testsFailed],
             @"UKEqualTests testIntsNegative failed");
    NSAssert([@"1 != 0" isEqualToString:[self lastMessage]],
             @"UKEqualTests testIntsNegative failed");
}

- (void) xtestUnsignedIntsPositive
{
    unsigned int a = 1;
    unsigned int b = 1;
    UKEqual(a, b);
}

- (void) testUnsignedIntsPositive
{
    [self runHelperMethodNamed:@"xtestUnsignedIntsPositive"];    
    NSAssert(1 == [runner testsPassed],
             @"UKEqualTests testUnsignedIntsPositive failed");
    NSAssert(0 == [runner testsFailed],
             @"UKEqualTests testUnsignedIntsPositive failed");
    NSAssert([@"1 == 1" isEqualToString:[self lastMessage]],
             @"UKEqualTests testUnsignedIntsPositive failed");
}

- (void) xtestUnsignedIntsNegative
{
    unsigned int a = 1;
    unsigned int b = 0;
    UKEqual(a, b);
}

- (void) testUnsignedIntsNegative
{
    [self runHelperMethodNamed:@"xtestUnsignedIntsNegative"];    
    NSAssert(0 == [runner testsPassed],
             @"UKEqualTests testUnsignedIntsNegative failed");
    NSAssert(1 == [runner testsFailed],
             @"UKEqualTests testUnsignedIntsNegative failed");
    NSAssert([@"1 != 0" isEqualToString:[self lastMessage]],
             @"UKEqualTests testUnsignedIntsNegative failed");
}
/*
- (void) xtestMixedIntsPositive
{
    int a = 1;
    unsigned int b = 1;
    UKEqual(a, b);
}

- (void) testMixedIntsPositive
{
    [self runHelperMethodNamed:@"xtestMixedIntsPositive"];    
    NSAssert(1 == [runner testsPassed],
             @"UKEqualTests testMixedIntsPositive failed");
    NSAssert(0 == [runner testsFailed],
             @"UKEqualTests testMixedIntsPositive failed");
    NSAssert([@"1 == 1" isEqualToString:[self lastMessage]],
             @"UKEqualTests testMixedIntsPositive failed");
}
*/
#pragma mark long

- (void) xtestLongsPositive
{
    long a = 1;
    long b = 1;
    UKEqual(a, b);
}

- (void) testLongsPositive
{
    [self runHelperMethodNamed:@"xtestLongsPositive"];    
    NSAssert(1 == [runner testsPassed],
             @"UKEqualTests testLongsPositive failed");
    NSAssert(0 == [runner testsFailed],
             @"UKEqualTests testLongsPositive failed");
    NSAssert([@"1 == 1" isEqualToString:[self lastMessage]],
             @"UKEqualTests testLongsPositive failed");
}

- (void) xtestLongsNegative
{
    long a = 1;
    long b = 0;
    UKEqual(a, b);
}

- (void) testLongsNegative
{
    [self runHelperMethodNamed:@"xtestLongsNegative"];    
    NSAssert(0 == [runner testsPassed],
             @"UKEqualTests testLongsNegative failed");
    NSAssert(1 == [runner testsFailed],
             @"UKEqualTests testLongsNegative failed");
    NSAssert([@"1 != 0" isEqualToString:[self lastMessage]],
             @"UKEqualTests testLongsNegative failed");
}

- (void) xtestUnsignedLongsPositive
{
    unsigned long a = 1;
    unsigned long b = 1;
    UKEqual(a, b);
}

- (void) testUnsignedLongsPositive
{
    [self runHelperMethodNamed:@"xtestUnsignedLongsPositive"];    
    NSAssert(1 == [runner testsPassed],
             @"UKEqualTests testUnsignedLongsPositive failed");
    NSAssert(0 == [runner testsFailed],
             @"UKEqualTests testUnsignedLongsPositive failed");
    NSAssert([@"1 == 1" isEqualToString:[self lastMessage]],
             @"UKEqualTests testUnsignedLongsPositive failed");
}

- (void) xtestUnsignedLongsNegative
{
    unsigned long a = 1;
    unsigned long b = 0;
    UKEqual(a, b);
}

- (void) testUnsignedLongsNegative
{
    [self runHelperMethodNamed:@"xtestUnsignedLongsNegative"];    
    NSAssert(0 == [runner testsPassed],
             @"UKEqualTests testUnsignedLongsNegative failed");
    NSAssert(1 == [runner testsFailed],
             @"UKEqualTests testUnsignedLongsNegative failed");
    NSAssert([@"1 != 0" isEqualToString:[self lastMessage]],
             @"UKEqualTests testUnsignedLongsNegative failed");
}

#pragma mark short

- (void) xtestShortsPositive
{
    short a = 1;
    short b = 1;
    UKEqual(a, b);
}

- (void) testShortsPositive
{
    [self runHelperMethodNamed:@"xtestShortsPositive"];    
    NSAssert(1 == [runner testsPassed],
             @"UKEqualTests testShortsPositive failed");
    NSAssert(0 == [runner testsFailed],
             @"UKEqualTests testShortsPositive failed");
    NSAssert([@"1 == 1" isEqualToString:[self lastMessage]],
             @"UKEqualTests testShortsPositive failed");
}

- (void) xtestShortsNegative
{
    short a = 1;
    short b = 0;
    UKEqual(a, b);
}

- (void) testShortsNegative
{
    [self runHelperMethodNamed:@"xtestShortsNegative"];    
    NSAssert(0 == [runner testsPassed],
             @"UKEqualTests testShortsNegative failed");
    NSAssert(1 == [runner testsFailed],
             @"UKEqualTests testShortsNegative failed");
    NSAssert([@"1 != 0" isEqualToString:[self lastMessage]],
             @"UKEqualTests testShortsNegative failed");
}

- (void) xtestUnsignedShortsPositive
{
    unsigned short a = 1;
    unsigned short b = 1;
    UKEqual(a, b);
}

- (void) testUnsignedShortsPositive
{
    [self runHelperMethodNamed:@"xtestUnsignedShortsPositive"];    
    NSAssert(1 == [runner testsPassed],
             @"UKEqualTests testUnsignedShortsPositive failed");
    NSAssert(0 == [runner testsFailed],
             @"UKEqualTests testUnsignedShortsPositive failed");
    NSAssert([@"1 == 1" isEqualToString:[self lastMessage]],
             @"UKEqualTests testUnsignedShortsPositive failed");
}

- (void) xtestUnsignedShortsNegative
{
    unsigned short a = 1;
    unsigned short b = 0;
    UKEqual(a, b);
}

- (void) testUnsignedShortsNegative
{
    [self runHelperMethodNamed:@"xtestUnsignedShortsNegative"];    
    NSAssert(0 == [runner testsPassed],
             @"UKEqualTests testUnsignedShortsNegative failed");
    NSAssert(1 == [runner testsFailed],
             @"UKEqualTests testUnsignedShortsNegative failed");
    NSAssert([@"1 != 0" isEqualToString:[self lastMessage]],
             @"UKEqualTests testUnsignedShortsNegative failed");
}

#pragma mark float

- (void) xtestFloatsPositive
{
    float a = 2.12;
    float b = 2.12;
    UKEqual(a, b);
}

- (void) testFloatsPositive
{
    [self runHelperMethodNamed:@"xtestFloatsPositive"];    
    NSAssert(1 == [runner testsPassed],
             @"UKEqualTests testFloatsPositive failed");
    NSAssert(0 == [runner testsFailed],
             @"UKEqualTests testFloatsPositive failed");
    NSAssert([@"2.120000 == 2.120000" isEqualToString:[self lastMessage]],
             @"UKEqualTests testFloatsPositive failed");
}

- (void) xtestFloatsNegative
{
    float a = 2.12;
    float b = 2.13;
    UKEqual(a, b);
}

- (void) testFloatsNegative
{
    [self runHelperMethodNamed:@"xtestFloatsNegative"];    
    NSAssert(0 == [runner testsPassed],
             @"UKEqualTests testFloatsNegative failed");
    NSAssert(1 == [runner testsFailed],
             @"UKEqualTests testFloatsNegative failed");
    NSAssert([@"2.120000 != 2.130000" isEqualToString:[self lastMessage]],
             @"UKEqualTests testFloatsNegative failed");
}

#pragma mark double

- (void) xtestDoublesPositive
{
    double a = 6.022e+23;
    double b = 6.022e+23;
    UKEqual(a, b);
}

- (void) testDoublesPositive
{
    [self runHelperMethodNamed:@"xtestDoublesPositive"];    
    NSAssert(1 == [runner testsPassed],
             @"UKEqualTests testDoublesPositive failed");
    NSAssert(0 == [runner testsFailed],
             @"UKEqualTests testDoublesPositive failed");
    NSAssert([@"6.022e+23 == 6.022e+23" isEqualToString:[self lastMessage]],
             @"UKEqualTests testDoublesPositive failed");
}

- (void) xtestDoublesNegative
{
    double a = 6.022e+23;
    double b = 1.380e-23;
    UKEqual(a, b);
}


- (void) testDoublesNegative
{
    [self runHelperMethodNamed:@"xtestDoublesNegative"];    
    NSAssert(0 == [runner testsPassed],
             @"UKEqualTests testDoublesNegative failed");
    NSAssert(1 == [runner testsFailed],
             @"UKEqualTests testDoublesNegative failed");
    NSAssert([@"6.022e+23 != 1.38e-23" isEqualToString:[self lastMessage]],
             @"UKEqualTests testDoublesNegative failed");
}


#pragma mark bool

- (void) xtestBoolsPositive
{
    bool a = true;
    bool b = true;
    UKEqual(a, b);
}

- (void) testBoolsPositive
{
    [self runHelperMethodNamed:@"xtestBoolsPositive"];    
    NSAssert(1 == [runner testsPassed],
             @"UKEqualTests testBoolsPositive failed");
    NSAssert(0 == [runner testsFailed],
             @"UKEqualTests testBoolsPositive failed");
    NSAssert([@"true == true" isEqualToString:[self lastMessage]],
             @"UKEqualTests testBoolsPositive failed");
}

- (void) xtestBoolsNegative
{
    bool a = true;
    bool b = false;
    UKEqual(a, b);
}


- (void) testBoolsNegative
{
    [self runHelperMethodNamed:@"xtestBoolsNegative"];    
    NSAssert(0 == [runner testsPassed],
             @"UKEqualTests testBoolsNegative failed");
    NSAssert(1 == [runner testsFailed],
             @"UKEqualTests testBoolsNegative failed");
    NSAssert([@"true != false" isEqualToString:[self lastMessage]],
             @"UKEqualTests testBoolsNegative failed");
}

- (void) xtest_BoolsPositive
{
    _Bool a = true;
    _Bool b = true;
    UKEqual(a, b);
}

- (void) test_BoolsPositive
{
    [self runHelperMethodNamed:@"xtest_BoolsPositive"];    
    NSAssert(1 == [runner testsPassed],
             @"UKEqualTests test_BoolsPositive failed");
    NSAssert(0 == [runner testsFailed],
             @"UKEqualTests testBoolsPositive failed");
    NSAssert([@"true == true" isEqualToString:[self lastMessage]],
             @"UKEqualTests test_BoolsPositive failed");
}

- (void) xtest_BoolsNegative
{
    _Bool a = true;
    _Bool b = false;
    UKEqual(a, b);
}


- (void) test_BoolsNegative
{
    [self runHelperMethodNamed:@"xtest_BoolsNegative"];    
    NSAssert(0 == [runner testsPassed],
             @"UKEqualTests test_BoolsNegative failed");
    NSAssert(1 == [runner testsFailed],
             @"UKEqualTests test_BoolsNegative failed");
    NSAssert([@"true != false" isEqualToString:[self lastMessage]],
             @"UKEqualTests test_BoolsNegative failed");
}

#pragma mark char *

- (void) xtestCharStarsPositive
{
    char *a = "foo";
    char *b = "foo";
    UKEqual(a, b);
}

- (void) testCharStarsPositive
{
    [self runHelperMethodNamed:@"xtestCharStarsPositive"];    
    NSAssert(1 == [runner testsPassed],
             @"UKEqualTests testCharStarsPositive failed");
    NSAssert(0 == [runner testsFailed],
             @"UKEqualTests testCharStarsPositive failed");
    NSAssert([@"\"foo\" == \"foo\"" isEqualToString:[self lastMessage]],
             @"UKEqualTests testCharStarsPositive failed");
}

- (void) xtestCharStarsNegative
{
    char *a = "foo";
    char *b = "bar";
    UKEqual(a, b);
}


- (void) testCharStarsNegative
{
    [self runHelperMethodNamed:@"xtestCharStarsNegative"];    
    NSAssert(0 == [runner testsPassed],
             @"UKEqualTests testCharStarsNegative failed");
    NSAssert(1 == [runner testsFailed],
             @"UKEqualTests testCharStarsNegative failed");
    NSAssert([@"\"foo\" != \"bar\"" isEqualToString:[self lastMessage]],
             @"UKEqualTests testCharStarsNegative failed");
}

#pragma mark array

/*
 XXX not testing yet. Preprocessing is busted on the machine I'm using, so I
 need to look at it on a different machine
- (void) xtestArraysPositive
{
    int a[] = {1, 2, 3};
    int b[] = {1, 2, 3};
    UKEqual(a, b);
}

- (void) testArraysPositive
{
    [self runHelperMethodNamed:@"xtestArraysPositive"];    
    NSAssert(1 == [runner testsPassed],
             @"UKEqualTests testArraysPositive failed");
    NSAssert(0 == [runner testsFailed],
             @"UKEqualTests testArraysPositive failed");
    // XXX no message check yet -- hard to do
}

- (void) xtestArraysNegative
{
    int a[] = {1, 2, 3};
    int b[] = {3, 2, 1};
    UKEqual(a, b);
}


- (void) testArraysNegative
{
    [self runHelperMethodNamed:@"xtestArraysNegative"];    
    NSAssert(0 == [runner testsPassed],
             @"UKEqualTests testArraysNegative failed");
    NSAssert(1 == [runner testsFailed],
             @"UKEqualTests testArraysNegative failed");
    // XXX no message check yet -- hard to do
}
*/

#pragma mark struct

- (void) xtestStructsPositive
{
    NSRange a = NSMakeRange(0, 1);
    NSRange b = NSMakeRange(0, 1);
    UKEqual(a, b);
}
 
- (void) testStructsPositive
{
    [self runHelperMethodNamed:@"xtestStructsPositive"];    
    NSAssert(1 == [runner testsPassed],
            @"UKEqualTests testStructsPositive failed");
    NSAssert(0 == [runner testsFailed],
            @"UKEqualTests testStructsPositive failed");
    // XXX no message check yet -- hard to do
}
 
- (void) xtestStructsNegative
{
    NSRange a = NSMakeRange(0, 1);
    NSRange b = NSMakeRange(1, 2);
    UKEqual(a, b);
}

- (void) testStructsNegative
{
    [self runHelperMethodNamed:@"xtestStructsNegative"];    
    NSAssert(0 == [runner testsPassed],
            @"UKEqualTests testStructsNegative failed");
    NSAssert(1 == [runner testsFailed],
            @"UKEqualTests testStructsNegative failed");
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
    id b = self;
    UKEqual(a, b);
}

- (void) testIdsPositive
{
    [self runHelperMethodNamed:@"xtestIdsPositive"];    
    NSAssert(1 == [runner testsPassed],
             @"UKEqualTests testIdsPositive failed");
    NSAssert(0 == [runner testsFailed],
             @"UKEqualTests testIdsPositive failed");
    // XXX no message check yet -- hard to do
}

- (void) xtestIdsNegative
{
    id a = self;
    id b = [NSArray array];
    UKEqual(a, b);
}


- (void) testIdsNegative
{
    [self runHelperMethodNamed:@"xtestIdsNegative"];    
    NSAssert(0 == [runner testsPassed],
             @"UKEqualTests testIdsNegative failed");
    NSAssert(1 == [runner testsFailed],
             @"UKEqualTests testIdsNegative failed");
    // XXX no message check yet -- hard to do
}

#pragma mark Class

- (void) xtestClassesPositive
{
    Class a = [self class];
    Class b = [self class];
    UKEqual(a, b);
}

- (void) testClassesPositive
{
    [self runHelperMethodNamed:@"xtestClassesPositive"];    
    NSAssert(1 == [runner testsPassed],
             @"UKEqualTests testClassesPositive failed");
    NSAssert(0 == [runner testsFailed],
             @"UKEqualTests testClassesPositive failed");
    // XXX no message check yet -- hard to do
}

- (void) xtestClassesNegative
{
    Class a = [self class];
    Class b = [NSArray class];
    UKEqual(a, b);
}


- (void) testClassesNegative
{
    [self runHelperMethodNamed:@"xtestClassesNegative"];    
    NSAssert(0 == [runner testsPassed],
             @"UKEqualTests testClassesNegative failed");
    NSAssert(1 == [runner testsFailed],
             @"UKEqualTests testClassesNegative failed");
    // XXX no message check yet -- hard to do
}

#pragma mark SEL

- (void) xtestSELsPositive
{
    SEL a = _cmd;
    SEL b = _cmd;
    UKEqual(a, b);
}

- (void) testSELsPositive
{
    [self runHelperMethodNamed:@"xtestSELsPositive"];    
    NSAssert(1 == [runner testsPassed],
             @"UKEqualTests testSELsPositive failed");
    NSAssert(0 == [runner testsFailed],
             @"UKEqualTests testSELsPositive failed");
    // XXX no message check yet -- hard to do
}

- (void) xtestSELsNegative
{
    SEL a = _cmd;
    SEL b = NSSelectorFromString(@"description");
    UKEqual(a, b);
}


- (void) testSELsNegative
{
    [self runHelperMethodNamed:@"xtestSELsNegative"];    
    NSAssert(0 == [runner testsPassed],
             @"UKEqualTests testSELsNegative failed");
    NSAssert(1 == [runner testsFailed],
             @"UKEqualTests testSELsNegative failed");
    // XXX no message check yet -- hard to do
}

#pragma mark NSString *

- (void) xtestNSStringsPositive
{
    NSString *a = @"foo";
    NSString *b = @"foo";
    UKEqual(a, b);
}

- (void) testNSStringsPositive
{
    [self runHelperMethodNamed:@"xtestNSStringsPositive"];    
    NSAssert(1 == [runner testsPassed],
             @"UKEqualTests testNSStringsPositive failed");
    NSAssert(0 == [runner testsFailed],
             @"UKEqualTests testNSStringsPositive failed");
    NSAssert([@"\"foo\" == \"foo\"" isEqualToString:[self lastMessage]],
             @"UKEqualTests testNSStringsPositive failed");
}

- (void) xtestNSStringsNegative
{
    NSString *a = @"foo";
    NSString *b = @"bar";
    UKEqual(a, b);
}


- (void) testNSStringsNegative
{
    [self runHelperMethodNamed:@"xtestNSStringsNegative"];    
    NSAssert(0 == [runner testsPassed],
             @"UKEqualTests testNSStringsNegative failed");
    NSAssert(1 == [runner testsFailed],
             @"UKEqualTests testNSStringsNegative failed");
    NSAssert([@"\"foo\" != \"bar\"" isEqualToString:[self lastMessage]],
             @"UKEqualTests testNSStringsNegative failed");
}



@end
