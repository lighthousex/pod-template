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
    NSString *classesPath = [[self moduleBundle] pathForResource:@"Classes" ofType:@"plist"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:classesPath]) {
        NSDictionary *classesDict = [[NSDictionary alloc] initWithContentsOfFile:classesPath];
        NSArray *classes = classesDict[@"classes"];
        return classes;
    }
    
    return nil;
}

+ (NSBundle * _Nullable)applicationAssetsBundle {
    NSBundle *appBuilderBundle = [NSBundle bundleForClass:self];
    NSString *path  = [appBuilderBundle pathForResource:@"${POD_NAME}" ofType:@"bundle"];
    return [NSBundle bundleWithPath:path];
}
@end
