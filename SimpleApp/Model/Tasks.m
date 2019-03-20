//
//  Tasks.m
//  SimpleApp
//
//  Created by evhive on 18/03/19.
//  Copyright © 2019 Coco. All rights reserved.
//

#import "Tasks.h"

@implementation Tasks

- (id)init
{
    self = [self initWithTitle:nil task:nil dueDate:nil isCompleted:nil];
    
    return self;
}

//designated initializer
-(id)initWithTitle:(NSString *)title task:(NSString *)task dueDate:(NSDate *)dueDate isCompleted:(NSString *)isCompleted
{
    self = [super init];
    
    self.title = title;
    self.task = task;
    self.dueDate = dueDate;
    self.isCompleted = isCompleted;
    
    return self;
    
}

-(id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [self initWithTitle:dictionary[@"title"] task:dictionary[@"task"] dueDate:dictionary[@"dueDate"] isCompleted:dictionary[@"isCompleted"]];
    
    return self;
}



@end
