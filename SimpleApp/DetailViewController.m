//
//  DetailViewController.m
//  SimpleApp
//
//  Created by evhive on 18/03/19.
//  Copyright © 2019 Coco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EditViewController.h"

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"to EditVC"]) {
        if ([segue.destinationViewController isKindOfClass:[EditViewController class]]) {
            
            EditViewController *editVC = segue.destinationViewController;
            editVC.delegate = self;
            
            editVC.task = self.task;
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm"];
    
    NSString *dueDate = [dateFormatter stringFromDate:self.task.dueDate];
    self.titleTextLabel.text = self.task.title;
    self.taskTextView.text = self.task.task;
    self.dateTextLabel.text = dueDate;
    
    if ([self.task.isCompleted isEqualToString:@"YES"]) {
        NSLog(@"completed");
        [self.completeButton setTitle:@"Mark as incomplete" forState:UIControlStateNormal];
    } else {
        [self.completeButton setTitle:@"Mark as complete" forState:UIControlStateNormal];
    }

}

- (IBAction)completeButtonPressed:(id)sender {
    
    if ([self.task.isCompleted isEqualToString:@"YES"]){
        self.task.isCompleted = @"NO";
    } else {
        self.task.isCompleted = @"YES";
    }
    
    [self.delegate didSaveTask:self.task atIndexPath:self.taskIndexPath];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)editButtonPressed:(UIBarButtonItem *)sender {
    
    [self performSegueWithIdentifier:@"to EditVC" sender:sender];
}
- (void)didSaveTask:(Tasks *)task
{
    NSLog(@"detailVC got the saved task %@", task);
    
    [self.delegate didSaveTask:task atIndexPath:self.taskIndexPath];
}
@end
