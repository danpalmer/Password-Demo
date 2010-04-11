//
//  PasswordDemoAppDelegate.h
//  PasswordDemo
//
//  Created by Dan Palmer on 19/02/2010.
//  Copyright 2010 Dan Palmer. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PasswordDemoAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
	IBOutlet NSTextField *passwordTextField;
	IBOutlet NSView *gridView;
	NSMutableDictionary *grid;
	NSMutableArray *pattern;
	IBOutlet NSTextField *status;
}

@property (assign) IBOutlet NSWindow *window;
@property (readwrite, assign) IBOutlet NSView *gridView;
@property (readwrite, assign) NSMutableDictionary *grid;

- (IBAction)addNumber:(id)sender;
- (IBAction)backspace:(id)sender;
- (void)generateGrid;
- (void)textDidChange;
- (IBAction)checkPassword:(id)sender;

@end
