//
//  Copyright (C) 2020 Thomas LEGRIS.
//

import UIKit
import WeatherSwiftSDK

/// List all favorite cities.
final class FavoriteCitiesListViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Internal Properties
    weak var delegate: CommonViewControllerDelegate?

    // MARK: - Private Properties
    private var viewModel: FavoriteCitiesListViewModel?
    private var dataSource: [CityWeatherModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - Private Enums
    private enum Constants {
        static let cellHeight: CGFloat = 90.0
    }

    // MARK: - Setup
    static func instantiate(viewModel: FavoriteCitiesListViewModel) -> FavoriteCitiesListViewController {
        let viewController = StoryboardScene.FavoritesCitiesList.initialScene.instantiate()
        viewController.viewModel = viewModel

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
        let nib = UINib(nibName: "FavoriteCityCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "FavoriteCityCell")
    }

    /// Setups the view model.
    func setupViewModel() {
        viewModel?.favoriteCitiesObs.bind { [weak self] _ in
            self?.updateView()
        }
        updateView()
    }

    /// Updates the view.
    func updateView() {
        guard let citiesList = viewModel?.favoriteCitiesObs.value else { return }

        dataSource = citiesList
    }
}

// MARK: - UITableViewDataSource
extension FavoriteCitiesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCityCell") as? FavoriteCityCell {
            cell.configureCell(cityModel: dataSource[indexPath.item])
            cell.backgroundColor = .clear
            cell.selectionStyle = .none

            return cell
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.cellHeight
    }
}

// MARK: - UITableViewDelegate
extension FavoriteCitiesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel?.isNetworkReachable == true {
            delegate?.didClickOnDetails(weatherModel: dataSource[indexPath.item])
        } else {
            showAlert(withTitle: L10n.commonError,
                      message: L10n.errorNoInternetDetails)
        }
    }
}
