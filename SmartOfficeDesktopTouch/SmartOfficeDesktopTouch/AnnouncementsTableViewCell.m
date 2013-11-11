//
//  AnnouncementsTableViewCell.m
//  SmartOfficeDesktopTouch
//
//  Created by Robbie Plankenhorn on 11/11/13.
//  Copyright (c) 2013 Solstice Mobile. All rights reserved.
//

#import "AnnouncementsTableViewCell.h"

@implementation AnnouncementsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self)
    {
        // Initialization code
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 135, 26)];
        [self.name setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15]];
        [self.name setTextColor:[UIColor colorWithRed:40.0/255.5 green:47.0/255.0 blue:51.0/255.0 alpha:1.0]];
        [self.contentView addSubview:self.name];
        
        self.detail = [[UILabel alloc] initWithFrame:CGRectMake(150, 0, 65, 26)];
        [self.detail setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:15]];
        [self.detail setTextColor:[UIColor whiteColor]];
        [self.detail setBackgroundColor:[UIColor colorWithRed:199.0/255.5 green:41.0/255.0 blue:30.0/255.0 alpha:1.0]];
        [self.detail setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:self.detail];
    }
    
    return self;
}

@end