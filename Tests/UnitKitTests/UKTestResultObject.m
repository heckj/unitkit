/*
 This source is part of UnitKit, a unit test framework for Mac OS X 
 development. You can find more information about UnitKit at:
 
 http://unitkit.org/
 
 Copyright ©2004-2005 Joseph Heck
 
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

#import "UKTestResultObject.h"


@implementation UKTestResultObject

- (void) testPass {
    UKPass();
}
/*
- (void) testXmlResult {
    UKTestResult * r = [[UKTestResult alloc] initWithMessage:@"a warning"];
    UKNotNil(r);
    UKFalse([r success]);

    NSString * resultString = [r xmlString];
    UKNotNil(resultString);
    UKStringContains(resultString,@"a warning");
    UKStringContains(resultString,@"<testresult>");
    UKStringDoesNotContain(resultString, @"line");
    
    [r setFilename:@"johnny"];
    [r setLine:6];
    
    resultString = [r xmlString];
    UKNotNil(resultString);
    UKStringContains(resultString,@"a warning");
    UKStringContains(resultString,@"johnny");
    UKStringContains(resultString,@"line");
    UKStringDoesNotContain(resultString,@"<testresult>");
    UKFalse([r success]);

    UKTestResult * s = [[UKTestResult alloc] initWithMessage:@"qwerty" fromFile:@"asdf1234" atLine:32 withSuccess:YES];
    UKNotNil(s);
    resultString = [s xmlString];
    UKNotNil(resultString);
    UKStringContains(resultString,@"qwerty");
    UKStringContains(resultString,@"asdf1234");
    UKStringContains(resultString,@"32");
    UKStringDoesNotContain(resultString,@"<testresult>");
    UKTrue([s success]);
    
}
*/
@end
