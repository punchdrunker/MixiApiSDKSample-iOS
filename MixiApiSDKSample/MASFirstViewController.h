//
//  MASFirstViewController.h
//  MixiApiSDKSample
//
//  Created by 七尾 貴史 on 2014/02/21.
//  Copyright (c) 2014年 七尾 貴史. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MixiSDK.h"

@interface MASFirstViewController : UIViewController <MixiSDKAuthorizerDelegate, MixiDelegate>

- (IBAction)authButtonPushed:(id)sender;
- (IBAction)getFriendListButtonPushed:(id)sender;
- (IBAction)getVoiceListButtonPushed:(id)sender;

- (void)closeDownloadView:(id)sender;

- (void)mixi:(Mixi*)mixi didFinishLoading:(NSString*)data;
- (void)authorizer:(MixiSDKAuthorizer*)authorizer didSuccessWithEndpoint:(NSString*)endpoint;
- (void)authorizer:(MixiSDKAuthorizer*)authorizer didCancelWithEndpoint:(NSString*)endpoint;
- (void)authorizer:(MixiSDKAuthorizer*)authorizer didFailWithEndpoint:(NSString*)endpoint error:(NSError*)error;

@end
