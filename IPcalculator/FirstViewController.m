//
//  FirstViewController.m
//  IPcalculator
//
//  Created by Jan-Willem Smaal on 10/6/11.
//  Copyright 2011 Communicatie VolZ.in All rights reserved.
//

#import "FirstViewController.h"

@implementation FirstViewController

@synthesize netmaskpicker;
@synthesize networksTableView;
//@synthesize calculatePressed;
//@synthesize moveToNextPressed;
//@synthesize moveToPreviousPressed;
@synthesize popoverController;
@synthesize previousButton;
@synthesize maskButton;

@synthesize ipAddr;
@synthesize ipIP;
@synthesize networkIP;
@synthesize maskIP;
@synthesize cidrIP;
@synthesize broadcastIP;
@synthesize invertedMask;
//@synthesize networks;
@synthesize hosts;
//@synthesize displaytext;
@synthesize firstIP;
@synthesize lastIP;
@synthesize l2mac;
@synthesize l2macLabel;



#pragma mark Actions
/*
 * Perform calculation 
 */
- (IBAction)calculatePressed:(id)sender {
	// Read ip address into int. 
	
	//Ipaddr.ip = [ipAddr.text intValue];
	//Ipaddr.ip = [IPaddr toInt:@"123.45.67.89"];
	Ipaddr.ip = [IPAddress toInt:ipAddr.text];
	[macaddr assignMulticastMACaddr:Ipaddr];

	
	if([IPAddress isMulticastIP:Ipaddr]){
		//[displaytext 	setTextColor:[UIColor greenColor]];
		//[displaytext	setText:@"This is a Multicast IP"];
		[l2macLabel setHidden:FALSE];
		[l2mac setHidden:FALSE];
	}
	else{	
		//[displaytext 	setTextColor:[UIColor redColor]];
		//		[displaytext	setText:@"This is *NOT* a Multicast IP"];
		[l2macLabel setHidden:TRUE];
		[l2mac setHidden:TRUE];
	}
	
	[self refreshView];
}

// 
- (IBAction)hideKeyboard1:(id)sender{
	[ipAddr resignFirstResponder];
}


- (IBAction)moveToNextPressed:(id)sender{
	[Ipaddr moveToNextNetwork];
	[self refreshView];
}

// Action
-(IBAction)selectedButtonPressed:(id)sender {
	//	[popoverController dismissPopoverAnimated:YES];
}


- (IBAction)moveToPreviousPressed:(id)sender{
	[Ipaddr moveToPreviousNetwork];
	[self refreshView];

}


- (IBAction) selectMaskButtonPressed:(id)sender{
	
	// Laat de popover zien met de netmask picker.
	[popoverController presentPopoverFromRect:maskButton.frame 
									   inView:self.view 
					 permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	[self refreshView];
}

#pragma mark Table View 
// JWS
-(UITableViewCell *)tableView:(UITableView *)NetworksTableView 
		cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier1 = @"Cell1";
	//static NSString *CellIdentifier2 = @"Cell2";
	UITableViewCell *cell;
	IPAddress *ipa;

	cell = [NetworksTableView dequeueReusableCellWithIdentifier:CellIdentifier1];
	if (cell == nil){
		cell = [[UITableViewCell alloc] 
				 initWithStyle:UITableViewCellStyleDefault
				 reuseIdentifier:CellIdentifier1 ];
		
	}
	
	//NSString *cellValue = [listOfMovies objectAtIndex:indexPath.row];
	//cell.textLabel.text = cellValue;
	//cell.textLabel.text = Ipaddr.Text;
	
	
	ipa = [Ipaddr makenetworkIndex:indexPath.row];
	cell.textLabel.text = ipa.Text;
		
	// Add a image left of the cell. 
	//UIImage *image = [UIImage imageNamed:@"row.png"];	
	//cell.imageView.image = image;
	
	return cell;
}


// JWS
-(NSInteger)tableView:(UITableView *)networksTableView 
numberOfRowsInSection:(NSInteger)section{
	return 256;
}


