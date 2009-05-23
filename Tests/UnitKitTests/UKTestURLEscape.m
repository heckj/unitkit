/*
 This source is part of UnitKit, a unit test framework for Mac OS X 
 development. You can find more information about UnitKit at:
 
 http://unitkit.org/
 
 Copyright ©2005 Joseph Heck
 
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

#import "UKTestURLEscape.h"
#import <UnitKit/URLEscape.h>

@implementation UKTestURLEscape

- (void) testBrokenCFXMLCreateStringByEscapingEntities
{
    NSString* a = @"one < two";
    NSString* b = (NSString*)CFXMLCreateStringByEscapingEntities(kCFAllocatorDefault, (CFStringRef)a, NULL );
    
#ifdef MAC_OS_X_VERSION_10_4
    UKStringsEqual(@"one &lt; two",b);
#else
    // this is (my) expected behavior, which doesn't happen in 10.3.1 - 10.3.7...
    // UKStringsEqual(@"one &lt; two",b);
    UKStringsEqual(@"one &lt;",b);
#endif
    
}

- (void) testURLEscapeCategory
{
    NSString* a = @"one < two";
    UKStringsEqual(@"one &lt; two",[a URLEscapedString]);

    NSString* b = @"one > &two";
    UKStringsEqual(@"one &gt; &amp;two",[b URLEscapedString]);
    
    NSString * c = @"<testresult=\"something\">";
    UKStringsEqual(@"&lt;testresult=&quot;something&quot;&gt;",[c URLEscapedString]);

}
@end
