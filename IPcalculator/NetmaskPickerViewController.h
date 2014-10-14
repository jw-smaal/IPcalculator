//
//  NetmaskPickerViewController.h
//  IPcalculator
//
//  Created by Jan-Willem Smaal on 22-06-11.
//  Copyright 2011 Communicatie VolZ.in All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NetmaskPickerViewController : UIViewController 
		<UIPickerViewDataSource, UIPickerViewDelegate> {
@protected
			
	IBOutlet UIPickerView *Picker;
	int numberOfBits;
			
@private	
	// Array of netmasks
	NSMutableArray *NetmaskArray;
}


// UI Elements
@property(nonatomic, strong) UIPickerView *Picker;


// Value returned by picker 
@property(nonatomic, assign, readwrite) int numberOfBits;

- (void) setPickerRow:(int) row;

@end
