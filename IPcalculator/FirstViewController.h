//
//  FirstViewController.h
//  IPcalculator
//
//  Created by Jan-Willem Smaal on 10/6/11.
//  Copyright 2011 Communicatie VolZ.in All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IPAddress.h"
#import "MACaddr.h"
#import "NetmaskPickerViewController.h"

// Used by UIPicker 
#define CIDR 0
#define NETMASK 1

@interface FirstViewController : UIViewController 
	<UIPopoverControllerDelegate, 
	UITableViewDataSource, 
	UITableViewDelegate> 
{
@protected
	IPAddress *Ipaddr;
	MACaddr *macaddr; 
	
	// Fields, pickers, choosers
	IBOutlet UITextField *ipAddr;
	//IBOutlet UIPickerView *netmaskpicker;
	NetmaskPickerViewController *netmaskPickerController;
	UIPopoverController *popoverController;
	
	//
	//	IBOutlet UIButton *calculatePressed;
	IBOutlet UIButton *previousButton;
	IBOutlet UIButton *maskButton;
	// Labels
	IBOutlet UILabel *ipIP;
	IBOutlet UILabel *cidrIP;
	IBOutlet UILabel *networkIP;
	IBOutlet UILabel *maskIP;
	IBOutlet UILabel *broadcastIP;
	IBOutlet UILabel *invertedMask;
	//IBOutlet UILabel *networks;
	//IBOutlet UILabel *displaytext;
	IBOutlet UILabel *hosts;
	IBOutlet UILabel *firstIP;
	IBOutlet UILabel *lastIP;
	IBOutlet UILabel *l2mac;
	IBOutlet UILabel *l2macLabel;
	IBOutlet UITableView *networksTableView;

	
@private	
	// Array of netmasks
	//NSMutableArray *NetmaskArray;
}
// Fields, pickers, choosers
@property(nonatomic, strong) UITextField *ipAddr;
@property(nonatomic, strong) IBOutlet UIPickerView *netmaskpicker;
@property(nonatomic, strong) UIPopoverController *popoverController;
@property(nonatomic, strong) UITableView *networksTableView;


// Buttons
//@property (nonatomic, retain) IBOutlet UIButton *calculatePressed;
//@property (nonatomic, retain) IBOutlet UIButton *moveToNextPressed;
//@property (nonatomic, retain) IBOutlet UIButton *moveToPreviousPressed;
@property (nonatomic, strong) IBOutlet UIButton *previousButton;
@property (nonatomic, strong) IBOutlet UIButton *maskButton;
	


// Labels
@property(nonatomic, strong)IBOutlet UILabel *ipIP;
@property(nonatomic, strong)IBOutlet UILabel *networkIP;
@property(nonatomic, strong)IBOutlet UILabel *maskIP;
@property(nonatomic, strong)IBOutlet UILabel *cidrIP;
@property(nonatomic, strong)IBOutlet UILabel *broadcastIP;
@property(nonatomic, strong)IBOutlet UILabel *invertedMask;
//@property(nonatomic, retain)IBOutlet UILabel *networks;
//@property(nonatomic, retain)IBOutlet UILabel *displaytext;
@property(nonatomic, strong)IBOutlet UILabel *hosts;
@property(nonatomic, strong)IBOutlet UILabel *firstIP;
@property(nonatomic, strong)IBOutlet UILabel *lastIP;
@property(nonatomic, strong)IBOutlet UILabel *l2mac;
@property(nonatomic, strong)IBOutlet UILabel *l2macLabel;


// Actions
-(IBAction) moveToNextPressed:(id)sender;
-(IBAction) moveToPreviousPressed:(id)sender;
-(IBAction) calculatePressed:(id)sender;
-(IBAction) hideKeyboard1:(id)sender;
-(IBAction) selectedButtonPressed:(id)sender;
-(IBAction) selectMaskButtonPressed:(id)sender;

-(void)refreshView;


@end
