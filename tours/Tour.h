//
//  Tour.h
//  tours
//
//  Created by Austin Emmons on 12/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Stop;

@interface Tour : NSManagedObject

@property (nonatomic, retain) NSString  *   title;
@property (nonatomic, retain) NSString  *   dictionary;
@property (nonatomic, retain) NSSet     *   stops;

@end

@interface Tour (CoreDataGeneratedAccessors)

- (void)addStopsObject:(Stop *)value;
- (void)removeStopsObject:(Stop *)value;
- (void)addStops:(NSSet *)values;
- (void)removeStops:(NSSet *)values;

@end
