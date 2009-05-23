/*
 This source is part of UnitKit, a unit test framework for Mac OS X 
 development. You can find more information about UnitKit at:
 
 http://unitkit.org/
 
 Copyright ©2004-2005 James Duncan Davidson, Mark Dalrymple, Nicolas Roard
 
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

#import "UKReporter.h"
#import "UKRunner.h"
#import "UKTest.h"
#import "UKTestHandler.h"

#pragma mark NOTIFICATIONS
NSString *UKTestClassAddedNotification = @"UKTestClassAdded";
NSString *UKTestRunStartingNotification= @"UKTestRunStarting";
NSString *UKTestRunEndedNotification= @"UKTestRunEnded";
NSString *UKTestClassStartingNotification= @"UKTestClassStarting";
NSString *UKTestClassEndedNotification= @"UKTestClassEnded";
NSString *UKTestMethodStartingNotification= @"UKTestMethodStarting";
NSString *UKTestMethodEndedNotification= @"UKTestMethodEnded";
NSString *UKTestSuccessNotification= @"UKTestSuccess";
NSString *UKTestFailureNotification= @"UKTestFailure";


#ifndef GNUSTEP
#import <objc/objc-runtime.h>
#else
#import <GNUstepBase/GSObjCRuntime.h>
#endif

@interface UKRunner (Private)

+ (NSString *)localizedString:(NSString *)key;
- (void) runTestsInClass:(Class)testClass;
- (void) runTests:(NSArray *)testMethods onClass:(Class)testClass;
- (void) runTest:(SEL)testSelector onObject:(id)testObject;

@end

@implementation UKRunner

+ (UKRunner *) runner
{
    return [[[UKRunner alloc] init] autorelease];
}

+ (NSString *) localizedString:(NSString *)key
{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    return NSLocalizedStringFromTableInBundle(key, @"UKRunner", 
                                              bundle, @"");
}

+ (NSString *) displayStringForException:(id)exc
{
    if ([exc isKindOfClass:[NSException class]]) {
        return [NSString stringWithFormat:@"NSException: %@ %@", [exc name],
            [exc reason]];
    } else {
        return NSStringFromClass([exc class]);
    }
}

- (id) init
{
    self = [super init];
    //testsPassed = 0;
    //testsFailed = 0;
    testClasses = [[NSMutableArray alloc] init];
    testPassedNotifications = [[NSMutableArray alloc] init];
    testFailedNotifications = [[NSMutableArray alloc] init];
    
    // add ourselves as a listener to notifications that come from test run
    // by this runner
    
    NSNotificationCenter* noticenter = [NSNotificationCenter defaultCenter];

    [noticenter addObserver:self selector:@selector(testAssertionFailed:) 
                       name:UKTestFailureNotification object:self ];
    [noticenter addObserver:self selector:@selector(testAssertionPassed:) 
                       name:UKTestSuccessNotification object:self ];
    return self;
}

- (void) dealloc
{
    [testClasses release];
    [super dealloc];
}

- (int) testsPassed
{
    // NSInternalInconsistencyException if not run yet
    return [testPassedNotifications count];
}

- (int) testsFailed
{
    // NSInternalInconsistencyException if not run yet
    return [testFailedNotifications count];
}

- (void) testAssertionPassed:(NSNotification *) notification
{
    // XXX
    // There's a bug in the system somewhere.. if I get a description
    // from the notification, everything works well. However, if I don't
    // I get two...
    //[notification description];// UTF8String];
    //testsPassed++;
    if (![testPassedNotifications containsObject:notification]) {
        [testPassedNotifications addObject:notification];
    } else {
        printf("XXXXX discarding notificaiton\n%s\n", 
               [[notification description] UTF8String]);
    }
}

- (void) testAssertionFailed:(NSNotification *) notification
{  

    //[notification description]; // UTF8String];
    //testsFailed++;
    if (![testFailedNotifications containsObject:notification]) {
        [testFailedNotifications addObject:notification];
    } else {
        printf("XXXXX discarding notificaiton\n%s\n", 
               [[notification description] UTF8String]);
    }
}

- (void) addTestClass:(Class) testClass
{
    [testClasses addObject:testClass];
    
    NSDictionary *info = [NSMutableDictionary dictionary];
    [info setValue:NSStringFromClass(testClass) forKey:@"class"];
    [[NSNotificationCenter defaultCenter]
        postNotificationName:UKTestClassAddedNotification object:self userInfo:info];
}

- (void) addTestsFromBundle:(NSBundle *)bundle
{
    NSArray *bundleTestClasses = UKTestClassesFromBundle(bundle);
    NSEnumerator *e = [bundleTestClasses objectEnumerator];
    Class testClass;
    while (testClass = [e nextObject]) {
        [self addTestClass:testClass];
    }
}

- (void) run
{
    [[NSNotificationCenter defaultCenter] 
        postNotificationName:UKTestRunStartingNotification object:self];
    NSEnumerator *e = [testClasses objectEnumerator];
    Class testClass;
    while (testClass = [e nextObject]) {
        [self runTestsInClass:testClass];
    }
    [[NSNotificationCenter defaultCenter] 
        postNotificationName:UKTestRunEndedNotification object:self];
}

- (void) runTestsInClass:(Class)testClass
{
    NSArray *testMethods = UKTestMethodNamesFromClass(testClass);
    [self runTests:testMethods onClass:testClass];
}


- (void) runTests:(NSArray *)testMethods onClass:(Class)testClass
{
    // send notification that methods are about to be called on this class
    
    NSDictionary *info = [NSMutableDictionary dictionary];
    [info setValue:NSStringFromClass(testClass) forKey:@"class"];
    [[NSNotificationCenter defaultCenter]
        postNotificationName:UKTestClassStartingNotification object:self userInfo:info];
    
    // run the tests
    
    NSEnumerator *e = [testMethods objectEnumerator];
    NSString *testMethodName;
    while (testMethodName = [e nextObject]) {
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
        id testObject;

        testObject = [[testClass alloc] init];
        SEL testSel = NSSelectorFromString(testMethodName);
        [self runTest:testSel onObject:testObject];
        [testObject release];
        [pool release];
    }
  
    // send notification that we're done with this class
    
    info = [NSMutableDictionary dictionary];
    [info setValue:NSStringFromClass(testClass) forKey:@"class"];
        
    [[NSNotificationCenter defaultCenter] 
        postNotificationName:UKTestClassEndedNotification 
                      object:self userInfo:info];
}


- (void) runTest:(SEL)testSelector onObject:(id)testObject
{
    NSDictionary *info = [NSMutableDictionary dictionary];
    [info setValue:NSStringFromClass([testObject class]) forKey:@"class"];
    [info setValue:NSStringFromSelector(testSelector) forKey:@"method"];
    
    [[NSNotificationCenter defaultCenter]
        postNotificationName:UKTestMethodStartingNotification object:self userInfo:info];
    
    // stick this runner onto a stack of runners, creating one if need be
    
    NSDictionary *threadDict = [[NSThread currentThread] threadDictionary];
    NSMutableArray *runnerStack = [threadDict valueForKey:@"UKRunner"];
    if (!runnerStack) {
        runnerStack = [NSMutableArray array];
        [threadDict setValue:runnerStack forKey:@"UKRunner"];
    }
    [runnerStack insertObject:self atIndex:0];

    if ([testObject respondsToSelector:testSelector]) {
        [testObject performSelector:testSelector];
    } else {
        // XXX revisit error message
        printf("error: Class %s does not respond to %s\n",
               [NSStringFromClass([testObject class]) UTF8String],
               [NSStringFromSelector(testSelector) UTF8String]);
    }
    
    // pop the runner off the stack
    [runnerStack removeObjectAtIndex:0];
        
    [[NSNotificationCenter defaultCenter] 
        postNotificationName:UKTestMethodEndedNotification object:self userInfo:info];    
}

@end

NSArray *UKTestClassesFromBundle(NSBundle *bundle)
{
    NSMutableArray *testClasses = [NSMutableArray array];
    
#ifndef GNU_RUNTIME
    int numClasses;
    numClasses = objc_getClassList(NULL, 0);
    if (numClasses > 0) {
        Class *classes = malloc(sizeof(Class) * numClasses);
        (void) objc_getClassList (classes, numClasses);
        int i;
        for (i = 0; i < numClasses; i++) {
            Class c = classes[i];
            NSBundle *classBundle = [NSBundle bundleForClass:c];
            if (bundle == classBundle && 
                [c conformsToProtocol:@protocol(UKTest)]) {
                //[testClasseNames addObject:NSStringFromClass(c)];
                [testClasses addObject:c];
            }
        }
        free(classes);
    }        
#else
    Class class;
    void *es = NULL;
    while ((class = objc_next_class (&es)) != Nil)
    {
        NSBundle* classBundle = [NSBundle bundleForClass: class];
        if (bundle == classBundle && 
            [class conformsToProtocol: @protocol (UKTest)]) {
            //[testClasseNames addObject:NSStringFromClass(class)];
            [testClasses addObject:class];
        }
    }
#endif
    return testClasses;
}

NSArray *UKTestMethodNamesFromClass(Class c)
{
    
    NSMutableArray *testMethods = [NSMutableArray array];
    
#ifndef GNU_RUNTIME    
    void *iterator = 0;
    struct objc_method_list *mlist = class_nextMethodList(c, &iterator);
    while (mlist != NULL) {
        int i;
        for (i = 0; i < mlist->method_count; i++) {
            Method method = &(mlist->method_list[i]);
            if (method == NULL) {
                continue;
            }
            SEL sel = method->method_name;
            NSString *methodName = NSStringFromSelector(sel);
            if ([methodName hasPrefix:@"test"]) {
                [testMethods addObject:methodName];
            }
        }
        mlist = class_nextMethodList(c, &iterator);
    }  
#else
    MethodList_t _methods = c->methods;
	int i;
	for (i=0; i < _methods->method_count; i++) {
		Method_t method = &(_methods->method_list[i]);
		if (method == NULL) {
			continue;
		}
		SEL sel = method->method_name;
		NSString *methodName = NSStringFromSelector(sel);
		if ([methodName hasPrefix:@"test"]) {
			[testMethods addObject:methodName];
		}
	}
#endif

    return [testMethods 
        sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}
