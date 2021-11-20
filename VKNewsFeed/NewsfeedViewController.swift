//
//  NewsfeedViewController.swift
//  VKNewsFeed
//
//  Created by Дмитрий Межевич on 8.11.21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsfeedDisplayLogic: NSObject {
  func displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData)
}

class NewsfeedViewController: UIViewController, NewsfeedDisplayLogic, NewsfeedCellCodeDelegate {

  var interactor: NewsfeedBusinessLogic?
  var router: (NSObjectProtocol & NewsfeedRoutingLogic)?
    private var feedViewModel = FeedViewModel.init(cells: [])
    private let titelView = TitelView()
    private let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
    @IBOutlet var tableView: UITableView!
    
    // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup() {
    let viewController        = self
    let interactor            = NewsfeedInteractor()
    let presenter             = NewsfeedPresenter()
    let router                = NewsfeedRouter()
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
  }
  
  // MARK: Routing
  

  
  // MARK: View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setup()
        setupTableView()
        setupNavigationBar()
        
        interactor?.makeRequest(request: .getNewsFeed)
        interactor?.makeRequest(request: .getUserData)
  }
  
    // MARK: - NewsfeedCellCodeDelegate when pressed moreTextButton
    func revealPost(for cell: NewsfeedCodeCell) {
        guard let row = tableView.indexPath(for: cell)?.row else { return }
        let sourceId = self.feedViewModel.cells[row].postId
        interactor?.makeRequest(request: .revealPostId(postId: sourceId))
    }
    
    // MARK: - Update content on view
    func displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayNewsfeed(feedViewModel: let feedViewModel):
            self.feedViewModel = feedViewModel
            refreshControl.endRefreshing()
            tableView.reloadData()
        case .displayAvatarUser(titelViewModel: let titelViewModel):
            titelView.set(userViewModel: titelViewModel)
        }
    }
    
    @objc private func refresh() {
        interactor?.makeRequest(request: .getNewsFeed)
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.contentInset.top = ConstantsSize.insetTopTableView
        
        //        tableView.register(UINib(nibName: "NewsfeedCell", bundle: nil), forCellReuseIdentifier: NewsfeedCell.reuseId)
        tableView.register(NewsfeedCodeCell.self, forCellReuseIdentifier: NewsfeedCodeCell.reuseId)
        
        tableView.addSubview(refreshControl)
    }
    
    private func setupNavigationBar() {
        let navigationBarAppearence = UINavigationBarAppearance()
        navigationBarAppearence.shadowColor = .clear
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearence
        navigationController?.hidesBarsOnSwipe = true
        navigationItem.titleView = titelView
        
        // Add view for StatusBar
        let barView = UIView(frame: UIApplication.shared.statusBarFrame)
        barView.backgroundColor = #colorLiteral(red: 0.9677422643, green: 0.9727137685, blue: 0.9726259112, alpha: 1)
        barView.layer.shadowColor = UIColor.black.cgColor
        barView.layer.shadowRadius = 8
        barView.layer.shadowOpacity = 0.3
        barView.layer.shadowOffset = CGSize.zero
        view.addSubview(barView)
    }
}


extension NewsfeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        feedViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Staryboard
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: NewsfeedCell.reuseId, for: indexPath) as! NewsfeedCell
//        let cellViewModel = feedViewModel.cells[indexPath.row]
//        cell.set(viewModel: cellViewModel)
        
        // Xib
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsfeedCodeCell.reuseId, for: indexPath) as! NewsfeedCodeCell
        let cellViewModel = feedViewModel.cells[indexPath.row]
        cell.set(viewModel: cellViewModel)
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        feedViewModel.cells[indexPath.row].layoutCell.totalHeightCell
    }
    
}
