//
//  BluetoothShieldHelper.m
//  TeamMakk
//
//  Created by Michael Weingert on 2015-02-21.
//  Copyright (c) 2015 teammakk. All rights reserved.
//

#import "BluetoothShieldHelper.h"

@implementation BluetoothShieldHelper
{
  id<BluetoothListenerDelegate> _listener;
  BLE *bleShield;
}

-(void) setListener: (id<BluetoothListenerDelegate>) newListener
{
  _listener = newListener;
}

-(void) initDevice
{
  //Build
  bleShield = [[BLE alloc] init];
  [bleShield controlSetup];
  bleShield.delegate = self;
  
  //Connect to the device
  
  //
}

-(void) connectionTimer:(NSTimer *)timer
{
  if(bleShield.peripherals.count > 0)
  {
    [bleShield connectPeripheral:[bleShield.peripherals objectAtIndex:0]];
  }
  else
  {
  }
}

-(void) bleDidReceiveData:(unsigned char *)data length:(int)length
{
  NSData *d = [NSData dataWithBytes:data length:length];
  NSString *s = [[NSString alloc] initWithData:d encoding:NSUTF8StringEncoding];
  //NSLog(@"%@", s);
  //NSNumber *form = [NSNumber numberWithBool:YES];
  
  /*NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:s, TEXT_STR, form, FORM, nil];
  [tableData addObject:dict];
  
  [_tableView setContentOffset:CGPointMake(0, CGFLOAT_MAX)];
  [_tableView reloadData];*/
  [_listener didReceiveMessageFromShield:s];
}

- (void)BLEShieldScan:(id)sender
{
  if (bleShield.activePeripheral)
    if(bleShield.activePeripheral.state == CBPeripheralStateConnected)
    {
      [[bleShield CM] cancelPeripheralConnection:[bleShield activePeripheral]];
      return;
    }
  
  if (bleShield.peripherals)
    bleShield.peripherals = nil;
  
  [bleShield findBLEPeripherals:3];
  
  [NSTimer scheduledTimerWithTimeInterval:(float)3.0 target:self selector:@selector(connectionTimer:) userInfo:nil repeats:NO];
}

-(void) readRSSITimer:(NSTimer *)timer
{
  [bleShield readRSSI];
}

- (void) bleDidDisconnect
{
  NSLog(@"bleDidDisconnect");
  
  //[[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

-(void) bleDidConnect
{
  NSLog(@"bleDidConnect");
}

@end