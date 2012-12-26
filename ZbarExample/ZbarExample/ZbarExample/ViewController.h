//
//  ViewController.h
//  ZbarExample
//
//  Created by Abdul Ahad on 12/21/12.
//  Copyright (c) 2012 RoyalCyber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"

@interface ViewController : UIViewController <ZBarReaderDelegate> {
}

@property (strong, nonatomic) IBOutlet UILabel *viewResult;

- (IBAction)scan:(id)sender;

@end
