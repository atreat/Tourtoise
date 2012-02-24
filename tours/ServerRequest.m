//
//  ServerRequest.m
//  tours
//
//  Created by eq2-mac on 11/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ServerRequest.h"

@implementation ServerRequest

- (id)init
{
    self = [super init];
    if (self) {
        dataToBeLoaded = [[NSMutableData alloc] init];
        urlString = @"http://tourtoise.cems.uvm.edu/api/tour/1";
        url = [NSURL URLWithString:urlString];
        request = [[NSMutableURLRequest alloc] initWithURL:url];
        connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
    }
    
    return self;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"received data");
    NSLog(@"%@",data.description);
}
    
@end
