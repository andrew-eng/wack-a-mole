//
//  GameViewController.m
//  Wack A Mole
//
//  Created by Andrew Eng on 22/5/14.
//  Copyright (c) 2014 Tutorial. All rights reserved.
//

#import "GameViewController.h"
#import "SubmitViewController.h"

#import <AVFoundation/AVFoundation.h>

@interface GameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) float time;

@property (nonatomic, strong) AVAudioPlayer *backgroundPlayer;
@property (nonatomic, strong) AVAudioPlayer *hitPlayer;
@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.userInfo.score = 0;
    self.time = 22;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.2
                                                  target:self
                                                selector:@selector(showRandomButton)
                                                userInfo:nil
                                                 repeats:YES];

    for (int i=0; i<self.buttons.count; i++) {
        UIButton *button = self.buttons[i];
        button.hidden = YES;
    }

    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"Melody 1" ofType:@"mp3"];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];

    self.backgroundPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
    self.backgroundPlayer.numberOfLoops = -1; //infinite


    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"bomb" ofType:@"mp3"];
    self.hitPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:soundPath]
                                                            error:nil];
    self.hitPlayer.numberOfLoops = 0;

    [self.backgroundPlayer play];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.timer invalidate];
    self.timer = nil;

    [self.backgroundPlayer stop];
}

- (void)showRandomButton
{
    NSInteger randomIndex = arc4random() % self.buttons.count;
    
    UIButton *button = self.buttons[randomIndex];
    
    if (button.hidden) {
//        NSInteger randomType = arc4random() % 2;
//        
//        if (randomType == 0) {
//            button.backgroundColor = [UIColor blueColor];
//            button.tag = 1;
//        } else {
//            button.backgroundColor = [UIColor redColor];
//            button.tag = -1;
//        }

//        button.backgroundColor = [UIColor blueColor];

        button.hidden = NO;

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            button.hidden = YES;
        });
    }
    
    self.time -= 0.2;
    self.timeLabel.text = [NSString stringWithFormat:@"Time: %.1f", self.time];
    if (self.time < 0.2) {
        [self.timer invalidate];
        self.timer = nil;
        [self performSegueWithIdentifier:@"submit" sender:self];
    }
}

- (IBAction)didTapButton:(UIButton *)sender
{
    self.userInfo.score++;
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.userInfo.score];

    [self.hitPlayer play];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"submit"]) {
        SubmitViewController *controller = segue.destinationViewController;
        controller.userInfo = self.userInfo;
    }
}

@end
