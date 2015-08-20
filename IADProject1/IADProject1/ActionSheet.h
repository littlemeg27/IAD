//
//  ActionSheet.h
//  IADProject1
//
//  Created by Brenna Pavlinchak on 8/20/15.
//  Copyright (c) 2015 Brenna Pavlinchak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActionSheet : NSObject <UIActionSheetDelegate>

-(id)initWithTitle:(NSString *)title delegate:(id<UIActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;

-(void)showInView:(UIView *)view withCompletionHandler:(void(^)(NSString *buttonTitle, NSInteger buttonIndex))handler;

@end
