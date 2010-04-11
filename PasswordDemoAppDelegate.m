//
//  PasswordDemoAppDelegate.m
//  PasswordDemo
//
//  Created by Dan Palmer on 19/02/2010.
//  Copyright 2010 Dan Palmer. All rights reserved.
//

#import "PasswordDemoAppDelegate.h"
#import "Point.h"
#include <stdlib.h>

@implementation PasswordDemoAppDelegate

@synthesize window, gridView, grid;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
	
	grid = [[NSMutableDictionary alloc] init];
	
	// Generate initial grid
	[self generateGrid];
	
	// Define password pattern
	pattern = [[NSMutableArray alloc] init];
	GridPoint *gp = [[GridPoint alloc] initWithPointX:(int)1 Y:(int)5];
	[pattern addObject:gp];
	gp = [[GridPoint alloc] initWithPointX:(int)1 Y:(int)1];
	[pattern addObject:gp];
	gp = [[GridPoint alloc] initWithPointX:(int)6 Y:(int)4];
	[pattern addObject:gp];
	gp = [[GridPoint alloc] initWithPointX:(int)5 Y:(int)5];
	[pattern addObject:gp];
	[pattern retain];
}

- (IBAction)addNumber:(id)sender {
	NSString *text = [passwordTextField stringValue];
	NSLog(@"%@", text);
	NSString *newNumber = [sender title];
	NSLog(@"%@", newNumber);
	text = [text stringByAppendingString:newNumber];
	NSLog(@"%@", text);       
	[passwordTextField setStringValue:text];
	[self textDidChange];
	[status setStringValue:@""];
}

- (IBAction)backspace:(id)sender {
	[passwordTextField setStringValue:[[passwordTextField stringValue] stringByPaddingToLength:([[passwordTextField stringValue] length] -1) withString:@"" startingAtIndex:0]];
	[status setStringValue:@""];
}

- (void)generateGrid {
	
	for(int x = 0; x < 7; x++) {
		for(int y = 0; y < 7; y++) {
			
			// Add the data for the current session to a dictionary
			int r = arc4random() % 10;
			NSNumber *v = [NSNumber numberWithInt:r];
			NSLog(@"Random Number = %@", v);
			NSString *k = [NSString stringWithFormat:@"%d%d", x, y];
			NSLog(@"Key = %@", k);
			[grid setObject:[NSString stringWithFormat:@"%@", v] forKey:k];
			
			// Calculate the colour for the square
			NSColor *boxColour = [NSColor colorWithCalibratedRed:0.8696 green:0.8696 blue:0.8696 alpha:1.0000];
			if (x == 0 || x == 6 || y == 0 || y == 6) {
				boxColour = [NSColor colorWithCalibratedRed:0.5865 green:0.8207 blue:0.4888 alpha:1.0000];
			} else if (x == 3 && y == 3) {
				boxColour = [NSColor colorWithCalibratedRed:0.9022 green:0.2110 blue:0.2004 alpha:1.0000];
			} else if ((x > 1 && x < 5) && (y > 1 && y < 5)) {
				boxColour = [NSColor colorWithCalibratedRed:0.9022 green:0.5589 blue:0.3288 alpha:1.0000];
			} else if ((x > 0 && x < 6) && (y > 0 && y < 6)) {
				boxColour = [NSColor colorWithCalibratedRed:0.8794 green:0.9022 blue:0.5037 alpha:1.0000];
			}
			
			// Add this as a label to the view
			float xpos = x * 50.0;
			float ypos = y * 50.0;
			NSTextField *t = [[NSTextField alloc] initWithFrame:NSRectFromCGRect(CGRectMake(xpos, ypos, 39.0, 39.0))];
			[t setFont:[NSFont fontWithName:@"Helvetica-Bold" size:30]];
			[t setBezelStyle:NSTextFieldSquareBezel];
			[t setBordered:YES];
			[t setSelectable:NO];
			[t setEditable:NO];
			[t setStringValue:[NSString stringWithFormat:@"%@", v]];
			[t setTextColor:[NSColor colorWithCalibratedRed:0.1961 green:0.1961 blue:0.1961 alpha:1.0000]];
			[t setBackgroundColor:boxColour];
			[t setAlignment:NSCenterTextAlignment];
			[gridView addSubview:t];
			[t release];
		}
	}
}

- (void)textDidChange {
	
	// Check the correct length of text
	if ([[passwordTextField stringValue] length] > 4) {
		NSString *text = [passwordTextField stringValue];
		[passwordTextField setStringValue:[text stringByPaddingToLength:4 withString:@"" startingAtIndex:0]];
		NSLog(@"%@", [text stringByPaddingToLength:4 withString:@"" startingAtIndex:0]);
	}
	
}

- (IBAction)checkPassword:(id)sender {
	
	NSString *password = [[[NSString alloc] init] autorelease];
	
	// Iterate through numbers and check with pattern
	for (int i = 0; i < 4; i++) {
		int x;
		int y;
		GridPoint *gp = [pattern objectAtIndex:i];
		x = [gp xValue];
		y = [gp yValue];
		
		NSString *key = [NSString stringWithFormat:@"%d%d", x, y];
		NSString *gridInt = [NSString stringWithFormat:@"%@", [grid objectForKey:key]];
		password = [password stringByAppendingString:gridInt];
	}
	
	if ([[passwordTextField stringValue] isEqualTo:password]) {
		NSLog(@"Success");
		[passwordTextField setStringValue:@""];
		[status setStringValue:@"Success"];
		[self generateGrid];
	} else {
		NSLog(@"Failure");
		[passwordTextField setStringValue:@""];
		[status setStringValue:@"Failure"];
		[self generateGrid];
	}

}

@end