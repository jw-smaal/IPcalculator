//
//  IPplanTests.m
//  IPplanTests
//
//  Created by Jan-Willem Smaal on 04-07-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "IPplanTests.h"


@implementation IPplanTests


- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void) testIPplanClassMethods{
	int i = 0;
	uint32_t a = 0;
	uint32_t b = 0;
	uint32_t c = 0;

	
	// Test setting of bit
	for (i= 0; i < 32; i++){
		a = pow(2,i);
		b = [IPplan setBit:i inNumber:0];
		STAssertEquals(a, b, @"clearbit");
	}
	
	// Test clearing of bit
	for (i= 0; i < 32; i++){
		a = ~(uint32_t) pow(2,i);
		b = [IPplan clearBit:i inNumber:0xFFFFFFFF];
		STAssertEquals(a, b, @"clearbit");
	}

	// Test setting of bits in range
	a = 0x00000000;
	b = 0x000000FF;
	c = [IPplan setBits:0 msb:7 inNumber:a];
	STAssertEquals (b, c, @"failed setbits");	
	
	// Test setting of bits in range
	a = 0x00000000;
	b = 0x00000F00;
	c = [IPplan setBits:8 msb:11 inNumber:a];
	STAssertEquals (b, c, @"failed setbits");		
	
	// Test clearing of bits in range
	a = 0xFFFFFFFF;
	b = 0x0FFFFFFF;
	c = [IPplan clearBits:28 msb:31 inNumber:a];
	STAssertEquals (b, c, @"failed clearbits");
	
	// Test clearing of bits in range
	a = 0xFFFFFFFF;
	b = 0xFFFFFF0F;
	c = [IPplan clearBits:4 msb:7 inNumber:a];
	STAssertEquals (b, c, @"failed clearbits");

	a = 9;
	b = [IPplan getBitWidth:300];
	STAssertEquals (a, b, @"failed bitwitdh");
	
	a = 0;
	b = [IPplan getBitWidth:0];
	STAssertEquals (a, b, @"failed bitwitdh");

	a = 8;
	b = [IPplan getBitWidth:0xFF];
	STAssertEquals (a, b, @"failed bitwitdh");

	
}


