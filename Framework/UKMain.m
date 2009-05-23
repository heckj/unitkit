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

#import <UnitKit/UKRunner.h>
#import <getopt.h>

#import "UKBasicReporter.h"
#import "UKXMLReporter.h"

#import "UKMain.h"

@implementation UKMain

+ (int) runWithArgc:(int)argc argv:(char **)argv
{
    BOOL verbose = NO;
    BOOL quiet  = NO;
    
    UKRunner *runner = [[UKRunner alloc] init];
    id<UKReporter> reporter = nil;
    
    // process the arg list for flags and what not
    
    static struct option longopts[] = {
    {"quiet", no_argument, 0, 'q'},
    {"verbose", no_argument, 0, 'v'},
    {"xmlout", required_argument, 0, 'x'}
    };
    
    extern char *optarg;
    extern int optind;
    const char *opts = "qvx:";
    int ch;
    while ((ch = getopt_long(argc, argv, opts, longopts, &optind)) != -1) {
        switch(ch) {
            case 'v':
                verbose = YES;
                break;
            case 'q':
                quiet = YES;
                break;
            case 'x':
                printf("setting xml reporter %s\n", optarg);
                id xmlReporter = [[UKXMLReporter alloc] initWithRunner:runner];
                [xmlReporter setReportOutputPath:[NSString stringWithUTF8String:
                    optarg]];
                break;
            default:
                //usage();
                break;
        }
    }
    
    argc -= optind;
    argv += optind;
    
    reporter = [[UKBasicReporter alloc] initWithRunner:runner];
    
    if (verbose) {
        [reporter setReportDetailLevel:kUKReportDetailLevelVerbose];
    } else if (quiet) {
        [reporter setReportDetailLevel:kUKReportDetailLevelQuiet];
    }
    // now parse the arg list for bundles to load tests from
    
    NSString *cwd = [[NSFileManager defaultManager] currentDirectoryPath];
    
    int i = 0;
    
    while (i < argc) {
        char *arg = argv[i++];
        NSString *bundlePath = [[NSString stringWithUTF8String:arg]
            stringByExpandingTildeInPath];
        if ( ! [bundlePath isAbsolutePath]) {
            bundlePath = [[cwd stringByAppendingPathComponent:bundlePath]
                stringByStandardizingPath];
        }
        
        NSBundle *testBundle = [NSBundle bundleWithPath:bundlePath];
        if (testBundle == nil) {
            printf("error: Test bundle %s could not be found\n", 
                   [bundlePath UTF8String]);
            return -1;
        }
        if ( ! [testBundle load]) {
            printf("error: Test bundle %s could not be loaded\n", 
                   [bundlePath UTF8String]);
            return -1;
        }
        [runner addTestsFromBundle:testBundle];
        
    }
    
    // run
    
    [runner run];
    
    
    // create a retval based on whether or not any tests failed
    
    int retval;
    if ([runner testsFailed] == 0) {
        retval = 0;
    } else {
        retval = -1;
    }
    
    [reporter release];
    [runner release];

    return retval;
}

/*
void usage() 
{
    printf("Usage: ukrun [-qvx] [bundlename]...\n");
}
*/

@end
