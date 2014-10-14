//
//  SecondViewController.h
//  IPcalculator
//
//  Created by Jan-Willem Smaal on 10/6/11.
//  Copyright 2011 Communicatie VolZ.in All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IPaddress.h"
#import "IPplan.h"


@interface SecondViewController : UIViewController 
	<UITableViewDataSource, UITableViewDelegate> 
{
	IPAddress *ip;
	IPplan *plan;
	NSString *str;
	IBOutlet UISlider *networksSlider;
	IBOutlet UISlider *hostsSlider;
	IBOutlet UITextView *textView;
	IBOutlet UITextField *parentTextField;
	IBOutlet UITableView *childsTable;
}

@property(nonatomic, strong)IPAddress *ip;
@property(nonatomic, strong)IPplan *plan;
@property(nonatomic, strong)NSString *str;

@property(nonatomic, strong)UISlider *networksSlider;
@property(nonatomic, strong)UISlider *hostsSlider; 
@property(nonatomic, strong)UITextView *textView;
@property(nonatomic, strong)UITextField *parentTextField;
@property(nonatomic, strong)UITableView *childsTable;


-(void)refreshView;


// Actions 
-(IBAction) moveToNextPressed:(id)sender;
-(IBAction) moveToPreviousPressed:(id)sender;
-(IBAction) networksSliderMoved:(id)sender;
-(IBAction) hostsSliderMoved:(id)sender;
-(IBAction) parentTextFieldEditingFinished:(id)sender;
-(IBAction) hideKeyboard2:(id)sender;


@end
