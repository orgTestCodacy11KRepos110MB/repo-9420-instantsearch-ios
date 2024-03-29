//
//  NumericFilterListConnector.swift
//  InstantSearchCore
//
//  Created by Vladislav Fitc on 26/11/2019.
//  Copyright © 2019 Algolia. All rights reserved.
//

import Foundation

/// Filtering component that displays any kind of numeric filters and lets the user refine the search results by selecting them.
///
/// [Documentation](https://www.algolia.com/doc/api-reference/widgets/filter-list-numeric/ios/)
public typealias NumericFilterListConnector = FilterListConnector<Filter.Numeric>

public extension NumericFilterListConnector {
  /**
   - Parameters:
     - numericFilters: Numeric filters to display
     - selectionMode: Whether a user can select .single or .multiple values
     - filterState: FilterState that holds your filters
     - operator: Whether we apply an `and` or `or` behavior to the filters in the filter state
     - groupName: Filter group name
   */
  convenience init(numericFilters: [NumericFilter] = [],
                   selectionMode: SelectionMode = .single,
                   filterState: FilterState,
                   operator: RefinementOperator,
                   groupName: String) {
    let interactor = NumericFilterListInteractor(items: numericFilters,
                                                 selectionMode: selectionMode)
    self.init(filterState: filterState,
              interactor: interactor,
              operator: `operator`,
              groupName: groupName)
  }

  /**
   - Parameters:
     - numericFilters: Numeric filters to display
     - selectionMode: Whether a user can select .single or .multiple values
     - filterState: FilterState that holds your filters
     - operator: Whether we apply an `and` or `or` behavior to the filters in the filter state
     - groupName: Filter group name
     - controller: Controller interfacing with a concrete filter list view
   */
  convenience init<Controller: SelectableListController>(numericFilters: [NumericFilter] = [],
                                                         selectionMode: SelectionMode = .single,
                                                         filterState: FilterState,
                                                         operator: RefinementOperator,
                                                         groupName: String,
                                                         controller: Controller) where Controller.Item == NumericFilter {
    let interactor = NumericFilterListInteractor(items: numericFilters,
                                                 selectionMode: selectionMode)
    self.init(filterState: filterState,
              interactor: interactor,
              operator: `operator`,
              groupName: groupName,
              controller: controller)
  }
}
