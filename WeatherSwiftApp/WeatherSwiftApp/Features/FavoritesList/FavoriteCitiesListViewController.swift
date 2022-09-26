//
//  Copyright (C) 2020 Thomas LEGRIS.
//

import UIKit
import RxSwift
import WeatherSwiftSDK

/// List all favorite cities.
final class FavoriteCitiesListViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Internal Properties
    weak var coordinator: FavoriteCitiesCoordinator?

    // MARK: - Private Properties
    private let viewModel = FavoriteCitiesListViewModel()
    private var dataSource: [FavoriteCity] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    private let disposeBag = DisposeBag()

    // MARK: - Private Enums
    private enum Constants {
        static let cellHeight: CGFloat = 90.0
    }

    // MARK: - Setup
    static func instantiate(coordinator: FavoriteCitiesCoordinator?) -> FavoriteCitiesListViewController {
        let viewController = StoryboardScene.FavoritesCitiesList.initialScene.instantiate()
        viewController.coordinator = coordinator

        return viewController
    }

    // MARK: - Override Funcs
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        setupViewModel()
    }
}

// MARK: - Private Funcs
private extension FavoriteCitiesListViewController {
    /// Inits the view.
    func initView() {
        titleLabel.text = L10n.favoriteList
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellType: FavoriteCityCell.self)
    }

    /// Setups the view model.
    func setupViewModel() {
        viewModel.favoriteCities.subscribe { [weak self] _ in
            self?.updateView()
        }.disposed(by: disposeBag)
        updateView()
    }

    /// Updates the view.
    func updateView() {
        guard let cities = try? viewModel.favoriteCities.value() else { return }

        dataSource = cities
    }
}

// MARK: - UITableViewDataSource
extension FavoriteCitiesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as FavoriteCityCell
        cell.configureCell(city: dataSource[indexPath.item])
        cell.backgroundColor = .clear
        cell.selectionStyle = .none

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.cellHeight
    }
}

// MARK: - UITableViewDelegate
extension FavoriteCitiesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.displayDetails(with: dataSource[indexPath.item].cityName)
    }
}
