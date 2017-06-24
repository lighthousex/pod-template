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
        config.javascriptUserFilesDirectory = [ACE_POD_ROOT stringByAppendingPathComponent:@"../ace-apps/lib/user"];
        config.javascriptGenerateFilesDirectory = [ACE_POD_ROOT stringByAppendingPathComponent:@"../ace-apps/lib/machine"];
        config.objcUserFilesDirectory = [ACE_POD_ROOT stringByAppendingPathComponent:@"../PROJECT/Ace/ObjectiveC/User/"];
        config.objcGenerateFilesDirectory = [ACE_POD_ROOT stringByAppendingPathComponent:@"../PROJECT/Ace/ObjectiveC/Machine/"];
        
        config.ignoredFilePath = [ACE_POD_ROOT stringByAppendingPathComponent:@"../AceFileGenerator-template/ace-files-ignore"];
        config.templateDirectory = [ACE_POD_ROOT stringByAppendingPathComponent:@"../AceFileGenerator-template/"];
    }];
    
    self.fileGenerator.delegate = self;
    
    self.fileGenerator.projectName = @"PROJECT";
    
    NSString *classesPath = [[NSBundle mainBundle] pathForResource:@"Classes" ofType:@"plist"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:classesPath]) {
        NSDictionary *classesDict = [[NSDictionary alloc] initWithContentsOfFile:classesPath];
        NSArray *classes = classesDict[@"classes"];
        if ([classes isKindOfClass:[NSArray class]]) {
            NSMutableString *errorText = [[NSMutableString alloc] init];
            [classes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (!NSClassFromString(obj)) {
                    NSString *message = [NSString stringWithFormat:@"Can't find class %@. Did you forget to add it into Podspec?\n", obj];
                    NSLog(@"%@", message);
                    [errorText appendString:message];
                }
            }];
            if (errorText.length == 0) {
                [self.fileGenerator generateFilesForClasses:classes];
                self.textView.text = [classes componentsJoinedByString:@", "];
            }
            else {
                self.textView.text = errorText;
                self.statusLabel.text = @"Fix needed";
            }
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
    self.statusLabel.text = @"Finished. Waiting for Change...";
}
@end
