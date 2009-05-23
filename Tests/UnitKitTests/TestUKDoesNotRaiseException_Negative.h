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

#import <Cocoa/Cocoa.h>
#import <UnitKit/UnitKit.h>

// This class doesn't implement the UKTest protocol because it is not
// supposed to get picked up automatically out of a test bundle. Instead
// it is used by UKTestMacros to test out all of the macros.

@interface TestUKDoesNotRaiseException_Negative : NSObject {

}

@end
