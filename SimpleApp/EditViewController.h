//
//  EditViewController.h
//  SimpleApp
//
//  Created by evhive on 19/03/19.
//  Copyright © 2019 Coco. All rights reserved.
//

#ifndef EditViewController_h
#define EditViewController_h


#endif /* EditViewController_h */

#import <UIKit/UIKit.h>
#import "Tasks.h"

@protocol EditViewControllerDelegate <NSObject>

@required
- (void)didSaveTask:(Tasks *)task;

@end

@interface EditViewController : UIViewController

@property (strong, nonatomic) Tasks *task;
@property (strong, nonatomic) id <EditViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *titleTextField;
@property (strong, nonatomic) IBOutlet UITextView *taskTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)dismissKeyboardPressed:(UIButton *)sender;

@end
