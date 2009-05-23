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

#import "NSValue_UKAdditionsTests.h"
#import "NSValue_UKAdditions.h"

@implementation NSValue_UKAdditionsTests

#pragma mark stringReprsentation

- (void) testStringRepChar
{
    char a = 'b';
    NSValue *value = [NSValue value:&a withObjCType:@encode(typeof(a))];
    UKStringsEqual([value stringRepresentation], @"b");
}

- (void) testStringRepInt
{
    int a = 42;
    NSValue *value = [NSValue value:&a withObjCType:@encode(typeof(a))];
    UKStringsEqual([value stringRepresentation], @"42");
}

- (void) testStringRepShort
{
    short a = 42;
    NSValue *value = [NSValue value:&a withObjCType:@encode(typeof(a))];
    UKStringsEqual([value stringRepresentation], @"42");
}

- (void) testStringRepLong
{
    long a = 13000000;
    NSValue *value = [NSValue value:&a withObjCType:@encode(typeof(a))];
    UKStringsEqual([value stringRepresentation], @"13000000");
}

// XXX long long

- (void) testStringRepUnsignedChar
{
    unsigned char a = 'b';
    NSValue *value = [NSValue value:&a withObjCType:@encode(typeof(a))];
    UKStringsEqual([value stringRepresentation], @"b");
}

- (void) testStringRepUnsignedInt
{
    unsigned int a = 42;
    NSValue *value = [NSValue value:&a withObjCType:@encode(typeof(a))];
    UKStringsEqual([value stringRepresentation], @"42");
}

- (void) testStringRepUnsignedShort
{
    unsigned short a = 42;
    NSValue *value = [NSValue value:&a withObjCType:@encode(typeof(a))];
    UKStringsEqual([value stringRepresentation], @"42");
}

- (void) testStringRepUnsignedLong
{
    unsigned long a = 13000000;
    NSValue *value = [NSValue value:&a withObjCType:@encode(typeof(a))];
    UKStringsEqual([value stringRepresentation], @"13000000");
}

// XXX unsigned long long

- (void) testStringRepFloat
{
    float a = 14.2;
    NSValue *value = [NSValue value:&a withObjCType:@encode(typeof(a))];
    UKStringsEqual([value stringRepresentation], @"14.200000");
}

- (void) testStringRepDouble
{
    double a = 6.022e+23;
    NSValue *value = [NSValue value:&a withObjCType:@encode(typeof(a))];
    UKStringsEqual([value stringRepresentation], @"6.022e+23");
}

// bool, _Bool

- (void) testStringRepBoolTrue
{
    bool a = true;
    NSValue *value = [NSValue value:&a withObjCType:@encode(typeof(a))];
    UKStringsEqual([value stringRepresentation], @"true");    
}

- (void) testStringRepBoolFalse
{
    bool a = false;
    NSValue *value = [NSValue value:&a withObjCType:@encode(typeof(a))];
    UKStringsEqual([value stringRepresentation], @"false");    
}

- (void) testStringRep_BoolTrue
{
    _Bool a = true;
    NSValue *value = [NSValue value:&a withObjCType:@encode(typeof(a))];
    UKStringsEqual([value stringRepresentation], @"true");    
}

- (void) testStringRep_BoolFalse
{
    _Bool a = false;
    NSValue *value = [NSValue value:&a withObjCType:@encode(typeof(a))];
    UKStringsEqual([value stringRepresentation], @"false");    
}

// XXX void

- (void) testStringRepCharStar
{
    char *a = "now is the time";
    NSValue *value = [NSValue value:&a withObjCType:@encode(typeof(a))];
    UKStringsEqual([value stringRepresentation], @"\"now is the time\"");    
}

// XXX char * with > 25/30 chars

- (void) testStringRepId
{
    id a = self;
    NSValue *value = [NSValue value:&a withObjCType:@encode(typeof(a))];
    UKStringsEqual([value stringRepresentation], [a description]);    
}

- (void) testStringRepClass
{
    id a = [self class];
    NSValue *value = [NSValue value:&a withObjCType:@encode(typeof(a))];
    UKStringsEqual([value stringRepresentation], [a description]);    
}

