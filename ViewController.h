//
//  ViewController.h
//  FacebookIos9
//
//  Created by CI-07 on 10/12/15.
//  Copyright © 2015 CI-07. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface ViewController : UIViewController
{

     NSMutableArray *fb_friend_Name,*fb_friend_id;
    
}
- (IBAction)facebook_click:(id)sender;
- (IBAction)share_click:(id)sender;

@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;
@end

