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
        config.javascriptUserFilesDirectory = [ACE_POD_ROOT stringByAppendingPathComponent:@"Ace/Javascript/User/"];
        config.javascriptGenerateFilesDirectory = [ACE_POD_ROOT stringByAppendingPathComponent:@"Ace/Javascript/Machine/"];
        config.objcUserFilesDirectory = [ACE_POD_ROOT stringByAppendingPathComponent:@"Ace/ObjectiveC/User/"];
        config.objcGenerateFilesDirectory = [ACE_POD_ROOT stringByAppendingPathComponent:@"Ace/ObjectiveC/Machine/"];
        config.ignoredFilePath = [ACE_POD_ROOT stringByAppendingPathComponent:@"AceFileGenerator/Assets/template/ace-files-ignore"];
    }];
    
    [self.fileGenerator generateFilesForClasses:@[@"UIView", @"UIViewController"]];
}

+ (NSBundle *)resourcesBundle {
    NSBundle *appBuilderBundle = [NSBundle bundleForClass:self];
    NSString *path  = [appBuilderBundle pathForResource:@"PROJECT" ofType:@"bundle"];
    return [NSBundle bundleWithPath:path];
}

@end
