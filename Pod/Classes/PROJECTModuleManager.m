//
//  PROJECTModuleManager.m
//  Pods
//
//  Created by Zitao Xiong on 6/20/17.
//
//

#import "PROJECTModuleManager.h"

@implementation PROJECTModuleManager
+ (NSUInteger)applicationModuleLoadPriority; {
    return 1000;
}

+ (NSArray<NSString *> *)applicationModuleClasses {
    NSString *classesPath = [[self moduleBundle] pathForResource:@"Classes" ofType:@"plist"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:classesPath]) {
        NSDictionary *classesDict = [[NSDictionary alloc] initWithContentsOfFile:classesPath];
        NSArray *classes = classesDict[@"classes"];
        return classes;
    }
    
    return nil;
}

+ (NSBundle *)moduleBundle {
    NSBundle *appBuilderBundle = [NSBundle bundleForClass:self];
    NSString *path  = [appBuilderBundle pathForResource:@"PROJECT" ofType:@"bundle"];
    return [NSBundle bundleWithPath:path];
}
@end