- (void) testStringRepSEL
{
    SEL a = _cmd;
    NSValue *value = [NSValue value:&a withObjCType:@encode(typeof(a))];
    UKStringsEqual([value stringRepresentation], @"testStringRepSEL");    
}

- (void) testStringRepArray
{
    int a[4] = {1, 2, 3, 4};
    NSValue *value = [NSValue value:&a withObjCType:@encode(typeof(a))];
    UKStringsEqual([value stringRepresentation], @"[4i]");       
}

- (void) testStringRepStructure
{
    NSRange a = NSMakeRange(23, 42);
    NSValue *value = [NSValue value:&a withObjCType:@encode(typeof(a))];
    UKStringsEqual([value stringRepresentation], @"{_NSRange=II}");       
}

// structure

// union

// bit field

// pointer to a type

// unknown type

#pragma mark isUKEqualToValue:

- (void) testUKEqualCharUnsignedCharPositive
{
    char a = 'c';
    unsigned char b = 'c';
    NSValue *valueA = [NSValue value:&a withObjCType:@encode(typeof(a))];
    NSValue *valueB = [NSValue value:&b withObjCType:@encode(typeof(b))];
    UKTrue([valueA isUKEqualToValue:valueB]);
}

- (void) testUKEqualCharUnsignedCharNegative
{
    char a = 'c';
    unsigned char b = 'd';
    NSValue *valueA = [NSValue value:&a withObjCType:@encode(typeof(a))];
    NSValue *valueB = [NSValue value:&b withObjCType:@encode(typeof(b))];
    UKFalse([valueA isUKEqualToValue:valueB]);
}

- (void) testUKEqualUnsignedCharCharPositive
{
    unsigned char a = 'c';
    char b = 'c';
    NSValue *valueA = [NSValue value:&a withObjCType:@encode(typeof(a))];
    NSValue *valueB = [NSValue value:&b withObjCType:@encode(typeof(b))];
    UKTrue([valueA isUKEqualToValue:valueB]);
}

- (void) testUKEqualUnsignedCharCharNegative
{
    unsigned char a = 'c';
    char b = 'd';
    NSValue *valueA = [NSValue value:&a withObjCType:@encode(typeof(a))];
    NSValue *valueB = [NSValue value:&b withObjCType:@encode(typeof(b))];
    UKFalse([valueA isUKEqualToValue:valueB]);
}

- (void) testUKEqualIntUnsignedIntPositive
{
    int a = 42;
    unsigned int b = 42;
    NSValue *valueA = [NSValue value:&a withObjCType:@encode(typeof(a))];
    NSValue *valueB = [NSValue value:&b withObjCType:@encode(typeof(b))];
    UKTrue([valueA isUKEqualToValue:valueB]);
}

- (void) testUKEqualIntUnsignedIntNegative
{
    int a = 42;
    unsigned int b = 1;
    NSValue *valueA = [NSValue value:&a withObjCType:@encode(typeof(a))];
    NSValue *valueB = [NSValue value:&b withObjCType:@encode(typeof(b))];
    UKFalse([valueA isUKEqualToValue:valueB]);
}

- (void) testUKEqualUnsignedIntIntPositive
{
    unsigned int a = 42;
    int b = 42;
    NSValue *valueA = [NSValue value:&a withObjCType:@encode(typeof(a))];
    NSValue *valueB = [NSValue value:&b withObjCType:@encode(typeof(b))];
    UKTrue([valueA isUKEqualToValue:valueB]);
}

- (void) testUKEqualUnsignedIntIntNegative
{
    unsigned int a = 42;
    int b = 1;
    NSValue *valueA = [NSValue value:&a withObjCType:@encode(typeof(a))];
    NSValue *valueB = [NSValue value:&b withObjCType:@encode(typeof(b))];
    UKFalse([valueA isUKEqualToValue:valueB]);
}

- (void) testUKEqualLongUnsignedLongPositive
{
    long a = 42;
    unsigned long b = 42;
    NSValue *valueA = [NSValue value:&a withObjCType:@encode(typeof(a))];
    NSValue *valueB = [NSValue value:&b withObjCType:@encode(typeof(b))];
    UKTrue([valueA isUKEqualToValue:valueB]);
}