#define TITLES 1
#if TITLES
// JWS
-(NSString *)tableView:(UITableView *)networksTableView 
titleForHeaderInSection:(NSInteger)section{
	return @"Networks";
}


-(NSString *)tableView:(UITableView *)tableView 
 titleForFooterInSection:(NSInteger)section{
	return @" ... ";
}
#endif




#pragma mark View related

// JWS: Display the state of the object. 
-(void)refreshView{
	//NSMutableString *tmpstr;
	
	//tmpstr = [[NSMutableString alloc] initWithString:@""];
	
	[ipIP 			setText:[IPAddress toDottedDecimal:Ipaddr.ip]];
	[ipAddr			setText:[IPAddress toDottedDecimal:Ipaddr.ip]];
	[networkIP 		setText:[IPAddress toDottedDecimal:Ipaddr.Network]];
	[maskIP 		setText:[IPAddress toDottedDecimal:Ipaddr.mask]];
	[cidrIP 		setText:[NSString stringWithFormat:@"/%i", Ipaddr.bitmask]];
	[broadcastIP    setText:[IPAddress toDottedDecimal:Ipaddr.Broadcast]];
	[invertedMask 	setText:[IPAddress toDottedDecimal:Ipaddr.HostMask]];	
	[hosts 			setText:[NSString stringWithFormat:@"%g", 
							 Ipaddr.numberOfHosts]];
	
	[firstIP 	setText:[IPAddress toDottedDecimal:Ipaddr.FirstIp]];
	[lastIP 	setText:[IPAddress toDottedDecimal:Ipaddr.LastIp]];
	[l2mac		setText:[macaddr Text]];
	
	// Update from object
	[netmaskpicker selectRow:Ipaddr.bitmask inComponent:CIDR animated:YES];
	[netmaskpicker selectRow:Ipaddr.bitmask inComponent:NETMASK animated:YES];
	
	[networksTableView reloadData];
	
	// Print the information in the array  
	//	for (IPaddr *ipa in NetmaskArray) {
	//	[tmpstr appendString:ipa.maskText];
	//	[tmpstr appendString:@"\n"];
	//}
	//[displaytext 	setText:tmpstr];
	//[tmpstr release];
	
}





// INIT for the View.... 
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
	//IPAddress *tmpIPaddr;
	
	[super viewDidLoad];
	
	//Ipaddr = [[IPaddr alloc] initWithData:0xdeadbeef :27]; 
	Ipaddr = [[IPAddress alloc] initWithData:[IPAddress toInt:@"192.168.1.0"] mask:26]; 
	macaddr = [[MACaddr alloc] init];
	
	// Load the PopOver view
	netmaskPickerController = [[NetmaskPickerViewController alloc] init];
	netmaskPickerController.numberOfBits = Ipaddr.bitmask;
	
	//[netmaskPickerController setPickerRow:24];
	
	popoverController = [[UIPopoverController alloc] initWithContentViewController:netmaskPickerController];
	popoverController.delegate = self;
	
	
	// Do not initially show the IP Multicast MAC addres
	[l2macLabel setHidden:TRUE];
	[l2mac setHidden:TRUE];
	
	[self refreshView];
}

// 
- (void) popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
	Ipaddr.bitmask = netmaskPickerController.numberOfBits;
	[self refreshView];
}




-(void)viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
}


-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload
{
	popoverController = nil;
	netmaskPickerController = nil;
	macaddr = nil;
	ipAddr = nil;
	netmaskpicker = nil;

	networkIP = nil;
	broadcastIP = nil;
	invertedMask = nil;
	//[networks release];
	//networks = nil;
	hosts = nil;
	//  [displaytext release];
	//  displaytext = nil;
	//[calculatePressed release];
	//calculatePressed = nil;
	//	[self setCalculatePressed:nil];
	maskIP = nil;
	cidrIP = nil;
	ipIP = nil;
    firstIP = nil;
    lastIP = nil;
	l2mac = nil;
	previousButton = nil;
	maskButton = nil;
	l2macLabel = nil;
	networksTableView = nil;
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



@end
