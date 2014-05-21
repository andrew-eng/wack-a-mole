//
//  UserInfo.h
//  Wack A Mole
//
//  Created by Andrew Eng on 21/5/14.
//  Copyright (c) 2014 Tutorial. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) NSInteger score;

@end
