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

#import "RLMTypeOutlineViewController.h"

#import "RLMRealmBrowserWindowController.h"
#import "RLMRealmOutlineNode.h"
#import "RLMArrayNavigationState.h"
#import "RLMQueryNavigationState.h"

@interface RLMTypeOutlineViewController ()

@property (nonatomic, strong) IBOutlet NSOutlineView *classesOutlineView;

@end

@implementation RLMTypeOutlineViewController

#pragma mark - RLMViewController overrides

- (void)awakeFromNib
{
    [super awakeFromNib];

    // Expand the root item representing the selected realm.
    RLMRealmNode *firstItem = self.parentWindowController.modelDocument.presentedRealm;
    if (firstItem != nil) {
        // We want the class outline to be expanded as default
        [self.classesOutlineView expandItem:firstItem
                             expandChildren:YES];
    }
}

#pragma mark - RLMViewController overrides

- (void)performUpdateUsingState:(RLMNavigationState *)newState oldState:(RLMNavigationState *)oldState
{
    [super performUpdateUsingState:newState
                          oldState:oldState];
 
    if ([oldState isMemberOfClass:[RLMArrayNavigationState class]] ||
        [oldState isMemberOfClass:[RLMQueryNavigationState class]]) {
        RLMClazzNode *parentNode = (RLMClazzNode *)oldState.selectedType;
        [parentNode removeAllChildNodes];
        [self.tableView reloadData];
    }
    
    if ([newState isMemberOfClass:[RLMNavigationState class]]) {
        if ([oldState isMemberOfClass:[RLMQueryNavigationState class]] || newState.selectedType != oldState.selectedType) {
            NSInteger typeIndex = [self.classesOutlineView rowForItem:newState.selectedType];
            
            [self setSelectionIndex:typeIndex];
        }
    }
    else if ([newState isMemberOfClass:[RLMArrayNavigationState class]]) {
        RLMArrayNavigationState *arrayState = (RLMArrayNavigationState *)newState;
        
        RLMClazzNode *parentClassNode = (RLMClazzNode *)arrayState.selectedType;
        NSInteger selectionIndex = arrayState.selectedInstanceIndex;
        RLMObject *selectedInstance = [parentClassNode instanceAtIndex:selectionIndex];
        
        RLMArrayNode *arrayNode = [parentClassNode displayChildArrayFromProperty:arrayState.property object:selectedInstance];
        
        [self.classesOutlineView reloadData];
        [self.classesOutlineView expandItem:parentClassNode];
        
        NSInteger index = [self.classesOutlineView rowForItem:arrayNode];
        if (index != NSNotFound) {
            [self setSelectionIndex:index];
        }
    }
    else if ([newState isMemberOfClass:[RLMQueryNavigationState class]]) {
        RLMQueryNavigationState *arrayState = (RLMQueryNavigationState *)newState;

        RLMClazzNode *parentClassNode = (RLMClazzNode *)arrayState.selectedType;

        RLMArrayNode *arrayNode = [parentClassNode displayChildArrayFromQuery:arrayState.searchText result:arrayState.results];

        [self.classesOutlineView reloadData];
        [self.classesOutlineView expandItem:parentClassNode];

        NSInteger index = [self.classesOutlineView rowForItem:arrayNode];
        if (index != NSNotFound) {
            [self setSelectionIndex:index];
        }
    }
}

