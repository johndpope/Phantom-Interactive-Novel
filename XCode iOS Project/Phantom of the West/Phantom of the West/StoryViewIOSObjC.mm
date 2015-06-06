//
//  StoryViewIOSObjC.mm
//  XCode iOS Project
//
//  Created by Christopher Raleigh on 2015/20/01.
//  Copyright (c) 2015 Christopher Raleigh. All rights reserved.
//

#import "StoryViewIOSObjC.h"

@implementation StoryViewIOSObjC
{
    StoryViewIOSCPP* cppGlue;
    StoryNavigator * navigator;
    StoryImageAndTextView * scrollView;
    PauseMenu * pauseMenu;
    TextViewAndNavigator * textAndNav;
}

const CGFloat buttonRowHeight = 44.0;

- (id) initWithController : (UIViewController <UITableViewDelegate> *) controller
{
    self = [super init];
    if (self)
    {
        [self setController:controller];
        [self initializeUIView];
        cppGlue = new StoryViewIOSCPP(self);
    }
    return self;
}

- (void) dealloc
{
    delete cppGlue;
}

- (void) onButtonContinue
{
    cppGlue->Continue();
}

- (void) onButtonPrevious
{
    cppGlue->PreviousChoice();
}

- (void) onButtonNext
{
    cppGlue->NextChoice();
}

- (void) onButtonPause
{
    pauseMenu.hidden = false;
}

- (void) initializeUIView
{
    self.translatesAutoresizingMaskIntoConstraints = false;
    // Create the text half.
    textAndNav = [self getTextAndNav];
    // Create button row.
    //navigator = [self getButtonRow];
    // Create scroll view.
    //scrollView = [self getUIScrollView];
    // Create pause menu.
    pauseMenu = [self getPauseMenu];
    
}

- (TextViewAndNavigator *) getTextAndNav {
    TextViewAndNavigator * tvan = [[TextViewAndNavigator alloc] initWithObserver:self];
    [self addSubview:tvan];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:tvan attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:tvan attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:tvan attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:tvan attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
    return tvan;
}

- (PauseMenu *) getPauseMenu {
    PauseMenu * pm = [[PauseMenu alloc] init];
    [pm setDelegate:[self controller]];
    [pm reloadData];
    pm.hidden = true;
    [self addSubview:pm];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:pm attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:pm attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:pm attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:pm attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
    return pm;
}

/*
 Returns a button row for navigating a choice list.
 */
- (StoryNavigator *) getButtonRow
{
    StoryNavigator * buttonRowView = [[StoryNavigator alloc]initWithObserver:self];
    [self addSubview:buttonRowView];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:buttonRowView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:buttonRowView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:buttonRowView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:buttonRowView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:buttonRowHeight]];
    return buttonRowView;
}

- (StoryImageAndTextView *) getUIScrollView {
    StoryImageAndTextView * myScrollView = [[StoryImageAndTextView alloc] initWithController:self.controller];
    [self addSubview:myScrollView];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:myScrollView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:myScrollView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:myScrollView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:myScrollView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:navigator attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
    return myScrollView;
}

- (void) setImageViewImage : (UIImage*) newImage
{
    //[scrollView setImage:newImage];
}

- (void) setTextViewText : (NSString*) newText
{
    //[scrollView setText:newText];
    [textAndNav setText:newText];
}

- (void) setChoiceSelectorEnabled : (BOOL) enabled
{
    //[navigator setChoiceSelectorEnabled:enabled];
    [textAndNav setChoiceSelectorEnabled:enabled];
}

@end