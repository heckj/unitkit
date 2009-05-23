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

#import "NSValue_UKAdditions.h"

@implementation NSValue (UKAdditions)

- (NSString *) stringRepresentation
{
    // grab the type of the wrapped value and switch on it. Each case block
    // is wrapped in braces because the compiler complains aobut the type
    // decls in each block otherwise
    
    const char *type = [self objCType];
    switch (*type) {
        case 'c' : // char
        {
            char v;
            [self getValue:&v];
            return [NSString stringWithFormat:@"%c", v];
        }
        case 'C' : // unsigned char
        {   
            unsigned char v;
            [self getValue:&v];
            return [NSString stringWithFormat:@"%c", v];
        }
        case 'i' : // int
        {
            int v;
            [self getValue:&v];
            return [NSString stringWithFormat:@"%i", v]; 
        }
        case 'I' : // unsigned int
        {
            unsigned int v;
            [self getValue:&v];
            return [NSString stringWithFormat:@"%u", v];
        }
        case 'l' : // long
        {
            long v;
            [self getValue:&v];
            return [NSString stringWithFormat:@"%i", v];
        }
        case 'L' : // unsigned long
        {
            unsigned long v;
            [self getValue:&v];
            return [NSString stringWithFormat:@"%i", v];
        }
        case 'Q' : // long long
        {
            long long v;
            [self getValue:&v];
            return [NSString stringWithFormat:@"%i", v];
        }
        case 's' : // short
        {
            short v;
            [self getValue:&v];
            return [NSString stringWithFormat:@"%i", v];
        }
        case 'S' : // unsigned short
        {
            unsigned short v;
            [self getValue:&v];
            return [NSString stringWithFormat:@"%u", v];
        }
        case 'f' :  // float
        {
            float v;
            [self getValue:&v];
            return [NSString stringWithFormat:@"%f", v];
        }
        case 'd' :  // double
        {
            double v;
            [self getValue:&v];
            return [NSString stringWithFormat:@"%g", v]; 
        }
        case 'B' : // bool _Bool
        {
            bool v;
            [self getValue:&v];
            if (v) { return @"true"; } else { return @"false"; }   
        }
        case 'v' : // void
        {
            return @"void";
        }
        case '*' : // char *
        {
            char *v;   
            [self getValue:&v];
            return [NSString stringWithFormat:@"\"%s\"", v];     
        }
        case '@' : // id
        {
            id v;
            [self getValue:&v];
            if ([v isKindOfClass:[NSString class]]) {
                return [NSString stringWithFormat:@"\"%@\"", [v description]];
            } else {
                return [v description]; 
            }
        }
        case '#' :  // class
        {
            Class v;
            [self getValue:&v];
            return [v description];  
        }
        case ':' : // SEL
        {
            SEL v;
            [self getValue:&v];
            return NSStringFromSelector(v);
        }
        default : // everything else, just return the internal string type
            return [NSString stringWithFormat:@"%s", type];  
    }
}

- (BOOL) isUKEqualToValue:(NSValue *) otherValue
{
    // NSValue doesn't treat equality the same way we want it treated. It
    // compares type and value. Instead, we want more things to be equal
    // to each other. For example, chars and ints are used interchangeably 
    // and ints get compared to unsigned ints all the time because of the 
    // way that code gets written.
    
    // as well, NSValue doesn't do a good job at checking object or string
    // equality because of its type check.
    
    // So here, we check the cases that NSValue things aren't
    // equal to see if they are. If we don't get a result, then we defer to
    // NSValue's view of the world.
    
    const char *selfType = [self objCType];
    const char *otherType = [otherValue objCType];
    
    switch (*selfType) {
        case 'c' :  // char
        {
            char selfV;
            [self getValue:&selfV];
            switch (*otherType) {
                case 'C' : // unsigned char
                {
                    unsigned char otherV;
                    [otherValue getValue:&otherV];
                    return (selfV == otherV);
                }
                case 'i' : // int
                {
                    int otherV;
                    [otherValue getValue:&otherV];
                    return (selfV == otherV);
                }
            }
            break;
        }
        case 'C' : // unsigned char
        {
            unsigned char selfV;
            [self getValue:&selfV];
            switch (*otherType) {
                case 'c' : // char
                {
                    char otherV;  
                    [otherValue getValue:&otherV];
                    return (selfV == otherV);
                }
                case 'i' : // int
                {
                    int otherV;
                    [otherValue getValue:&otherV];
                    return (selfV == otherV);
                }
            }
            break;
        }
        case 'i' : // int
        {
            int selfV;
            [self getValue:&selfV];
            switch (*otherType) {
                case 'I' : // unsigned it
                {
                    unsigned int otherV;
                    [otherValue getValue:&otherV];
                    return (selfV == otherV);
                }
                case 'c' : // char
                {
                    char otherV;
                    [otherValue getValue:&otherV];
                    return (selfV == otherV);
                }
            }
            break;
        }
        case 'I' : // unsigned int
        {
            unsigned int selfV;
            [self getValue:&selfV];
            switch (*otherType) {
                case 'i' : // int
                {
                    int otherV;  
                    [otherValue getValue:&otherV];
                    return (selfV == otherV);
                }
                case 'c' : // char
                {
                    char otherV;
                    [otherValue getValue:&otherV];
                    return (selfV == otherV);
                }
            }
            break;
        }
        case 'l' : // long
        {
            long selfV;
            [self getValue:&selfV];
            if (*otherType == 'L') {
                unsigned long otherV;
                [otherValue getValue:&otherV];
                return (selfV == otherV);
            }
            break;
        }
        case 'L' : // unsigned long
        {
            unsigned long selfV;
            [self getValue:&selfV];
            if (*otherType == 'l') {
                long otherV;
                [otherValue getValue:&otherV];
                return (selfV == otherV);
            }
            break;
        }
        case 's' : // short
        {
            short selfV;
            [self getValue:&selfV];
            if (*otherType == 'S') {
                unsigned short otherV;
                [otherValue getValue:&otherV];
                return (selfV == otherV);
            }
            break;
        }
        case 'S' : // unsigned short
        {
            unsigned short selfV;
            [self getValue:&selfV];
            if (*otherType == 's') {
                short otherV;
                [otherValue getValue:&otherV];
                return (selfV == otherV);
            }
            break;
        }  
        case '@' : // id
        {
            id selfV;
            id otherV;
            [self getValue:&selfV];
            [otherValue getValue:&otherV];
            if ([selfV isKindOfClass:[NSString class]] && 
                [otherV isKindOfClass:[NSString class]]) 
            {
                return [selfV isEqualToString:otherV];
            } else {
                return [selfV isEqualTo:otherV];
            }
        }
        default :
            break;
    }
    return [self isEqualToValue:otherValue];
}

@end