#pragma mark - NSOutlineViewDataSource implementation

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item
{
    if (item == nil) {
        return self.parentWindowController.modelDocument.presentedRealm;
    }
    // ... and second level nodes are all classes.
    else if ([item conformsToProtocol:@protocol(RLMRealmOutlineNode)]) {
        id<RLMRealmOutlineNode> outlineItem = item;
        return [outlineItem childNodeAtIndex:index];
    }
    
    return nil;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item
{
    // The root node is expandable if we are presenting a realm
    if (item == nil) {
        return self.parentWindowController.modelDocument.presentedRealm == nil;
    }
    // ... otherwise the exandability check is re-delegated to the node in question.
    else if ([item conformsToProtocol:@protocol(RLMRealmOutlineNode)]) {
        id<RLMRealmOutlineNode> outlineItem = item;
        return outlineItem.isExpandable;
    }
    
    return NO;
}

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item
{
    // There is never more than one root node
    if (item == nil) {
        return 1;
    }
    // ... otherwise the number of child nodes are defined by the node in question.
    else if ([item conformsToProtocol:@protocol(RLMRealmOutlineNode)]) {
        id<RLMRealmOutlineNode> outlineItem = item;
        return outlineItem.numberOfChildNodes;
    }
    
    return 0;
}

#pragma mark - NSOutlineViewDelegate implementation

- (BOOL)outlineView:(NSOutlineView *)outlineView isGroupItem:(id)item
{
    return [item isKindOfClass:[RLMRealmNode class]];
}

- (BOOL)outlineView:(NSOutlineView *)outlineView shouldSelectItem:(id)item
{
    // Group headers should not be selectable
    return ![item isKindOfClass:[RLMRealmNode class]];
}

- (BOOL)outlineView:(NSOutlineView *)outlineView shouldCollapseItem:(id)item
{
    // The top level node should not be collapsed.
    return item != self.parentWindowController.modelDocument.presentedRealm;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView shouldShowOutlineCellForItem:(id)item
{
    // The top level node should not display the toggle triangle.
    return item != self.parentWindowController.modelDocument.presentedRealm;
}

- (NSString *)outlineView:(NSOutlineView *)outlineView toolTipForCell:(NSCell *)cell rect:(NSRectPointer)rect tableColumn:(NSTableColumn *)tc item:(id)item mouseLocation:(NSPoint)mouseLocation
{
    if ([item respondsToSelector:@selector(hasToolTip)]) {
        if ([item respondsToSelector:@selector(toolTipString)]) {
            return [item toolTipString];
        }
    }
    
    return nil;
}

- (void)outlineViewSelectionDidChange:(NSNotification *)notification
{
    NSOutlineView *outlineView = notification.object;
    if (outlineView == self.classesOutlineView) {
        id selectedItem = [outlineView itemAtRow:[outlineView selectedRow]];

        // The arrays we get from link views are ephemeral, so we
        // remove them when any class node is selected
        if ([selectedItem isKindOfClass:[RLMClazzNode class]]) {
            [self removeAllChildArrays];
        }

        RLMNavigationState *state = [[RLMNavigationState alloc] initWithSelectedType:selectedItem index:0];

        [self.parentWindowController addNavigationState:state
                                     fromViewController:self];
    }
}

- (void)outlineView:(NSOutlineView *)outlineView didAddRowView:(NSTableRowView *)rowView forRow:(NSInteger)row
{
    // No Action
}

- (void)outlineView:(NSOutlineView *)outlineView didRemoveRowView:(NSTableRowView *)rowView forRow:(NSInteger)row
{
    // No Action
}

- (NSTableRowView *)outlineView:(NSOutlineView *)outlineView rowViewForItem:(id)item
{
    return nil;
}

- (NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(NSTableColumn *)tableColumn item:(id)item
{
    if (outlineView == self.classesOutlineView) {
        if ([item conformsToProtocol:@protocol(RLMRealmOutlineNode)]) {
            id<RLMRealmOutlineNode> outlineNode = item;
            return [outlineNode cellViewForTableView:self.tableView];
        }
    }
    
    return nil;
}

#pragma mark - Public methods - Accessors

- (NSOutlineView *)outlineView
{
    if ([self.view isKindOfClass:[NSOutlineView class]]) {
        return (NSOutlineView *)self.view;
    }
    
    return nil;
}

#pragma mark - Private methods

- (void)removeAllChildArrays
{
    for (RLMClazzNode *node in self.parentWindowController.modelDocument.presentedRealm.topLevelClazzes) {
        [node removeAllChildNodes];
        [self.classesOutlineView reloadItem:node];
    }
}

@end
