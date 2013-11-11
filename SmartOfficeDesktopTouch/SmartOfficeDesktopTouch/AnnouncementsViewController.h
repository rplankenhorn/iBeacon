//
//  MainViewController.h
//  SmartOfficeDesktopTouch
//
//  Created by Robbie Plankenhorn on 11/6/13.
//  Copyright (c) 2013 Solstice Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Anniversary : NSObject
@property NSString *name;
@property int years;
@end

@interface Birthday : NSObject
@property NSString *name;
@property NSDate *date;
@end

@interface AnnouncementsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UIView *headerView;
    IBOutlet UITableView *announcementTableView;
    
    NSArray *sectionHeaders;
    NSArray *anniversaries;
    NSArray *birthdays;
}

@end