//
//  ViewController.m
//  RandomEmoji
//
//  Created by lola on 8/29/17.
//  Copyright © 2017 Lawrence Tran. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *installedView;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  self.view.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:248.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
  [self.installedView setHidden: ![self isKeyboardInstalled]];
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (BOOL)isKeyboardInstalled {
  NSArray *installedKeyboards = [NSUserDefaults.standardUserDefaults objectForKey:@"AppleKeyboards"];
  if (installedKeyboards) {
    for (NSString *keyboard in installedKeyboards) {
      if ([keyboard  isEqual: @"com.lawrnce.RandomEmoji.RandomEmojiKeyboard"]) {
        return YES;
      }
    }
  }
  return NO;
}

- (IBAction)installButtonPressed:(id)sender {
}


@end
