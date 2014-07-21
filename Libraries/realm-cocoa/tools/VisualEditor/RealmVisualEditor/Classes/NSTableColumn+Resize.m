////////////////////////////////////////////////////////////////////////////
//
// Copyright 2014 Realm Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
////////////////////////////////////////////////////////////////////////////

#import "NSTableColumn+Resize.h"

@implementation NSTableColumn (Resize)

const NSUInteger kMaxNumberOfRowsToConsider = 100;

- (void)resizeToFitContents
{
    NSTableView *tableView = self.tableView;
    NSRect rect = NSMakeRect(0,0, INFINITY, tableView.rowHeight);
    NSInteger columnIndex = [tableView.tableColumns indexOfObject:self];
    CGFloat maxSize = 0;
    
    for (NSInteger index = 0; index < MIN(kMaxNumberOfRowsToConsider, tableView.numberOfRows); index++) {
        NSCell *cell = [tableView preparedCellAtColumn:columnIndex
                                                   row:index];
        NSSize size = [cell cellSizeForBounds:rect];
        maxSize = MAX(maxSize, size.width);
    }
    
    NSCell *headerCell = self.headerCell;
    NSSize headerSize = [headerCell cellSizeForBounds:rect];
    maxSize = MAX(maxSize, headerSize.width) * 1.25;
    
    self.width = maxSize;
}

@end
