//
//  GameView.mm
//  XCode iOS Project
//
//  Created by Christopher Raleigh on 2015/13/01.
//  Copyright (c) 2015 Christopher Raleigh. All rights reserved.
//

#import "GameView.h"

@implementation GameView {
    UIViewController <ADBannerViewDelegate, UITableViewDelegate> * controller;
    ADBannerView * adBanner;
    NSLayoutConstraint * adBannerHeight;
}

+ (GameView *) getGameView : (UIViewController <ADBannerViewDelegate, UITableViewDelegate> *) controller {
    GameView * newGameView = [[GameView alloc] initWithController:controller];
    UIView * parentView = controller.view;
    [parentView addSubview:newGameView];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:newGameView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:newGameView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:controller.topLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:newGameView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:newGameView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:controller.bottomLayoutGuide attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
    return newGameView;
    }

- (id) initWithController: (UIViewController <ADBannerViewDelegate, UITableViewDelegate> *) c {
    self = [super init];
    if (self) {
        controller = c;
        [self initializeGameView];
    }
    return self;
}

- (void) initializeGameView {
    adBanner = nil;
    adBannerHeight = nil;
    self.translatesAutoresizingMaskIntoConstraints = false;
    // Initialize main view.
    self.storyView = [[StoryViewIOSObjC alloc] initWithController:controller];
    [self addSubview:self.storyView];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.storyView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.storyView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.storyView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
    // Add advertisment, if applicable.
    if ([Advertising shouldDisplayAdvertisement]) {
        adBanner = [Advertising getIAdBanner];
        adBanner.delegate = controller;
        adBanner.hidden = TRUE;
        [self addSubview:adBanner];
        adBanner.translatesAutoresizingMaskIntoConstraints = false;
        [self addConstraint:[NSLayoutConstraint constraintWithItem:adBanner attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:adBanner attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:adBanner attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
        [self updateBannerHeight];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.storyView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:adBanner attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
    } else {
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.storyView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
    }
}

- (void) updateBannerHeight {
    [self removeConstraint:adBannerHeight];
    adBannerHeight = [NSLayoutConstraint constraintWithItem:adBanner attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:adBanner.bounds.size.height];
    [self addConstraint:adBannerHeight];
}
    
    @end