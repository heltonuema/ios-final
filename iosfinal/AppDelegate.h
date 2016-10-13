//
//  AppDelegate.h
//  iosfinal
//
//  Created by Helton Shinhei Uema on 13/10/16.
//  Copyright © 2016 Helton Shinhei Uema. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

