//
//  SubmitViewController.m
//  Wack A Mole
//
//  Created by Andrew Eng on 22/5/14.
//  Copyright (c) 2014 Tutorial. All rights reserved.
//

#import "SubmitViewController.h"

@interface SubmitViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation SubmitViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.imageView.image = self.userInfo.image;
    self.nameLabel.text = [NSString stringWithFormat:@"Name: %@", self.userInfo.name];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.userInfo.score];
    
    self.navigationItem.hidesBackButton = YES;
}

- (IBAction)didTapSubmitButton:(id)sender {
    
}

- (IBAction)didTapResetButton:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
