//
//  MASFirstViewController.m
//  MixiApiSDKSample
//
//  Created by 七尾 貴史 on 2014/02/21.
//  Copyright (c) 2014年 七尾 貴史. All rights reserved.
//

#import "MASFirstViewController.h"
#import "MixiSDK.h"

@interface MASFirstViewController ()

@end

@implementation MASFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MixiDelegate

- (void)mixi:(Mixi*)mixi didFinishLoading:(NSString*)data {
    [[[UIAlertView alloc]
      initWithTitle:@"API RESULT"
      message:data
      delegate:nil
      cancelButtonTitle:nil
      otherButtonTitles:@"OK", nil
      ] show];
}

#pragma mark - MixiSDKAuthorizerDelegate

- (void)authorizer:(MixiSDKAuthorizer*)authorizer didSuccessWithEndpoint:(NSString*)endpoint {
    [[[UIAlertView alloc]
      initWithTitle:@"RESULT"
      message:@"didSuccessWithEndpoint"
      delegate:nil
      cancelButtonTitle:nil
      otherButtonTitles:@"OK", nil
      ] show];
}

- (void)authorizer:(MixiSDKAuthorizer*)authorizer didCancelWithEndpoint:(NSString*)endpoint {
    [[[UIAlertView alloc]
      initWithTitle:@"RESULT"
      message:@"didCancelWithEndpoint"
      delegate:nil
      cancelButtonTitle:nil
      otherButtonTitles:@"OK", nil
      ] show];
}

- (void)authorizer:(MixiSDKAuthorizer*)authorizer didFailWithEndpoint:(NSString*)endpoint error:(NSError*)error {
    [[[UIAlertView alloc]
      initWithTitle:@"RESULT"
      message:@"didFailWithEndpoint"
      delegate:nil
      cancelButtonTitle:nil
      otherButtonTitles:@"OK", nil
      ] show];
}

- (void)closeDownloadView:(id)sender {
    NSLog(@"closeDownloadView");
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - UIActions
- (IBAction)authButtonPushed:(id)sender {
    Mixi *mixi = [Mixi sharedMixi];
    if ([mixi isAuthorized]) {
        [[[UIAlertView alloc]
          initWithTitle:@"RESULT"
          message:@"you are authoriozed"
          delegate:nil
          cancelButtonTitle:nil
          otherButtonTitles:@"OK", nil
          ] show];
    }
    else {
        mixi.authorizer.parentViewController = [self parentViewController];
        mixi.authorizer.delegate = self;
        [mixi authorize:@"r_profile", @"r_voice", nil];
    }
}

- (IBAction)getFriendListButtonPushed:(id)sender {
    Mixi *mixi = [Mixi sharedMixi];
    if ([mixi isAuthorized]) {
        MixiRequest *request = [MixiRequest requestWithEndpoint:@"/people/@me/@friends"];
        [mixi sendRequest:request delegate:self];
    }
    else if (![mixi authorizeForPermission:@"r_profile"]) {
        MixiWebViewController *vc = MixiUtilDownloadViewController(self, @selector(closeDownloadView:));
        [self presentViewController:vc animated:YES completion:nil];
    }
}

- (IBAction)getVoiceListButtonPushed:(id)sender {
    Mixi *mixi = [Mixi sharedMixi];
    if ([mixi isAuthorized]) {
        MixiRequest *request = [MixiRequest requestWithEndpoint:@"/voice/statuses/friends_timeline"];
        [mixi sendRequest:request delegate:self];
    }
    else if (![mixi authorizeForPermission:@"r_voice"]) {
        MixiWebViewController *vc = MixiUtilDownloadViewController(self, @selector(closeDownloadView:));
        [self presentViewController:vc animated:YES completion:nil];
    }
}

@end
