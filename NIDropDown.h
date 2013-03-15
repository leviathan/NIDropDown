//
//  NIDropDown.h
//  NIDropDown
//
//  Created by Bijesh N on 12/28/12.
//  Further development by Joerg Polakowski
//
//  Copyright (c) 2012 Nitor Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NIDropDown;

typedef NS_ENUM(NSInteger, NIDropDownAnimationDirection) {
    NIDropDownAnimationDirectionUp,
    NIDropDownAnimationDirectionDown
};

//***************************************************************************************
// Drop down view delegate protocol definition
//***************************************************************************************
@protocol NIDropDownViewDelegate
- (void)niDropDownClosed:(NIDropDown *)sender withSelection:(id)selection;
@end

//***************************************************************************************
// Public Interface declaration
//***************************************************************************************
@interface NIDropDown : UIView <UITableViewDelegate, UITableViewDataSource>

@property(strong) id <NIDropDownViewDelegate> delegate;
@property(assign, readonly) NIDropDownAnimationDirection animationDirection;


- (id)initDropDownFor:(UIControl *)theControl
               height:(CGFloat)theHeight
             elements:(NSArray *)theElements
            direction:(NIDropDownAnimationDirection)theDirection;

- (void)hideDropDown:(UIControl *)theControl;

@end
