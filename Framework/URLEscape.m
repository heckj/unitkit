/*
 This source is part of UnitKit, a unit test framework for Mac OS X 
 development. You can find more information about UnitKit at:
 
 http://unitkit.org/
 
 Copyright ©2005 Steven Kramer, Joseph Heck, James Duncan Davidson
 
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

#import "URLEscape.h"
#import <CoreServices/CoreServices.h>

@implementation NSString (URLEscape)

- (NSString*) URLEscapedString
{
    // quick little runtime check to see if we can use the CFXML api for this
    
    SInt32 sysVersion;
    if (Gestalt(gestaltSystemVersion, &sysVersion) == noErr) {
        if (sysVersion >= 0x1040) {
            CFStringRef escString;
            escString = CFXMLCreateStringByEscapingEntities (nil, 
                                                             (CFStringRef) self, 
                                                             nil);
            return (NSString *) escString;
        }
    }

    // otherwise, do it the hard way as the CFXML api is busted for this
    // on 10.3
    
    NSMutableString* escaped = [[self mutableCopy] autorelease];
    [escaped replaceOccurrencesOfString: @"&" 
                             withString: @"&amp;" 
                                options: 0 
                                  range: NSMakeRange (0, [escaped length])];
    [escaped replaceOccurrencesOfString: @"<" 
                             withString: @"&lt;" 
                                options: 0 
                                  range: NSMakeRange (0, [escaped length])];
    [escaped replaceOccurrencesOfString: @">" 
                             withString: @"&gt;" 
                                options: 0 
                                  range: NSMakeRange (0, [escaped length])];
    [escaped replaceOccurrencesOfString: @"\"" 
                             withString: @"&quot;" 
                                options: 0 
                                  range: NSMakeRange (0, [escaped length])];
    return [[escaped copy] autorelease];
}

@end
