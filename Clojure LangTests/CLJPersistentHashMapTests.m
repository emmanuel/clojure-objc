//
//  CLJPersistentHashMapTests.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 10/23/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CLJPersistentHashMap.h"


@interface CLJPersistentHashMapTests : XCTestCase

@end

@implementation CLJPersistentHashMapTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testEmpty
{
    CLJPersistentHashMap *emptyMap = nil;
    XCTAssertNoThrow(emptyMap = [CLJPersistentHashMap empty], @"failed to retrieve empty map");
    NSUInteger count = [emptyMap count];
    XCTAssert(0 == count, @"received non-zero count (%d)", count);
    XCTAssert(nil == [emptyMap entryAt:@"foo"], @"received non-nil response to non-existent key access");
    CLJPersistentHashMap *simple = [emptyMap assocKey:@"foo" withObject:@"bar"];
    XCTAssert(simple != emptyMap, @"assockKey:withObject: returned the receiver");
}

@end
