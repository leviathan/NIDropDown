//
//  NIDropDown.m
//  NIDropDown
//
//  Created by Bijesh N on 12/28/12.
//  Further development by Joerg Polakowski
//
//  Copyright (c) 2012 Nitor Infotech. All rights reserved.
//

#import "NIDropDown.h"
#import "QuartzCore/QuartzCore.h"

//***************************************************************************************
// Private interface declaration
//***************************************************************************************
@interface NIDropDown ()

@property(assign, readwrite) NIDropDownAnimationDirection animationDirection;
@property(assign) CGFloat dropDownHeight;

@property(strong) UITableView *table;
@property(strong) UIControl *control;
@property(strong) NSArray *list;

@end

//***************************************************************************************
// Public interface implementation
//***************************************************************************************
@implementation NIDropDown

- (id)init {
    self = [super init];
    if (self) {
        // setup default values
        self.dropDownHeight = 200.0;
        self.list = [NSArray array];
        self.animationDirection = NIDropDownAnimationDirectionUp;
    }
    return self;
}

- (id)initDropDownFor:(UIControl *)theControl
               height:(CGFloat)theHeight
             elements:(NSArray *)theElements
            direction:(NIDropDownAnimationDirection)theDirection {

    self = [super init];
    if (self) {

        self.control = theControl;
        self.dropDownHeight = theHeight;
        self.list = theElements;
        self.animationDirection = theDirection;


        CGRect btn = self.control.frame;

        if (self.animationDirection == NIDropDownAnimationDirectionUp) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y, btn.size.width, 0);
            self.layer.shadowOffset = CGSizeMake(-5, -5);
        }
        else if (self.animationDirection == NIDropDownAnimationDirectionDown) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y + btn.size.height, btn.size.width, 0);
            self.layer.shadowOffset = CGSizeMake(-5, 5);
        }

        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = 8;
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.5;

        self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, btn.size.width, 0)];
        self.table.delegate = self;
        self.table.dataSource = self;
        self.table.layer.cornerRadius = 5;
        self.table.backgroundColor = [UIColor colorWithRed:0.239 green:0.239 blue:0.239 alpha:1];
        self.table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.table.separatorColor = [UIColor grayColor];

        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        if (self.animationDirection == NIDropDownAnimationDirectionUp) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y - self.dropDownHeight, btn.size.width, self.dropDownHeight);
        }
        else if (self.animationDirection == NIDropDownAnimationDirectionDown) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y + btn.size.height, btn.size.width, self.dropDownHeight);
        }
        self.table.frame = CGRectMake(0, 0, btn.size.width, self.dropDownHeight);
        [UIView commitAnimations];

        [self.control.superview addSubview:self];
        [self addSubview:self.table];
    }
    return self;
}

-(void)hideDropDown:(UIControl *)theControl {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    if (self.animationDirection == NIDropDownAnimationDirectionUp) {
        self.frame = CGRectMake(theControl.frame.origin.x, theControl.frame.origin.y,
                theControl.frame.size.width, 0);
    }
    else if (self.animationDirection == NIDropDownAnimationDirectionDown) {
        self.frame = CGRectMake(theControl.frame.origin.x, theControl.frame.origin.y + theControl.frame.size.height,
                theControl.frame.size.width, 0);
    }
    self.table.frame = CGRectMake(0, 0, theControl.frame.size.width, 0);
    [UIView commitAnimations];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *NIDropDownCellIdentifier = @"NIDropDownCellIdentifier";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NIDropDownCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:NIDropDownCellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    cell.textLabel.text = [self.list objectAtIndex:(NSUInteger) indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];

    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor grayColor];
    cell.selectedBackgroundView = v;

    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hideDropDown:self.control];
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *selectedOption = selectedCell.textLabel.text;

    // If the control's visual representation can be adopted according to selection, then do it.
    if ([self.control isKindOfClass:[UIButton class]]) {
        UIButton *btn = (UIButton *)self.control;
        [btn setTitle:selectedOption forState:UIControlStateNormal];
    }

    [self.delegate niDropDownClosed:self withSelection:selectedOption];
}

@end
