//
//  DetailViewController.h
//  SimpleApp
//
//  Created by evhive on 18/03/19.
//  Copyright © 2019 Coco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditViewController.h"
#import "Tasks.h"

@protocol DetailViewControllerDelegate <NSObject>

@required

- (void)didSaveTask:(Tasks *)task atIndexPath:(NSIndexPath *)indexPath;

@end

@interface DetailViewController : UIViewController <EditViewControllerDelegate>
@property (strong, nonatomic) id <DetailViewControllerDelegate> delegate;

@property (strong, nonatomic) Tasks *task;
@property (strong, nonatomic) NSIndexPath *taskIndexPath;
@property (strong, nonatomic) IBOutlet UILabel *titleTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateTextLabel;
@property (strong, nonatomic) IBOutlet UITextView *taskTextView;

@property (strong, nonatomic) IBOutlet UIButton *completeButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *editButton;

- (IBAction)completeButtonPressed:(id)sender;
- (IBAction)editButtonPressed:(UIBarButtonItem *)sender;


@end
