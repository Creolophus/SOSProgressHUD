//
//  ViewController.m
//  SVProgressHUD, https://github.com/SVProgressHUD/SVProgressHUD
//
//  Copyright (c) 2011-2018 Sam Vermette and contributors. All rights reserved.
//

#import "ViewController.h"
#import "SVProgressHUD.h"
#import "UIImage+GIFImage.h"

@interface ViewController()

@property (nonatomic, readwrite) NSUInteger activityCount;
@property (weak, nonatomic) IBOutlet UIButton *popActivityButton;

@end

@implementation ViewController


#pragma mark - ViewController lifecycle

- (void)viewDidLoad{
    [super viewDidLoad];
    self.activityCount = 0;
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setFont:[UIFont systemFontOfSize:14]];
    [SVProgressHUD setSubFont:[UIFont systemFontOfSize:12]];
    [SVProgressHUD setHapticsEnabled:YES];
    [SVProgressHUD setMinimumSize:CGSizeMake(110, 0)];
    [SVProgressHUD setImageViewSize:CGSizeMake(48, 48)];
    [SVProgressHUD setSuccessImage:[UIImage imageWithGIFNamed:@"icon_feedback_success_48x48"]];
    [SVProgressHUD setInfoImage:[UIImage imageWithGIFNamed:@"icon_feedback_attention_48x48"]];
    [SVProgressHUD setErrorImage:[UIImage imageWithGIFNamed:@"icon_feedback_fail_48x48"]];
    [SVProgressHUD setLoadingImage:[UIImage imageWithGIFNamed:@"icon_feedback_wait_48x48"]];
    [SVProgressHUD setMaximumDismissTimeInterval:2];
    [SVProgressHUD setMinimumDismissTimeInterval:2];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:SVProgressHUDWillAppearNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:SVProgressHUDDidAppearNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:SVProgressHUDWillDisappearNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:SVProgressHUDDidDisappearNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:SVProgressHUDDidReceiveTouchEventNotification
                                               object:nil];
    
    [self addObserver:self forKeyPath:@"activityCount" options:NSKeyValueObservingOptionNew context:nil];
}


#pragma mark - Notification handling

- (void)handleNotification:(NSNotification *)notification {
    NSLog(@"Notification received: %@", notification.name);
    NSLog(@"Status user info key: %@", notification.userInfo[SVProgressHUDStatusUserInfoKey]);
    
    if([notification.name isEqualToString:SVProgressHUDDidReceiveTouchEventNotification]){
        [self dismiss];
    }
}


#pragma mark - Show Methods Sample

- (void)show {
    [SVProgressHUD show];
    self.activityCount++;
}

- (void)showWithStatus {
	[SVProgressHUD showWithStatus:@"Doing Stuff"];
    self.activityCount++;
}

static float progress = 0.0f;

- (IBAction)showWithProgress:(id)sender {
    progress = 0.0f;
    [SVProgressHUD showProgress:0 status:@"Loading" subStatus:@"违法及沃尔夫今儿我房间额外附件围殴if加尔文覅偶耳温计覅we附件为偶发金额为穷疯"];
    [self performSelector:@selector(increaseProgress) withObject:nil afterDelay:0.1f];
    self.activityCount++;
}

- (void)increaseProgress {
    progress += 0.05f;
    [SVProgressHUD showProgress:progress status:@"Loading" subStatus:@"违法及沃尔夫今儿我房间额外附件围殴if加尔文覅偶耳温计覅we附件为偶发金额为穷疯"];

    if(progress < 1.0f){
        [self performSelector:@selector(increaseProgress) withObject:nil afterDelay:0.1f];
    } else {
        if (self.activityCount > 1) {
            [self performSelector:@selector(popActivity) withObject:nil afterDelay:0.4f];
        } else {
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.4f];
        }
    }
}


#pragma mark - Dismiss Methods Sample

- (void)dismiss {
	[SVProgressHUD dismiss];
    self.activityCount = 0;
}

- (IBAction)popActivity {
    [SVProgressHUD popActivity];
    
    if (self.activityCount != 0) {
        self.activityCount--;
    }
}

- (IBAction)showInfoWithStatus {
    [SVProgressHUD showInfoWithStatus:@"Useful Information."];
    self.activityCount++;
}

- (void)showSuccessWithStatus {
    [SVProgressHUD showSuccessWithStatus:@"成功" subStatus:@"sub读取中读取中读取中读取中读取中读取中读取中读取中"];
    self.activityCount++;
}

- (void)showErrorWithStatus {
	[SVProgressHUD showErrorWithStatus:@"Failed with Error"];
    self.activityCount++;
}


#pragma mark - Styling

- (IBAction)changeStyle:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl*)sender;
    if(segmentedControl.selectedSegmentIndex == 0){
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    } else {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    }
}

- (IBAction)changeAnimationType:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl*)sender;
    if(segmentedControl.selectedSegmentIndex == 0){
        [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    } else if (segmentedControl.selectedSegmentIndex == 1) {
        [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    }else {
        [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeGIF];
    }
}

- (IBAction)changeMaskType:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl*)sender;
    if(segmentedControl.selectedSegmentIndex == 0){
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    } else if(segmentedControl.selectedSegmentIndex == 1){
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    } else if(segmentedControl.selectedSegmentIndex == 2){
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    } else if(segmentedControl.selectedSegmentIndex == 3){
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    } else {
        [SVProgressHUD setBackgroundLayerColor:[[UIColor redColor] colorWithAlphaComponent:0.4]];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
    }
}


#pragma mark - Helper

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"activityCount"]){
        unsigned long activityCount = [[change objectForKey:NSKeyValueChangeNewKey] unsignedLongValue];
        [self.popActivityButton setTitle:[NSString stringWithFormat:@"popActivity - %lu", activityCount] forState:UIControlStateNormal];
    }
}

@end