- (void) testIPplanInstanceMethods{
	int i = 0;
	uint32_t a = 0;
	uint32_t b = 0;
	uint32_t c = 0;
	IPAddress *ipa;
	IPplan *ipplan;
	
	// Test object creation 1)
	// ------------------------
	ipplan = [[IPplan alloc] init];
	ipplan.NumberOfHosts = 300;
	ipplan.NumberOfNetworks = 5;
	a = [ipplan NumberOfHosts];
	b = [ipplan NumberOfNetworks];
	STAssertEquals(a, (uint32_t)512, @"Should be rounded up");
	STAssertEquals(b, (uint32_t)8, @"Should be rounded up");	
	[ipplan CalculateAndAssign];
	[ipplan release];
	// ------------------------
	
	
	
	// Test object creation 2)
	// ------------------------
	ipa = [[IPAddress alloc] initWithData:[IPAddress toInt:@"192.168.1.0"] mask:24];
	ipplan = [[IPplan alloc] initWithParentBlock:ipa childs:3 hosts:240];
	a = 22;
	b = ipplan.parentBlock.bitmask;
	STAssertEquals (a, b, @"failed ipplan");
	
	a = 24;
	b = ipplan.childFirstBlock.bitmask;  	
	//b = ipplan.childLastBlock.bitmask;
	STAssertEquals (a, b, @"failed ipplan");
	
	[ipplan release];
	[ipa release];
	// ------------------------
	
	
	
	// Test object creation 3)
	// ------------------------
	ipa = [[IPAddress alloc] initWithData:[IPAddress toInt:@"10.1.2.3"] mask:24];
	ipplan = [[IPplan alloc] initWithParentBlock:ipa childs:12 hosts:30];
	a = 23;
	b = ipplan.parentBlock.bitmask;
	STAssertEquals (a, b, @"failed ipplan");
	
	a = 27;
	b = ipplan.childFirstBlock.bitmask;  	
	//b = ipplan.childLastBlock.bitmask;
	STAssertEquals (a, b, @"failed ipplan");
	
	[ipplan release];
	[ipa release];
	// ------------------------
	
	
	// Test object creation 4)
	// ------------------------
	ipa = [[IPAddress alloc] initWithData:[IPAddress toInt:@"10.1.2.3"] mask:24];
	ipplan = [[IPplan alloc] initWithParentBlock:ipa childs:4 hosts:4];
	a = 28;
	b = ipplan.parentBlock.bitmask;
	STAssertEquals (a, b, @"failed ipplan");
	
	a = 30;
	b = ipplan.childFirstBlock.bitmask;  	
	//b = ipplan.childLastBlock.bitmask;
	STAssertEquals (a, b, @"failed ipplan");
	
	[ipplan release];
	[ipa release];
	// ------------------------
	
	
	// Test object creation 5)
	// ------------------------
	ipa = [[IPAddress alloc] initWithData:[IPAddress toInt:@"10.1.2.3"] mask:24];
	ipplan = [[IPplan alloc] initWithParentBlock:ipa childs:65536 hosts:16];
	a = 12;
	b = ipplan.parentBlock.bitmask;
	STAssertEquals (a, b, @"failed ipplan");
	
	a = 28;
	b = ipplan.childFirstBlock.bitmask;  	
	//b = ipplan.childLastBlock.bitmask;
	STAssertEquals (a, b, @"failed ipplan");
	
	[ipplan release];
	[ipa release];
	// ------------------------
	
	
	
	// Test object creation ZERO 
	// ------------------------
	ipa = [[IPAddress alloc] initWithData:[IPAddress toInt:@"10.1.2.3"] mask:24];
	ipplan = [[IPplan alloc] initWithParentBlock:ipa childs:0 hosts:0];
	//	a = 0 ;
	//b = ipplan.parentBlock.bitmask;
	//STAssertEquals (a, b, @"failed ipplan");
	
	a = 32;
	//b = ipplan.childFirstBlock.bitmask;  	
	b = ipplan.parentBlock.bitmask;
	STAssertEquals (a, b, @"failed ipplan");
	
	[ipplan release];
	[ipa release];
	// ------------------------
	
	
	
	// Test object creation MAX CHILDS
	// ------------------------
	ipa = [[IPAddress alloc] initWithData:[IPAddress toInt:@"10.1.2.3"] mask:24];
	ipplan = [[IPplan alloc] initWithParentBlock:ipa childs:0xFFFFFFFF hosts:0];
	a = 32;
	b = ipplan.childFirstBlock.bitmask;
	STAssertEquals (a, b, @"failed ipplan");
	
	a = 0;
	b = ipplan.parentBlock.bitmask;
	STAssertEquals (a, b, @"failed ipplan");	
	
	a = 32;
	b = ipplan.childFirstBlock.bitmask;  	
	//b = ipplan.childLastBlock.bitmask;
	STAssertEquals (a, b, @"failed ipplan");
	
	[ipplan release];
	[ipa release];
	// ------------------------
	
	
	// Test object creation MAX HOSTS
	// ------------------------
	ipa = [[IPAddress alloc] initWithData:[IPAddress toInt:@"10.1.2.3"] mask:24];
	ipplan = [[IPplan alloc] initWithParentBlock:ipa childs:0x0 hosts:0xFFFFFFFF];
	a = 0;
	b = ipplan.parentBlock.bitmask;
	STAssertEquals (a, b, @"failed ipplan");
	
	a = 0;
	b = ipplan.childFirstBlock.bitmask;  	
	//b = ipplan.childLastBlock.bitmask;
	STAssertEquals (a, b, @"failed ipplan");
	
	[ipplan release];
	[ipa release];
	// ------------------------
	
	
}

@end
