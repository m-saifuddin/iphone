//
//  ViewController.m
//  ZbarExample
//
//  Created by Abdul Ahad on 12/21/12.
//  Copyright (c) 2012 RoyalCyber. All rights reserved.
//

#import "ViewController.h"
#import "ZBarSDK.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize viewResult;


- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info {
    
    //this contains your result from the scan
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    
    //create a symbol object to attach the response data to
    ZBarSymbol *symbol = nil;
    
    //add the symbol properties from the result
    //so you can access it
    for(symbol in results){
        
        //symbol.data holds the UPC value        
        NSString *upcString = symbol.data;
        
        //all we will do for now is print out the UPC 
        //to the console
        NSLog(@"the value of the scanned UPC is: %@",upcString);
        
        NSMutableString *message = [[NSMutableString alloc] initWithString: @"Scanned Barcode: "];
        
        [message appendString:[NSString stringWithFormat:@"%@ ",upcString]];
        
        //Create UIAlertView alert
        UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:@"Product Barcode" message: message delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
        
        self.viewResult.text = upcString;
        [alert show];
        //After some time
                [alert dismissWithClickedButtonIndex:0 animated:TRUE];
        
        //make the reader view go away
        [reader dismissModalViewControllerAnimated: YES];
        
        
        
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setViewResult:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
//    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    return true;
}

- (IBAction)scan:(id)sender {
    
    
    //initialize the reader and provide some config instructions
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    
    //in this case I set it to be sure to scan UPC-A which helped with 
    //one of my first issues. This doesn't make it only scan as upc-a, but 
    //seemed to allow it to use this first as it initially added extra
    //zeros to all UPC-A's
    [reader.scanner setSymbology: ZBAR_I25
                          config: ZBAR_CFG_ENABLE
                              to: 1];
    //I haven't messed with zoom settings yet so I used this as a default
    reader.readerView.zoom = 1.0;
    
    //show the scanning/camera mode
    [self presentModalViewController:reader animated:YES];
    // Do any additional setup after loading the view from its nib.

}

@end
