//
//  NIViewController.m
//  NIDropDown
//
//  Created by Bijesh N on 12/28/12.
//  Copyright (c) 2012 Nitor Infotech. All rights reserved.
//

#import "NIViewController.h"
#import "NIDropDown.h"
#import "QuartzCore/QuartzCore.h"

@interface NIViewController ()

@end

@implementation NIViewController

@synthesize btnSelect;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    btnSelect.layer.borderWidth = 1;
    btnSelect.layer.borderColor = [[UIColor blackColor] CGColor];
    btnSelect.layer.cornerRadius = 5;
}

- (void)viewDidUnload {
    btnSelect = nil;
    [self setBtnSelect:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)selectClicked:(id)sender {
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"Hello 0", @"Hello 1", @"Hello 2", @"Hello 3", @"Hello 4", @"Hello 5", @"Hello 6", @"Hello 7", @"Hello 8", @"Hello 9",nil];
    if (dropDown == nil) {
        dropDown = [[NIDropDown alloc] initDropDownFor:sender height:200.0 elements:arr direction:NIDropDownAnimationDirectionUp];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
}

#pragma mark -
#pragma mark NIDropDownViewDelegate

- (void)niDropDownClosed:(NIDropDown *)sender withSelection:(id)selection {
    [self rel];
}

-(void)rel{
    dropDown = nil;
}

@end
