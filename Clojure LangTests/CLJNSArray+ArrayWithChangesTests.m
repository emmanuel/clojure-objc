//
//  CLJNSArray+ArrayWithChangesTests.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 10/8/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSArray+ArrayWithChanges.h"

@interface NSArray_ArrayWithChangesTests : XCTestCase

@end

@implementation NSArray_ArrayWithChangesTests

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

- (void)testArrayWithIndexSetToObjectDoesNotBlowUp
{
    id firstObject = [[NSObject alloc] init];
    id secondObject = [[NSObject alloc] init];
    NSArray *testArray = [[NSArray array] arrayByAddingObject:firstObject];
    XCTAssertNoThrow([testArray arrayWithIndex:0 setToObject:secondObject], @"expected arrayWithIndex:setToObject: not to throw an exception");
}

- (void)testSupportsSubsequentRetrieval
{
    id firstObject = [[NSObject alloc] init];
    id secondObject = [[NSObject alloc] init];
    NSArray *testArray = [[[NSArray array] arrayByAddingObject:firstObject] arrayWithIndex:0 setToObject:secondObject];
    XCTAssertNotEqual(firstObject, [testArray objectAtIndex:0], @"expected arrayWithIndex:setToObject: to stick");
}

@end
