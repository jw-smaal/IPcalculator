//
//  SecondViewController.m
//  IPcalculator
//
//  Created by Jan-Willem Smaal on 10/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SecondViewController.h"


@implementation SecondViewController

@synthesize ip;
@synthesize plan;
@synthesize str;
@synthesize networksSlider;
@synthesize hostsSlider;
@synthesize textView;
@synthesize parentTextField;
@synthesize childsTable;


#pragma mark Table View 
// JWS
-(UITableViewCell *)tableView:childsTable 
		cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier1 = @"Cell1";
	//static NSString *CellIdentifier2 = @"Cell2";
	UITableViewCell *cell;
	IPAddress *ipa;
	
	cell = [self.childsTable dequeueReusableCellWithIdentifier:CellIdentifier1];
	if (cell == nil){
		cell = [[UITableViewCell alloc] 
				 initWithStyle:UITableViewCellStyleDefault
				 reuseIdentifier:CellIdentifier1 ];
		
	}
	
	ipa = [plan.childFirstBlock makenetworkIndex:indexPath.row];
	cell.textLabel.text = ipa.Text;

	
	// Add a image left of the cell. 
	//UIImage *image = [UIImage imageNamed:@"row.png"];	
	//cell.imageView.image = image;
	
	return cell;
}



// JWS
-(NSInteger)tableView:childsTable 
numberOfRowsInSection:(NSInteger)section{
	// Anders wordt het lijstje te groot.... 
	// Iets op verzinnen zoals een "load more"  optie oid. 
	if (plan.NumberOfNetworks > 65535){	
		return 65535; 
	}
	return plan.NumberOfNetworks;
}

#define TITLES 1
#if TITLES
-(NSString *)tableView:childsTable 
titleForHeaderInSection:(NSInteger)section{
	return @"Networks";
}


-(NSString *)tableView:(UITableView *)tableView 
 titleForFooterInSection:(NSInteger)section{
	return @" ... ";
}
#endif


/*
 * Schrijf op het scherm. 
 */
-(void)refreshView{
	str = [plan Text];
	[textView setText:str];	
	[parentTextField setText:ip.ipText];
	
	// TODO: update tableView
	[childsTable reloadData];
	
	//[hostsSlider setValue:[plan hostsBitWidth]];
	//[networksSlider setValue:[plan networksBitWidth]];
}

-(void)hostsSliderMoved:(id)sender{
	ip.ip = [IPAddress toInt:parentTextField.text];
	if ([hostsSlider value] == 0) {
		plan.NumberOfHosts = 0;
	}
	else {
		if(hostsSlider.value + networksSlider.value >= 31){
			networksSlider.value = 31 - hostsSlider.value;
		}
		plan.NumberOfHosts = pow (2, [hostsSlider value]);
	}
	//plan.networksBitWidth;
	
	[plan CalculateAndAssign];
	[self refreshView];
}

-(void)networksSliderMoved:(id)sender{
	ip.ip = [IPAddress toInt:parentTextField.text];
	if([networksSlider value] == 0) {
		plan.NumberOfNetworks = 0;
	}
	else{
		if(hostsSlider.value + networksSlider.value > 31){
			hostsSlider.value = 31 - networksSlider.value;
		}
		plan.NumberOfNetworks = pow (2, [networksSlider value]);
	}
	[plan CalculateAndAssign];
	[self refreshView];
}

-(IBAction) parentTextFieldEditingFinished:(id)sender{
	ip.ip = [IPAddress toInt:parentTextField.text];
	[plan CalculateAndAssign];
	[self refreshView];
}

- (IBAction)hideKeyboard2:(id)sender{
	[parentTextField resignFirstResponder];
}


- (IBAction)moveToNextPressed:(id)sender{
	//[Ipaddr moveToNextNetwork];
	[ip moveToNextNetwork];
	[plan CalculateAndAssign];
	[parentTextField setText:ip.ipText];
	[self refreshView];
}


- (IBAction)moveToPreviousPressed:(id)sender{
	//[Ipaddr moveToPreviousNetwork];
	[ip moveToPreviousNetwork];
	[plan CalculateAndAssign];
	[parentTextField setText:ip.ipText];
	[self refreshView];
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
	[super viewDidLoad];
	ip = [[IPAddress alloc] initWithData:[IPAddress toInt:@"10.2.3.4"] mask:32];
	plan = [[IPplan alloc] initWithParentBlock:ip childs:5 hosts:300];
	//plan = [[IPplan alloc] init];
	//plan.NumberOfHosts = 600;
	//plan.NumberOfNetworks = 8;
	//[plan CalculateAndAssign];
	
	[self refreshView];
	
	
#ifdef COMMENTED_OUT
    int i = 0;
	float ret, j = 0;
	IPAddress *fromipaddr;
	IPAddress *ipaddr;
	IPAddress *toipaddr;
	
	str = [[NSString alloc] init];
	
	fromipaddr = [[IPAddress alloc] 
				  initWithData:[IPAddress toInt:@"192.168.1.0"] mask:24]; 
	toipaddr = [[IPAddress alloc] 
				initWithData:[IPAddress toInt:@"192.168.2.0"] mask:29];
	ipaddr = [[IPAddress alloc] init];
	ipaddr.ip = fromipaddr.ip;
	ipaddr.bitmask = fromipaddr.bitmask;
	
	//	ipaddr = [fromipaddr copy];
	
	// Go through all possible netmasks
	// FIXME: this may take too long!!! 
	// causing the application to lock up.
	for (i = fromipaddr.bitmask ; i <= toipaddr.bitmask ; i++){
		ipaddr.bitmask = i;
		
		// Find out how many of these fit in the parent. 
		ret = [IPAddress numberOfNetworks:ipaddr InParent:fromipaddr];
		str = [str stringByAppendingFormat:@"%.0f networks of size: ", ret];
		str = [str stringByAppendingFormat:@"/ %d\n", ipaddr.bitmask];
		
		// Then iterate through possible networks
		for(j = 0; j < ret; j++){
			str = [str stringByAppendingString:[ipaddr networkText]];
			str = [str stringByAppendingString:@" \t"];
			
			// Move to the next network. 
			[ipaddr moveToNextNetwork];
		}
		str = [str stringByAppendingString:@"\n"];

		// Start the next subnetmask listing from the original IP range. 
		ipaddr.ip = fromipaddr.ip;
		ipaddr.bitmask = fromipaddr.bitmask;
	}
	
	[fromipaddr release];
	[ipaddr release];
	[toipaddr release];
#endif
	
	[self refreshView];
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
	
	textView = nil;
	networksSlider = nil;
	hostsSlider = nil;
	parentTextField = nil;
	textView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



@end
