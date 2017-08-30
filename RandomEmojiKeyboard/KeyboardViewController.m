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
@end

@implementation KeyboardViewController

- (void)updateViewConstraints {
  [super updateViewConstraints];
  
  // Add custom view sizing constraints here
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupEmojiButton];
  [self setupNextKeyboardButton];
  [self setupDeleteButton];
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

- (void)setupEmojiButton {
  
  self.emojiButton = [UIButton buttonWithType:UIButtonTypeSystem];
  [self.emojiButton setTitle:@"Emoji" forState:UIControlStateNormal];
  [self.emojiButton sizeToFit];
  self.emojiButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.emojiButton addTarget:self action:@selector(emojiButtonPressed) forControlEvents:UIControlEventTouchUpInside];
  
  [self.view addSubview:self.emojiButton];
  
  [self.emojiButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
  [self.emojiButton.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
}

- (void)setupDeleteButton {
  
  self.deleteButton = [UIButton buttonWithType:UIButtonTypeSystem];
  [self.deleteButton setTitle:@"Delete" forState:UIControlStateNormal];
  [self.deleteButton sizeToFit];
  self.deleteButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.deleteButton addTarget:self action:@selector(deleteButtonPressed) forControlEvents:UIControlEventTouchUpInside];
  
  [self.view addSubview:self.deleteButton];
  
  [self.deleteButton.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
  [self.deleteButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
}

- (void)setupNextKeyboardButton {
  
  self.nextKeyboardButton = [UIButton buttonWithType:UIButtonTypeSystem];
  [self.nextKeyboardButton setTitle:NSLocalizedString(@"Next Keyboard", @"Title for 'Next Keyboard' button") forState:UIControlStateNormal];
  [self.nextKeyboardButton sizeToFit];
  self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.nextKeyboardButton addTarget:self action:@selector(handleInputModeListFromView:withEvent:) forControlEvents:UIControlEventAllTouchEvents];
  
  [self.view addSubview:self.nextKeyboardButton];
  
  [self.nextKeyboardButton.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
  [self.nextKeyboardButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
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
