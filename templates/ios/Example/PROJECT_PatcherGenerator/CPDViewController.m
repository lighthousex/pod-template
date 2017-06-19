//
//  CPDViewController.m
//  PROJECT
//
//  Created by PROJECT_OWNER on TODAYS_DATE.
//  Copyright (c) TODAYS_YEAR PROJECT_OWNER. All rights reserved.
//

#import "CPDViewController.h"
@import AceFileGenerator;

@interface CPDViewController ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (nonatomic, strong) LHXFileGenerator *fileGenerator;
@end

@implementation CPDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fileGenerator = [LHXFileGenerator generatorWithConfiguration:^(AceFileGeneratorConfiguration *config) {
        config.javascriptUserFilesDirectory = [PROJECT_DIR stringByAppendingString:@"../Ace/Javascript/User/"];
        config.javascriptGenerateFilesDirectory = [PROJECT_DIR stringByAppendingString:@"../Ace/Javascript/Machine/"];
        config.objcUserFilesDirectory = [PROJECT_DIR stringByAppendingString:@"../Ace/ObjectiveC/User/"];
        config.objcGenerateFilesDirectory = [PROJECT_DIR stringByAppendingString:@"../Ace/ObjectiveC/Machine/"];
        config.ignoredFilePath = [PROJECT_DIR stringByAppendingString:@"../AceFileGenerator/Assets/template/ace-files-ignore"];
    }];
    
    [self.fileGenerator generateFilesForClasses:@[@"UIView", @"UIViewController"]];
}

+ (NSBundle *)resourcesBundle {
    NSBundle *appBuilderBundle = [NSBundle bundleForClass:self];
    NSString *path  = [appBuilderBundle pathForResource:@"PROJECT" ofType:@"bundle"];
    return [NSBundle bundleWithPath:path];
}

@end
