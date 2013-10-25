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

- (void)testEmptyCanBeInited
{
    CLJPersistentHashMap *emptyMap = nil;
    XCTAssertNoThrow(emptyMap = [CLJPersistentHashMap empty], @"failed to retrieve empty map");
}

- (void)testEmptyHas0Count
{
    CLJPersistentHashMap *emptyMap = [CLJPersistentHashMap empty];
    NSUInteger count = [emptyMap count];
    XCTAssert(0 == count, @"received non-zero count (%d)", count);
}

- (void)testEntryAtReturnsNilForAnUnknownKey
{
    CLJPersistentHashMap *emptyMap = [CLJPersistentHashMap empty];
    XCTAssert(nil == [emptyMap entryAt:@"foo"], @"received non-nil response to non-existent key access");
}

- (void)testAssocKeyWithObjectReturnsANewHashMap
{
    CLJPersistentHashMap *emptyMap = [CLJPersistentHashMap empty];
    CLJPersistentHashMap *simple = [emptyMap assocKey:@"foo" withObject:@"bar"];
    XCTAssert(simple != emptyMap, @"assockKey:withObject: returned the receiver");
}

- (void)testAssocKeyWithObjectReturnsAHashMapWithIncrementedCount
{
    CLJPersistentHashMap *emptyMap = [CLJPersistentHashMap empty];
    CLJPersistentHashMap *simple = [emptyMap assocKey:@"foo" withObject:@"bar"];
    NSUInteger count = [simple count];
    XCTAssert(1 == count, @"count returned unexpected amount: %d", count);
}

- (void)testEntryAtReturnsExpectedObjectAfterAssocKeyWithObject
{
    CLJPersistentHashMap *emptyMap = [CLJPersistentHashMap empty];
    id key = [NSString stringWithFormat:@"%@", @"foo"];
    id object = @"bar";
    CLJPersistentHashMap *simple = [emptyMap assocKey:key withObject:object];
    id retrieved = [simple entryAt:key];
    XCTAssert([retrieved object] == object, @"entryAt: returned different object after assockKey:withObject:");
}

- (void)testContainsKeyReturnsYESAfterAssocKeyWithObject
{
    CLJPersistentHashMap *emptyMap = [CLJPersistentHashMap empty];
    id key = [NSString stringWithFormat:@"%@", @"foo"];
    id object = @"bar";
    CLJPersistentHashMap *simple = [emptyMap assocKey:key withObject:object];
    BOOL retrieved = [simple containsKey:key];
    XCTAssertTrue(retrieved, @"containsKey: returned NO after assockKey:withObject:");
}

@end
