//
//  CLJIEditableCollection.h
//  Clojure Lang
//
//  Created by Emmanuel Gomez on 9/18/13.
//  Copyright (c) 2013 Emmanuel Gomez. All rights reserved.
//

@protocol CLJITransientCollection;


@protocol CLJIEditableCollection

- (id<CLJITransientCollection>)asTransient;

@end
