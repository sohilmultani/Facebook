//
//  ViewController.m
//  FacebookIos9
//
//  Created by CI-07 on 10/12/15.
//  Copyright © 2015 CI-07. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)facebook_click:(id)sender
{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
  
    //  login.loginBehavior=FBSDKLoginBehaviorWeb;
    
    //[login logInWithReadPermissions:@[@"public_profile", @"email", @"user_friends"],fromViewController:self, handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)  <===Deprecated

    [login logInWithReadPermissions:@[@"public_profile", @"email", @"user_friends"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)
     {
         if (error)
         {
             // Process error
             NSLog(@"error is :%@",error);
         }
         else if (result.isCancelled)
         {
             // Handle cancellations
             NSLog(@"error is :%@",error);
         }
         else
         {
             if ([result.grantedPermissions containsObject:@"email"])
             {
                 NSLog(@"Login successfull");
                 [self fetchUserInfo];
                 [login logOut];
             }
         }
     }];
}

- (IBAction)share_click:(id)sender {
    
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    content.contentURL = [NSURL URLWithString:@"https://developers.facebook.com"];
}


-(void)fetchUserInfo
{
    if ([FBSDKAccessToken currentAccessToken])
    {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id,name,link,first_name, last_name, picture.type(large), email, birthday,friends,gender,age_range,cover"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error)
             {
                 NSLog(@"result is :%@",result);
           /*    NSLog(@"User ID : %@",[result valueForKey:@"id"]);
                 NSLog(@"User Name : %@",[result valueForKey:@"name"]);
                 NSLog(@"User First Name :%@",[result valueForKey:@"first_name"]);
                 NSLog(@"User Last Name :%@",[result valueForKey:@"last_name"]);
                 NSLog(@"USER Email is :%@",[result valueForKey:@"email"]);
                 NSLog(@"User fb_Link : %@",[result valueForKey:@"link"]);
                 NSLog(@"User Birthday : %@",[result valueForKey:@"birthday"]);
                 NSLog(@"FB Profile Photo Link :%@",[[[result valueForKey:@"picture"]objectForKey:@"data"]objectForKey:@"url"]);
                 NSLog(@"User total friends : %@",[[[result valueForKey:@"friends"]objectForKey:@"summary"]valueForKey:@"total_count"]);
                 NSLog(@"User Gender : %@",[result valueForKey:@"gender"]);
                 NSLog(@"User age_range : %@",[[result valueForKey:@"age_range"]objectForKey:@"min"]);
                 NSLog(@"User cover Photo Link : %@",[[result valueForKey:@"cover"]objectForKey:@"source"]);
             */
                 //Friend List ID And Name
                 NSArray * allKeys = [[result valueForKey:@"friends"]objectForKey:@"data"];
                 
                 fb_friend_Name = [[NSMutableArray alloc]init];
                 fb_friend_id  =  [[NSMutableArray alloc]init];
                 
                 for (int i=0; i<[allKeys count]; i++)
                 {
                     [fb_friend_Name addObject:[[[[result valueForKey:@"friends"]objectForKey:@"data"] objectAtIndex:i] valueForKey:@"name"]];
                     
                     [fb_friend_id addObject:[[[[result valueForKey:@"friends"]objectForKey:@"data"] objectAtIndex:i] valueForKey:@"id"]];
                     
                 }
                 NSLog(@"Friends ID : %@",fb_friend_id);
                 NSLog(@"Friends Name : %@",fb_friend_Name);
             }
         }];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
