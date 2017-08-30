//
//  REKEmoji.m
//  RandomEmoji
//
//  Created by lola on 8/29/17.
//  Copyright © 2017 Lawrence Tran. All rights reserved.
//

#import "REKEmoji.h"
#import "RandomEmojiKeyboard-Swift.h"

static NSArray *_emojis = nil;

@implementation REKEmoji

+ (NSString *)randomEmoji {
  
  NSString *emoji;
  
  do {
    emoji = [self randomUnicodeEmoji];
  } while (![self isValidEmoji:emoji]);
  
  return emoji;
}

#pragma mark - Private Methods
+ (NSString *)randomUnicodeEmoji {
  NSUInteger count = [_emojis count];
  NSInteger randomIndex = arc4random() % count;
  
  return _emojis[randomIndex];
}

+ (NSData *)characterData:(NSString *)character {
  
  NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:10.0f]};
  CGSize size = [character sizeWithAttributes:attributes];
  
  UIGraphicsBeginImageContext(size);
  [character drawAtPoint:CGPointMake(0.0f, 0.0f) withAttributes:attributes];
  
  NSData *characterData;
  UIImage *characterImage = UIGraphicsGetImageFromCurrentImageContext();
  
  if (characterImage) {
    characterData = UIImagePNGRepresentation(characterImage);
  }
  UIGraphicsEndImageContext();
  
  return characterData;
}

+ (BOOL)isValidEmoji:(NSString *)emojiCode {
  NSString *referenceCharacter = @"\U0001F3F6";
  
  NSData *referenceData = [self characterData:referenceCharacter];
  NSData *testData = [self characterData:emojiCode];
  
  if (referenceData && testData) {
    return ![referenceData isEqual:testData];
  }
  
  return NO;
}

#pragma mark - Emojis

+ (void)initialize {
  _emojis = [[[EmojiData new] dictionary] allValues];
}

@end
