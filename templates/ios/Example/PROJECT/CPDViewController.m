//
//  CPDViewController.m
//  PROJECT
//
//  Created by PROJECT_OWNER on TODAYS_DATE.
//  Copyright (c) TODAYS_YEAR PROJECT_OWNER. All rights reserved.
//

#import "CPDViewController.h"
@import LHXHowl;
@import LHXCore;

@interface CPDViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loadButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation CPDViewController

- (IBAction)onLoadApp:(id)sender {
    self.loadButton.enabled = NO;
    LHXApp *app = [LHXApp appWithConfiguration:[LHXApp currentApp].configuration];
    if (app.isDevelopmentMode) {
        [LHXApp setCurrentApp:app];
        [[[LHXApp currentApp] fetchAndLoadApp] continueWithExecutor:[BFExecutor mainThreadExecutor] withBlock:^id _Nullable(BFTask * _Nonnull t) {
            if (t.error) {
                self.textView.text = [NSString stringWithFormat:@"%@", t.error];
            }
            self.loadButton.enabled = YES;
            return nil;
        }];
    }
    else {
        [app loadApp];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    LHXAppConfiguration *configuration = [[LHXAppConfiguration alloc] init];
    configuration.host = @"0.0.0.0";
    configuration.appDomain = @"com.lighthousex.test";
#ifdef DEBUG
    configuration.developmentMode = YES;
#else
    configuration.developmentMode = NO;
#endif
    
    LHXApp *app = [LHXApp appWithConfiguration:configuration];
    
    [app start];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [LHXLogger registerExternalLog:self];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [LHXLogger removeExternalLog:self];
}

- (LHXLogLevel)logLevel {
    return LHXLogLevelInfo;
}

- (void)log:(LHXLogFlag)flag message:(NSString *)message {
    NSString *text = self.textView.text?:@"";
    text = [text stringByAppendingFormat:@"\n %@", message];
    LHXRunOnMainQueueSync(^{
        self.textView.text = text;
    });
}

@end