- (void) testUKEqualLongUnsignedLongNegative
{
    long a = 42;
    unsigned long b = 1;
    NSValue *valueA = [NSValue value:&a withObjCType:@encode(typeof(a))];
    NSValue *valueB = [NSValue value:&b withObjCType:@encode(typeof(b))];
    UKFalse([valueA isUKEqualToValue:valueB]);
}

- (void) testUKEqualUnsignedLongLongPositive
{
    unsigned long a = 42;
    long b = 42;
    NSValue *valueA = [NSValue value:&a withObjCType:@encode(typeof(a))];
    NSValue *valueB = [NSValue value:&b withObjCType:@encode(typeof(b))];
    UKTrue([valueA isUKEqualToValue:valueB]);
}

- (void) testUKEqualUnsignedLongLongNegative
{
    unsigned long a = 42;
    long b = 1;
    NSValue *valueA = [NSValue value:&a withObjCType:@encode(typeof(a))];
    NSValue *valueB = [NSValue value:&b withObjCType:@encode(typeof(b))];
    UKFalse([valueA isUKEqualToValue:valueB]);
}

- (void) testUKEqualShortUnsignedShortPositive
{
    short a = 42;
    unsigned short b = 42;
    NSValue *valueA = [NSValue value:&a withObjCType:@encode(typeof(a))];
    NSValue *valueB = [NSValue value:&b withObjCType:@encode(typeof(b))];
    UKTrue([valueA isUKEqualToValue:valueB]);
}

- (void) testUKEqualShortUnsignedShortNegative
{
    short a = 42;
    unsigned short b = 1;
    NSValue *valueA = [NSValue value:&a withObjCType:@encode(typeof(a))];
    NSValue *valueB = [NSValue value:&b withObjCType:@encode(typeof(b))];
    UKFalse([valueA isUKEqualToValue:valueB]);
}

- (void) testUKEqualUnsignedShortShortPositive
{
    unsigned short a = 42;
    short b = 42;
    NSValue *valueA = [NSValue value:&a withObjCType:@encode(typeof(a))];
    NSValue *valueB = [NSValue value:&b withObjCType:@encode(typeof(b))];
    UKTrue([valueA isUKEqualToValue:valueB]);
}

- (void) testUKEqualUnsignedShortShortNegative
{
    unsigned short a = 42;
    short b = 1;
    NSValue *valueA = [NSValue value:&a withObjCType:@encode(typeof(a))];
    NSValue *valueB = [NSValue value:&b withObjCType:@encode(typeof(b))];
    UKFalse([valueA isUKEqualToValue:valueB]);
}

- (void) testUKEqualObjectsPositive
{
    id a = [NSNumber numberWithInt:33];
    id b = [NSNumber numberWithInt:33];
    NSValue *valueA = [NSValue value:&a withObjCType:@encode(typeof(a))];
    NSValue *valueB = [NSValue value:&b withObjCType:@encode(typeof(b))];
    UKTrue([valueA isUKEqualToValue:valueB]);    
}

- (void) testUKEqualObjectsNegative
{
    id a = [NSNumber numberWithInt:33];
    id b = [NSNumber numberWithInt:34];
    NSValue *valueA = [NSValue value:&a withObjCType:@encode(typeof(a))];
    NSValue *valueB = [NSValue value:&b withObjCType:@encode(typeof(b))];
    UKFalse([valueA isUKEqualToValue:valueB]);    
}

- (void) testUKEqualStringsPositive
{
    NSString *a = @"asdf";
    NSString *b = [NSString stringWithUTF8String:"asdf"];
    NSValue *valueA = [NSValue value:&a withObjCType:@encode(typeof(a))];
    NSValue *valueB = [NSValue value:&b withObjCType:@encode(typeof(b))];
    UKTrue([valueA isUKEqualToValue:valueB]);      
}

- (void) testUKEqualStringsNegative
{
    NSString *a = @"asdf";
    NSString *b = @"bar";
    NSValue *valueA = [NSValue value:&a withObjCType:@encode(typeof(a))];
    NSValue *valueB = [NSValue value:&b withObjCType:@encode(typeof(b))];
    UKFalse([valueA isUKEqualToValue:valueB]);      
}

@end
