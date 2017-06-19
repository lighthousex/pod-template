//
//  CPDViewController.m
//  PROJECT
//
//  Created by PROJECT_OWNER on TODAYS_DATE.
//  Copyright (c) TODAYS_YEAR PROJECT_OWNER. All rights reserved.
//

#import "CPDViewController.h"
@import AceFileGenerator;

@interface CPDViewController ()<LHXFileGeneratorDelegate>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (nonatomic, strong) LHXFileGenerator *fileGenerator;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation CPDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fileGenerator = [LHXFileGenerator generatorWithConfiguration:^(AceFileGeneratorConfiguration *config) {
        config.javascriptUserFilesDirectory = [ACE_POD_ROOT stringByAppendingPathComponent:@"../PROJECT/Ace/Javascript/User/"];
        config.javascriptGenerateFilesDirectory = [ACE_POD_ROOT stringByAppendingPathComponent:@"../PROJECT/Ace/Javascript/Machine/"];
        config.objcUserFilesDirectory = [ACE_POD_ROOT stringByAppendingPathComponent:@"../PROJECT/Ace/ObjectiveC/User/"];
        config.objcGenerateFilesDirectory = [ACE_POD_ROOT stringByAppendingPathComponent:@"../PROJECT/Ace/ObjectiveC/Machine/"];
        
        config.ignoredFilePath = [ACE_POD_ROOT stringByAppendingPathComponent:@"../AceFileGenerator-template/ace-files-ignore"];
        config.templateDirectory = [ACE_POD_ROOT stringByAppendingPathComponent:@"../AceFileGenerator-template/"];
    }];
    
    self.fileGenerator.delegate = self;
    
    NSString *classesPath = [[NSBundle mainBundle] pathForResource:@"Classes" ofType:@"plist"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:classesPath]) {
        NSDictionary *classesDict = [[NSDictionary alloc] initWithContentsOfFile:classesPath];
        NSArray *classes = classesDict[@"classes"];
        if ([classes isKindOfClass:[NSArray class]]) {
            [self.fileGenerator generateFilesForClasses:classes];
            self.textView = [classes componentsJoinedByString:@", "];
            return;
        }
    }
    
    self.statusLabel.text = @"Can't find classes to run, check documentation.";
}

+ (NSBundle *)resourcesBundle {
    NSBundle *appBuilderBundle = [NSBundle bundleForClass:self];
    NSString *path  = [appBuilderBundle pathForResource:@"PROJECT" ofType:@"bundle"];
    return [NSBundle bundleWithPath:path];
}

- (void)fileGeneratorWillEnterGeneratingState:(LHXFileGenerator *)generator {
    [self.activityIndicator startAnimating];
    self.activityIndicator.hidden = NO;
    self.statusLabel.text = @"Generating...";
}

- (void)fileGeneratorWilLEnterIdleState:(LHXFileGenerator *)generator {
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = YES;
    self.statusLabel.text = @"Waiting for Change...";
}
@end
