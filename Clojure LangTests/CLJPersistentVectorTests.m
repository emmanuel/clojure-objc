//
//  CLJPersistentVectorTests.m
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 10/2/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CLJPersistentVector.h"
#import "CLJPersistentVectorConstants.h"

@interface CLJPersistentVector (TestHelpers)

@property (nonatomic, readonly) NSUInteger shift;

@end



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

- (CLJPersistentVector *)vectorWithLevel:(NSUInteger)level
{
    if (0 == level)
    {
        return [CLJPersistentVector empty];
    }
    else if (0 < level)
    {
        level--;
    }

    NSUInteger count = (1 << (level * kCLJPersistentVectorLevelBitPartitionWidth)) + kCLJPersistentVectorBranchingFactor + 1;
    return [self vectorWithCount:count];
}

- (CLJPersistentVector *)vectorWithCount:(NSUInteger)count
{
    CLJPersistentVector *vec = [CLJPersistentVector empty];

    for (NSUInteger i = 0; i < count; i++) {
        vec = [vec cons:[NSObject new]];
    }

    return vec;
}

- (void)testEmptyDoesntBlowUp
{
    XCTAssertNoThrow([CLJPersistentVector empty], @"empty threw exception");
}

- (void)testEmptyReturnsInstancetype
{
    CLJPersistentVector *empty = [CLJPersistentVector empty];
    XCTAssertNotNil(empty, @"empty vector was nil");
    XCTAssert([empty isKindOfClass:[CLJPersistentVector class]], @"empty vector (%@) was not kind of %@", empty, [CLJPersistentVector class]);
}

- (void)testEmptyReturnsInstanceOfVectorWith0Count
{
    CLJPersistentVector *empty = [CLJPersistentVector empty];
    XCTAssertEqual([empty count], 0U, @"expected count to return an unsigned zero");
    XCTAssert([empty count] == 0, @"expected equality to be looser");
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
    XCTAssertNotEqualObjects(vec, [vec cons:[NSObject new]], @"cons returned original instance");
}

- (void)testNthWorksAfterCons
{
    NSObject *content = [NSObject new];
    CLJPersistentVector *vec = [[CLJPersistentVector empty] cons:content];
    XCTAssertNotNil(vec, @"could not cons on empty vector");
    XCTAssertEqualObjects(content, [vec nth:0], @"nth did not return original instance");
}

- (void)testCountWorksAfterFirstCons
{
    NSObject *content = [NSObject new];
    CLJPersistentVector *vec = [[CLJPersistentVector empty] cons:content];
    XCTAssertNotNil(vec, @"could not cons on empty vector");
    XCTAssertEqual(1U, [vec count], @"count did not return 1 after cons");
}

- (void)testVectorWith2LevelsHasExpectedCount
{
    CLJPersistentVector *vec = [self vectorWithLevel:2];
    XCTAssertNotNil(vec, @"could not build vector with two levels");
    // (original) root + tail + 1 node
    XCTAssertEqual(32U + 32U + 1U, [vec count], @"vector with 2 levels did not return expected count (33U)");
}

- (void)testVectorWith2LevelsHasExpectedShift
{
    CLJPersistentVector *vec = [self vectorWithLevel:2];
    XCTAssertNotNil(vec, @"could not build vector with two levels");
    XCTAssertEqualObjects(@(5U), [vec valueForKey:@"shift"], @"vector with 2 levels did not return expected shift (5)");
}

- (void)testVectorWith3LevelsHasExpectedCount
{
    CLJPersistentVector *vec = [self vectorWithLevel:3];
    XCTAssertNotNil(vec, @"could not build vector with two levels");
    // 1 full 1st-order level + tail + 1 node
    XCTAssertEqual(1024U + 32U + 1U, [vec count], @"vector with 3 levels did not return expected count (1024)");
}

- (void)testVectorWith3LevelsHasExpectedShift
{
    CLJPersistentVector *vec = [self vectorWithLevel:3];
    XCTAssertNotNil(vec, @"could not build vector with two levels");
    XCTAssertEqualObjects(@(10U), [vec valueForKey:@"shift"], @"vector with 3 levels did not return expected shift (5)");
}

- (void)testAssocNReturnsNewVector
{
    NSUInteger index = 0;
    CLJPersistentVector *vec1 = [CLJPersistentVector empty];
    NSObject *insertedObject = [NSObject new];
    CLJPersistentVector *vec2 = [vec1 assocN:index withObject:insertedObject];
    XCTAssertNotNil(vec2, @"vector with 0 elements returned nil from assocN:withObject:");
    XCTAssertNotEqual(vec1, vec2, @"vector did not return new vector instance");
}

- (void)testAssocNReturnsVectorWithObjectAtIndex
{
    NSUInteger index = 0;
    NSObject *insertedObject = [NSObject new];
    CLJPersistentVector *vec = [[CLJPersistentVector empty] assocN:index withObject:insertedObject];
    XCTAssertEqual([vec nth:index], insertedObject, @"vector did not retrieve expected object");
}

- (void)testAssocNWith1LevelReturnsVectorWithObjectAtIndex
{
    NSObject *insertedObject = [NSObject new];
    CLJPersistentVector *vec = [self vectorWithLevel:1];
    NSUInteger index = 1 << [vec shift];
    vec = [vec assocN:index withObject:insertedObject];
    XCTAssertEqual([vec nth:index], insertedObject, @"vector did not retrieve expected object");
}

- (void)testAssocNWith2LevelsReturnsVectorWithObjectAtIndex
{
    NSObject *insertedObject = [NSObject new];
    CLJPersistentVector *vec = [self vectorWithLevel:2];
    NSUInteger index = 1 << [vec shift];
    vec = [vec assocN:index withObject:insertedObject];
    XCTAssertEqual([vec nth:index], insertedObject, @"vector did not retrieve expected object");
}

- (void)testAssocNWith3LevelsReturnsVectorWithObjectAtIndex
{
    NSObject *insertedObject = [NSObject new];
    CLJPersistentVector *vec = [self vectorWithLevel:3];
    NSUInteger index = 1 << [vec shift];
    vec = [vec assocN:index withObject:insertedObject];
    XCTAssertEqual([vec nth:index], insertedObject, @"vector did not retrieve expected object");
}

@end
