//
//  MPSFeedViewController.m
//  SWAGLibrary
//
//  Created by matt on 9/8/14.
//  Copyright (c) 2014 MPSurowiec. All rights reserved.
//

#import "MPSFeedViewController.h"
#import "MPSTemplateCell.h"
#import "MPSAPI.h"
#import "MPSBook.h"
#import "MPSDetailViewController.h"

static NSString *const MPSTemplateCellIdentifier = @"MPSTemplateCell";


@interface MPSFeedViewController () <UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate>


@property (strong, nonatomic) NSMutableArray *arrayOfBooks;
@property (strong, nonatomic) NSMutableArray *filteredBooks;

@end


@implementation MPSFeedViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.filteredBooks = [[NSMutableArray alloc]init];
    self.arrayOfBooks = [[NSMutableArray alloc]init];
    
    [MPSAPI getSwagBookLibrary:^(NSArray *books) {
        for (NSMutableDictionary *book in books){
            [self.arrayOfBooks addObject:book];
        }
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.tableView reloadData];
        }];
    }];
}

- (void)deselectAllRows {
    for (NSIndexPath *indexPath in [self.tableView indexPathsForSelectedRows]) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfSectionsInTableView:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return 1;
    } else {
     return self.arrayOfBooks.count;
   }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return self.filteredBooks.count;
    } else {
        return self.arrayOfBooks.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        
        MPSTemplateCell *cell = (MPSTemplateCell *)[self.tableView dequeueReusableCellWithIdentifier:@"MPSTemplateCell"];
        
        NSMutableDictionary *book = self.filteredBooks[indexPath.row];
        cell.titleLabelOutlet.text = book[@"title"];
        cell.authorLabelOutlet.text = book[@"author"];
        return cell;
    } else {
        return [self templateCellAtIndexPath:indexPath];
    }
}

- (MPSTemplateCell *)templateCellAtIndexPath:(NSIndexPath *)indexPath {
    MPSTemplateCell *cell = [self.tableView dequeueReusableCellWithIdentifier:MPSTemplateCellIdentifier forIndexPath:indexPath];
    [self configureTemplateCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureTemplateCell:(MPSTemplateCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *book = self.arrayOfBooks[indexPath.row];
    cell.titleLabelOutlet.text = book[@"title"];
    cell.authorLabelOutlet.text = book[@"author"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self heightForBasicCellAtIndexPath:indexPath];
}

- (CGFloat)heightForBasicCellAtIndexPath:(NSIndexPath *)indexPath {
    static MPSTemplateCell *sizeOfCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    sizeOfCell = [self.tableView dequeueReusableCellWithIdentifier:MPSTemplateCellIdentifier];
    });
    
    [self configureTemplateCell:sizeOfCell atIndexPath:indexPath];
    return [self calculateHeightForConfiguredSizingCell:sizeOfCell];
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizeOfCell {
    sizeOfCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.tableView.bounds), 0.0f);
    [sizeOfCell setNeedsLayout];
    [sizeOfCell layoutIfNeeded];
    
    CGSize size = [sizeOfCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self deselectAllRows];
    [self.tableView reloadData];
}


#pragma mark - Filtering

- (void)filterBooks:(NSArray *)books forSearchText:(NSString *)searchText {
    //books = [self.arrayOfBooks copy];
    NSPredicate *pOne = [NSPredicate predicateWithFormat:@"SELF.title contains[cd] %@", searchText];
    NSPredicate *pTwo = [NSPredicate predicateWithFormat:@"SELF.author contains[cd] %@", searchText];
    NSPredicate *pThree = [NSPredicate predicateWithFormat:@"SELF.categories contains[cd] %@", searchText];
    NSPredicate *predicate = [NSCompoundPredicate orPredicateWithSubpredicates:@[pOne, pTwo, pThree]];
    
    [self.filteredBooks addObjectsFromArray:[self.arrayOfBooks filteredArrayUsingPredicate:predicate]];
}

//
- (void)filterContentForSearchText:(NSString *)searchText {
    [self.filteredBooks removeAllObjects];
    [self filterBooks:self.filteredBooks forSearchText:searchText];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self filterContentForSearchText:searchString];
    return YES;
}

#pragma mark - UISearchDisplayController Delegate methods

//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//    MPSBook *bookDetails = self.arrayOfBooks[indexPath.row];
//    MPSDetailViewController *viewController = [segue destinationViewController];
//    viewController.book = bookDetails;
//    
//}

@end

