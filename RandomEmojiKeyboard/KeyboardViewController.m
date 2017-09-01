//
//  KeyboardViewController.m
//  RandomEmojiKeyboard
//
//  Created by lola on 8/29/17.
//  Copyright © 2017 Lawrence Tran. All rights reserved.
//

#import "KeyboardViewController.h"
#import "REKEmoji.h"
#import "RandomEmojiKeyboard-Swift.h"

@interface KeyboardViewController ()
@property (nonatomic, strong) UIButton *nextKeyboardButton;
@property (nonatomic, strong) UIButton *emojiButton;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) UILabel *logoLabel;
@end

@implementation KeyboardViewController

- (void)updateViewConstraints {
  [super updateViewConstraints];
  
  // Add custom view sizing constraints here
}

- (void)viewDidLoad {
  [super viewDidLoad];
//  [self setupLogo];
  [self setupEmojiButton];
  [self setupNextKeyboardButton];
  [self setupDeleteButton];
  self.view.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:248.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated
}

- (void)textWillChange:(id<UITextInput>)textInput {
  // The app is about to change the document's contents. Perform any preparation here.
}

- (void)textDidChange:(id<UITextInput>)textInput {
  // The app has just changed the document's contents, the document context has been updated.
  
  UIColor *textColor = nil;
  if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark) {
    textColor = [UIColor whiteColor];
  } else {
    textColor = [UIColor blackColor];
  }
  [self.nextKeyboardButton setTitleColor:textColor forState:UIControlStateNormal];
}

#pragma mark - Setup

- (void)setupLogo {
  
  self.logoLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  [self.logoLabel setText:@"Random Emoji"];
  [self.logoLabel setFont:[UIFont systemFontOfSize:12.0f weight:UIFontWeightUltraLight]];
  [self.logoLabel setAlpha:0.2f];
  [self.logoLabel sizeToFit];
  self.logoLabel.translatesAutoresizingMaskIntoConstraints = NO;
  
  [self.view addSubview:self.logoLabel];
  
  [self.logoLabel.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-18.0].active = YES;
  [self.logoLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
}

- (void)setupEmojiButton {
  
  self.emojiButton = [UIButton buttonWithType:UIButtonTypeSystem];
  [self.emojiButton setTitle:@"\U0001F602" forState:UIControlStateNormal];
  [self.emojiButton.titleLabel setFont:[UIFont systemFontOfSize:95.0]];
  [self.emojiButton sizeToFit];
  self.emojiButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.emojiButton addTarget:self action:@selector(emojiButtonPressed) forControlEvents:UIControlEventTouchUpInside];
  
  [self.view addSubview:self.emojiButton];
  
  [self.emojiButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
  [self.emojiButton.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:-23.0].active = YES;
}

- (void)setupDeleteButton {
  
  self.deleteButton = [UIButton buttonWithType:UIButtonTypeSystem];
  [self.deleteButton setTitle:@"⌫" forState:UIControlStateNormal];
  [self.deleteButton.titleLabel setFont:[UIFont systemFontOfSize:20.0]];
  [self.deleteButton sizeToFit];
  self.deleteButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.deleteButton addTarget:self action:@selector(deleteButtonPressed) forControlEvents:UIControlEventTouchUpInside];
  
  [self.view addSubview:self.deleteButton];
  
  [self.deleteButton.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant: -40.0].active = YES;
  [self.deleteButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant: -5.0].active = YES;
}

- (void)setupNextKeyboardButton {
  
  self.nextKeyboardButton = [UIButton buttonWithType:UIButtonTypeSystem];
  [self.nextKeyboardButton setTitle:@"\U0001F310" forState:UIControlStateNormal];
  [self.nextKeyboardButton.titleLabel setFont:[UIFont systemFontOfSize:25.0]];
  [self.nextKeyboardButton sizeToFit];
  self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.nextKeyboardButton addTarget:self action:@selector(handleInputModeListFromView:withEvent:) forControlEvents:UIControlEventAllTouchEvents];
  
  [self.view addSubview:self.nextKeyboardButton];
  
  [self.nextKeyboardButton.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant: 40.0].active = YES;
  [self.nextKeyboardButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant: -5.0].active = YES;
}

#pragma mark - Private Methods

- (void)emojiButtonPressed {
  NSString *emoji = [REKEmoji randomEmoji];
  [self.textDocumentProxy insertText:emoji];
}

- (void)deleteButtonPressed {
  [self.textDocumentProxy deleteBackward];
}

@end
