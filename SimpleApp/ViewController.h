//
//  ViewController.h
//  SimpleApp
//
//  Created by evhive on 14/03/19.
//  Copyright © 2019 Coco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITabBarDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *addButton;

- (IBAction)EditButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)AddButtonPressed:(UIBarButtonItem *)sender;

@end

