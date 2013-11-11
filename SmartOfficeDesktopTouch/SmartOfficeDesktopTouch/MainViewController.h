//
//  MainViewController.h
//  SmartOfficeDesktopTouch
//
//  Created by Robbie Plankenhorn on 11/6/13.
//  Copyright (c) 2013 Solstice Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UIView *headerView;
    
    NSArray *tableData;
}

@end