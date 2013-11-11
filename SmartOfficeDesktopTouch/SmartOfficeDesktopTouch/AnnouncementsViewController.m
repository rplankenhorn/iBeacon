//
//  MainViewController.m
//  SmartOfficeDesktopTouch
//
//  Created by Robbie Plankenhorn on 11/6/13.
//  Copyright (c) 2013 Solstice Mobile. All rights reserved.
//

#import "AnnouncementsViewController.h"
#import "HeaderViewController.h"
#import "AnnouncementsTableViewCell.h"

@implementation Anniversary
@end

@implementation Birthday
@end

@implementation AnnouncementsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self)
    {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    HeaderViewController *headerViewController = [[HeaderViewController alloc] initWithNibName:@"HeaderView" bundle:nil];
    [headerView addSubview:headerViewController.view];
    
    [announcementTableView registerClass:[AnnouncementsTableViewCell class] forCellReuseIdentifier:@"MyCellIdentifier"];
    announcementTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    sectionHeaders = [[NSArray alloc] initWithObjects:@"Solstice Anniversaries", @"Solstice Birthdays", nil];
    
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:nil];
    Anniversary *anniversary;
    Birthday *birthday;
    
    anniversary = [[Anniversary alloc] init];
    anniversary.name = @"Angelique Rickhoff";
    anniversary.years = 1;
    [mutableArray addObject:anniversary];
    
    anniversary = [[Anniversary alloc] init];
    anniversary.name = @"Alyssa Bollinger";
    anniversary.years = 2;
    [mutableArray addObject:anniversary];
    
    anniversaries = [[NSArray alloc] initWithArray:mutableArray];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    dateFormatter.dateFormat = @"MM/dd";
    
    mutableArray = [NSMutableArray arrayWithArray:nil];
    
    birthday = [[Birthday alloc] init];
    birthday.name = @"Jessica Seiler";
    birthday.date = [dateFormatter dateFromString:@"11/06"];
    [mutableArray addObject:birthday];
    
    birthday = [[Birthday alloc] init];
    birthday.name = @"Olivia La Faire";
    birthday.date = [dateFormatter dateFromString:@"11/13"];
    [mutableArray addObject:birthday];
    
    birthday = [[Birthday alloc] init];
    birthday.name = @"Henry Oyuela";
    birthday.date = [dateFormatter dateFromString:@"11/15"];
    [mutableArray addObject:birthday];
    
    birthday = [[Birthday alloc] init];
    birthday.name = @"Travis Hiltrop";
    birthday.date = [dateFormatter dateFromString:@"11/17"];
    [mutableArray addObject:birthday];
    
    birthdays = [[NSArray alloc] initWithArray:mutableArray];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if(section == 0)
//    {
//        return @"Solstice Anniversaries";
//    }
//    else
//    {
//        return @"Solstice Birthdays";
//    }
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 162, 15)];
    [label setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:17]];
    [label setTextColor:[UIColor colorWithRed:200.0/255.0 green:62.0/255.0 blue:49.0/255.0 alpha:1.0]];
    NSString *string = [sectionHeaders objectAtIndex:section];
    /* Section header is in 0th index... */
    [label setText:string];
    [label sizeToFit];
    [view addSubview:label];

    [view setBackgroundColor:[UIColor clearColor]];
    
    UIView *bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(0, 22, label.frame.size.width, 2)];
    [bottomBorder setBackgroundColor:[UIColor colorWithRed:143.0/255.0 green:205.0/255.0 blue:208.0/255.0 alpha:1.0]];
    [view addSubview:bottomBorder];
    
    UIView *bottomUnderlineBorder = [[UIView alloc] initWithFrame:CGRectMake(62, 19, label.frame.size.width - 62, 3)];
    [bottomUnderlineBorder setBackgroundColor:[UIColor colorWithRed:143.0/255.0 green:205.0/255.0 blue:208.0/255.0 alpha:1.0]];
    [view addSubview:bottomUnderlineBorder];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 10)];
    [view setBackgroundColor:[UIColor clearColor]];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return [anniversaries count];
    }
    else
    {
        return [birthdays count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if(cell == nil)
    {
        cell = [[AnnouncementsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    [self configureCustomCell:(AnnouncementsTableViewCell *)cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCustomCell:(AnnouncementsTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        Anniversary *anniversary = [anniversaries objectAtIndex:indexPath.row];
        
        cell.name.text = anniversary.name;
        cell.detail.text = [NSString stringWithFormat:@"%d year%@", anniversary.years, (anniversary.years > 1 ? @"s" : @"")];
    }
    else
    {
        Birthday *birthday = [birthdays objectAtIndex:indexPath.row];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:birthday.date];
        
        cell.name.text = birthday.name;
        cell.detail.text = [NSString stringWithFormat:@"%.2ld", (long)[components day]];
        
        cell.detail.frame = CGRectMake(150, 0, 32, 25);
    }
}

@end