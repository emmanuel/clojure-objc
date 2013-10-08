//
//  CLJPersistentVectorConstants.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 10/1/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

static const NSInteger kCLJPersistentVectorLevelBitPartitionWidth = 5;
static const NSInteger kCLJPersistentVectorCurrentLevelMask = 0x01f;
// TODO: derive kCLJPersistentVectorBranchingFactor from kCLJPersistentVectorLevelBitPartitionWidth:
// kCLJPersistentVectorBranchingFactor = 2 ^ kCLJPersistentVectorLevelBitPartitionWidth;
static const NSInteger kCLJPersistentVectorBranchingFactor = 32;
