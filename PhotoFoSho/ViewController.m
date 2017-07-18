//
//  ViewController.m
//  PhotoFoSho
//
//  Created by Kevin on 5/19/16.
//  Copyright © 2016 Kevin Skompinski. All rights reserved.
//

#import "ViewController.h"
#import "NXOAuth2.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *LogIn;
@property (weak, nonatomic) IBOutlet UIButton *LogOut;
@property (weak, nonatomic) IBOutlet UIButton *Refresh;
@property (weak, nonatomic) IBOutlet UIImageView *Picture;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.LogOut.enabled = NO;
    self.Refresh.enabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)LogInPressed:(id)sender {
    [[NXOAuth2AccountStore sharedStore] requestAccessToAccountWithType:@"Instagram"];
    self.LogIn.enabled = NO;
    self.LogOut.enabled = YES;
    self.Refresh.enabled = YES;
}

- (IBAction)LogOutPressed:(id)sender {
    NXOAuth2AccountStore *store = [NXOAuth2AccountStore sharedStore];
    NSArray *accounts = [store accountsWithAccountType:@"Instagram"];
    for(id acct in accounts){
        [store removeAccount:acct];
    }
    self.LogIn.enabled = YES;
    self.LogOut.enabled = NO;
    self.Refresh.enabled = NO;
}

- (IBAction)RefreshPressed:(id)sender {
    NXOAuth2AccountStore *store = [NXOAuth2AccountStore sharedStore];
    NSArray *accounts = [store accountsWithAccountType:@"Instagram"];
    if ([accounts count] == 0){
        return;
    }
    NXOAuth2Account *acct = accounts[0];
    NSString *token = acct.accessToken.accessToken;
    NSString *urlStr = [@"https://api.instagram.com/v1/users/self/media/recent/?access_token=" stringByAppendingString:token];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:url completionHandler:^(NSData * data, NSURLResponse * response, NSError * error){
        if(error){
            return;
        }
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (httpResponse.statusCode < 200 || httpResponse.statusCode >= 300){
            return;
        }
        NSError *parseError;
        id pkg = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
        if (!pkg){
            return;
        }
        
        NSString *imageURLString = pkg[@"data"][0][@"images"][@"standard_resolution"][@"url"];
        NSURL *imageURL = [NSURL URLWithString:imageURLString];
        [[session dataTaskWithURL:imageURL completionHandler:^(NSData * data, NSURLResponse * response, NSError * error){
                if(error){
                    return;
                }
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                if (httpResponse.statusCode < 200 || httpResponse.statusCode >= 300){
                    return;
                }
        
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.Picture.image = [UIImage imageWithData:data];
                });
        
        
        }] resume];
        
      }]resume];
    
    
    
}

@end
