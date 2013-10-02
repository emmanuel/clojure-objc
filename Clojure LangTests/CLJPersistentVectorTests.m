//
//  CLJPersistentVectorTests.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 10/2/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CLJPersistentVector.h"


@interface CLJPersistentVectorTests : XCTestCase

@end

@implementation CLJPersistentVectorTests

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

- (void)testWithMetaReturnsNewInstance
{
    CLJPersistentVector *vec = [CLJPersistentVector empty];
    XCTAssertNotNil(vec, @"could not get empty vector");
    XCTAssertNotEqualObjects(vec, [vec withMeta:nil], @"withMeta returned original instance");
}

- (void)testConsReturnsNewInstance
{
    CLJPersistentVector *vec = [CLJPersistentVector empty];
    XCTAssertNotNil(vec, @"could not get empty vector");
    XCTAssertNotEqualObjects(vec, [vec cons:[[NSObject alloc] init]], @"cons returned original instance");
}

- (void)testNthWorksAfterCons
{
    NSObject *content = [[NSObject alloc] init];
    CLJPersistentVector *vec = [[CLJPersistentVector empty] cons:content];
    XCTAssertNotNil(vec, @"could not cons on empty vector");
    XCTAssertEqualObjects(content, [vec nth:0], @"nth did not return original instance");
}

- (void)testCountWorksAfterCons
{
    NSObject *content = [[NSObject alloc] init];
    CLJPersistentVector *vec = [[CLJPersistentVector empty] cons:content];
    XCTAssertNotNil(vec, @"could not cons on empty vector");
    XCTAssertTrue(1 == [vec count], @"count did not return 1 after cons");
}

@end
