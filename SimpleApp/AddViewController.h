//
//  AddViewController.h
//  SimpleApp
//
//  Created by evhive on 14/03/19.
//  Copyright © 2019 Coco. All rights reserved.
//

#ifndef AddViewController_h
#define AddViewController_h


#endif /* AddViewController_h */

#import <UIKit/UIKit.h>
#import "Tasks.h"

@protocol AddItemViewControllerDelegate <NSObject>

@required
- (void)didCancel;
- (void)didAddTask:(Tasks *)task;
@end

@interface AddItemViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) id <AddItemViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UITextField *titleTextField;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
- (IBAction)cancelButtonPressed:(UIButton *)sender;

- (IBAction)dismissKeyboard:(UIButton *)sender;
- (IBAction)saveButtonPressed:(UIButton *)sender;


@end

