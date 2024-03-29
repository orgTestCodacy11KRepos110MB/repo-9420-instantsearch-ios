//
//  RelatedItemsDemoViewController.swift
//  DemoDirectory
//
//  Created by test test on 20/04/2020.
//  Copyright © 2020 Algolia. All rights reserved.
//

import InstantSearch
import SDWebImage
import UIKit

class RelatedItemsDemoViewController: UIViewController {
  let searcher: HitsSearcher
  let hitsInteractor: HitsInteractor<Hit<StoreItem>>

  let searchBoxConnector: SearchBoxConnector
  let searchController: UISearchController
  let textFieldController: TextFieldController
  let resultsViewController: ResultsViewController
  let recommendController: RecommendController

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    searcher = .init(client: .ecommerceRecommend,
                     indexName: .ecommerceRecommend)
    recommendController = .init(recommendClient: .ecommerceRecommend)
    resultsViewController = .init(searcher: searcher)
    searchController = .init(searchResultsController: resultsViewController)
    textFieldController = TextFieldController(searchBar: searchController.searchBar)
    searchBoxConnector = .init(searcher: searcher,
                               controller: textFieldController)
    hitsInteractor = .init()
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    resultsViewController.hitsViewController.didSelect = { [weak self] _, hit in
      guard let viewController = self else { return }
      viewController.recommendController.presentRelatedItems(for: hit.objectID, from: viewController)
    }
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    searchController.isActive = true
  }

  fileprivate func setupUI() {
    title = "Related Items"
    view.backgroundColor = .systemBackground
    definesPresentationContext = true
    navigationItem.searchController = searchController
    searchController.hidesNavigationBarDuringPresentation = false
    searchController.showsSearchResultsController = true
    searchController.automaticallyShowsCancelButton = false
  }

  private func setup() {
    hitsInteractor.connectSearcher(searcher)
    hitsInteractor.connectController(resultsViewController.hitsViewController)
    searcher.search()
  }
}
