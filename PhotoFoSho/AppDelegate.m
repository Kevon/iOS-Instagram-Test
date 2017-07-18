//
//  AppDelegate.m
//  PhotoFoSho
//
//  Created by Kevin on 5/19/16.
//  Copyright © 2016 Kevin Skompinski. All rights reserved.
//

#import "AppDelegate.h"
#import "NXOauth2.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [[NXOAuth2AccountStore sharedStore] setClientID:@"b551166e9ffb4abca91311e3dc1a84f3"
                                             secret:@"f605e65766474a329b1485f651614899"
                                   authorizationURL:[NSURL URLWithString:@"https://api.instagram.com/oauth/authorize"]
                                           tokenURL:[NSURL URLWithString:@"https://api.instagram.com/oauth/access_token"]
                                        redirectURL:[NSURL URLWithString:@"zombo://zombo.com"]
                                     forAccountType:@"Instagram"];
    
    return YES;
}

- (BOOL) application:(UIApplication *) app openURL:(NSURL *)url options:(nonnull NSDictionary<NSString *,id> *)options{
    return [[NXOAuth2AccountStore sharedStore] handleRedirectURL:url];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
