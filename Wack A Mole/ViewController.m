//
//  ViewController.m
//  Wack A Mole
//
//  Created by Andrew Eng on 21/5/14.
//  Copyright (c) 2014 Tutorial. All rights reserved.
//

#import "ViewController.h"
#import "UserInfo.h"
#import "GameViewController.h"

@interface ViewController () <UITextFieldDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *profileButton;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

@property (nonatomic, strong) UserInfo *userInfo;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.userInfo = [[UserInfo alloc] init];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)didChangeValue:(id)sender
{
    self.userInfo.name = self.textField.text;
    [self updateStartButton];
}

- (void)updateStartButton
{
    BOOL hasName = self.userInfo.name.length > 0;
    BOOL hasImage = self.userInfo.image != nil;
    
    self.startButton.enabled = hasName && hasImage;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"imagePicker"]) {
        UIImagePickerController *controller = [[segue destinationViewController] init];
        controller.delegate = self;
        controller.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    
    if ([segue.identifier isEqualToString:@"game"]) {
        GameViewController *controller = [segue destinationViewController];
        controller.userInfo = self.userInfo;
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.profileButton setImage:image forState:UIControlStateNormal];
    self.userInfo.image = image;
    [self updateStartButton];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
