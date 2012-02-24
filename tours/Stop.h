//
//  Stop.h
//  tours
//
//  Created by Austin Emmons on 12/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Stop : NSManagedObject

@property (nonatomic, retain) NSString          *   title;
@property (nonatomic, retain) NSString          *   dictionary;
@property (nonatomic, retain) NSString          *   uniqueId;
@property (nonatomic, retain) NSData            *   media;
@property (nonatomic, retain) NSManagedObject   *   inTour;

@end
