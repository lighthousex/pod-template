//
//  ${POD_NAME}ModuleManager.m
//  Pods
//
//  Created by Zitao Xiong on 6/20/17.
//
//

#import "${POD_NAME}ModuleManager.h"

@implementation ${POD_NAME}ModuleManager
+ (NSUInteger)applicationModuleLoadPriority; {
    return 1000;
}

+ (NSArray<NSString *> *)applicationModuleClasses {
    NSString *classesPath = [[self applicationAssetsBundle] pathForResource:@"${POD_NAME}" ofType:@"plist"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:classesPath]) {
        NSDictionary *classesDict = [[NSDictionary alloc] initWithContentsOfFile:classesPath];
        NSArray *classes = classesDict[@"classes"];
        return classes;
    }
    
    return nil;
}

+ (NSArray<NSString *> * _Nullable)applicationModuleScripts {
    NSString *scriptPath = [[self applicationAssetsBundle] pathForResource:@"index.min.js" ofType:nil];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:scriptPath]) {
        NSError *error;
        NSString *script = [[NSString alloc] initWithContentsOfFile:scriptPath encoding:NSUTF8StringEncoding error:&error];
        if (error) {
            LHXLogError(@"read script file error: %@", error);
            return nil;
        }
        if (script.length == 0) {
            LHXLogWarning(@"script is empty");
            return nil;
        }
        return @[
                 script,
                 ];
    }
    return nil;
}

+ (NSBundle * _Nullable)applicationAssetsBundle {
    return [NSBundle bundleForClass:self];
}
@end
