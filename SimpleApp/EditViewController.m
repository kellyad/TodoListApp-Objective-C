//
//  EditViewController.m
//  SimpleApp
//
//  Created by evhive on 19/03/19.
//  Copyright © 2019 Coco. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EditViewController.h"

@interface EditViewController ()

@end


@implementation EditViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.titleTextField.text = self.task.title;
    self.taskTextView.text = self.task.task;
    self.datePicker.date = self.task.dueDate;
}

- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender {
    Tasks *editedTask = [[Tasks alloc] initWithTitle:self.titleTextField.text task:self.taskTextView.text dueDate:self.datePicker.date isCompleted:self.task.isCompleted];
    
    [self.delegate didSaveTask:editedTask];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)dismissKeyboardPressed:(UIButton *)sender {
    [self.view endEditing:NO];
}
@end
