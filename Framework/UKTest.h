/*
 This source is part of UnitKit, a unit test framework for Mac OS X 
 development. You can find more information about UnitKit at:
 
 http://unitkit.org/
 
 Copyright ©2004-2005 James Duncan Davidson, Micheal Milvich
 
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

/*!
 @protocol UKTest
 @abstract The marker protocol that indicates that a class should be picked up by a system.
 @discussion (description)
*/
@protocol UKTest

@end

// XXX need a optional message on these

#define UKPass() \
    [[UKTestHandler handler] passInFile:__FILE__ line:__LINE__]

#define UKFail() \
    [[UKTestHandler handler] failInFile:__FILE__ line:__LINE__]

#define UKTrue(condition) \
    [[UKTestHandler handler] testTrue:(condition) inFile:__FILE__ line:__LINE__]

#define UKFalse(condition) \
    [[UKTestHandler handler] \
        testFalse:(condition) inFile:__FILE__ line:__LINE__]

#define UKNil(ref) \
    [[UKTestHandler handler] testNil:(ref) inFile:__FILE__ line:__LINE__] 

#define UKNotNil(ref) \
    [[UKTestHandler handler] testNotNil:(ref) inFile:__FILE__ line:__LINE__]

/*
 Design of UKEqual and UKNotEqual inspired by Bill Bumgarner's implementation
 of the STAssertEquals macro in OCUnit. 
 */

#define UKEqual(a, b) \
{ \
    typeof(a) avalue = (a); \
    typeof(b) bvalue = (b); \
    [[UKTestHandler handler] \
        testValue:[NSValue value:&avalue withObjCType:@encode(typeof(a))] \
          equalTo:[NSValue value:&bvalue withObjCType:@encode(typeof(b))] \
           inFile:__FILE__ line:__LINE__]; \
}

#define UKNotEqual(a, b) \
{ \
    typeof(a) avalue = (a); \
        typeof(b) bvalue = (b); \
            [[UKTestHandler handler] \
        testValue:[NSValue value:&avalue withObjCType:@encode(typeof(a))] \
       notEqualTo:[NSValue value:&bvalue withObjCType:@encode(typeof(b))] \
           inFile:__FILE__ line:__LINE__]; \
}

#define UKIntsEqual(a, b) UKEqual(a, b)

#define UKIntsNotEqual(a, b) UKNotEqual(a, b)

#define UKFloatsEqual(a, b, d) \
    [[UKTestHandler handler] \
        testFloat:(a) equalTo:(b) delta:(d) inFile:__FILE__ line:__LINE__]

#define UKFloatsNotEqual(a, b, d) \
    [[UKTestHandler handler] \
        testFloat:(a) notEqualTo:(b) delta:(d) inFile:__FILE__ line:__LINE__]

#define UKObjectsEqual(a, b) UKEqual(a, b)

#define UKObjectsNotEqual(a, b) UKNotEqual(a, b)

#define UKObjectsSame(a, b) \
    [[UKTestHandler handler] \
        testObject:(a) sameAs:(b) inFile:__FILE__ line:__LINE__]

#define UKObjectsNotSame(a, b) \
    [[UKTestHandler handler] \
        testObject:(a) notSameAs:(b) inFile:__FILE__ line:__LINE__]

#define UKStringsEqual(a, b) UKEqual(a, b)

#define UKStringsNotEqual(a, b) UKNotEqual(a, b)

#define UKStringContains(a, b) \
    [[UKTestHandler handler] \
        testString:(a) contains:(b) inFile:__FILE__ line:__LINE__]

#define UKStringDoesNotContain(a, b) \
    [[UKTestHandler handler] \
        testString:(a) doesNotContain:(b) inFile:__FILE__ line:__LINE__]

/*
 Exception testing macros contributed by Michael Milvich.
 */

#define UKRaisesException(a) \
{ \
    id p_exp = nil; \
    @try { a; } \
    @catch(id exp) { p_exp = exp; } \
    [[UKTestHandler handler] \
        raisesException:p_exp inFile:__FILE__ line:__LINE__]; \
}

#define UKDoesNotRaiseException(a) \
{ \
    id p_exp = nil; \
    @try { a; } \
    @catch(id exp) { p_exp = exp; } \
    [[UKTestHandler handler] \
        doesNotRaisesException:p_exp inFile:__FILE__ line:__LINE__]; \
}

#define UKRaisesExceptionNamed(a, b) \
{ \
    id p_exp = nil; \
    @try{ a; } \
    @catch(id exp) { p_exp = exp; } \
    [[UKTestHandler handler] \
        raisesException:p_exp named:b inFile:__FILE__ line:__LINE__]; \
}

#define UKRaisesExceptionClass(a, b) \
{ \
    id p_exp = nil; \
    @try{ a; } \
    @catch(id exp) { p_exp = exp; } \
    [[UKTestHandler handler] \
        raisesException:p_exp class:[b class] inFile:__FILE__ line:__LINE__]; \
}
