//
//  ViewController.swift
//  TableViewHeaderTest
//
//  Created by Agnes Vasarhelyi on 9/12/18.
//  Copyright © 2018 Agnes Vasarhelyi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  private let tableView: UITableView = UITableView()
  private let headerHeight: CGFloat = 100

  override func viewDidLoad() {
    super.viewDidLoad()

    // Setting up table view
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.view.addSubview(tableView)

    self.tableView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
      self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
      self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
    ])

    // Setting up table view header

    // There has to be an initial frame, otherwise it'll never get layed out
    let headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    self.view.addSubview(headerView)
    self.tableView.tableHeaderView = headerView

    headerView.title = "Title"
    headerView.desc = "This is a fine description. Not too short, not too long, but great."
  }

}

// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else {
      let newCell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
      newCell.textLabel?.text = "\(indexPath.row)"
      return newCell
    }

    cell.textLabel?.text = "\(indexPath.row)"
    return cell
  }
}

// MARK: UITableViewDelegate
extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    // If this is set to anything else, that breaks iOS 10 layout for the `tableHeaderView` (not section header)
    return UITableViewAutomaticDimension
  }
}

// MARK: Custom Header view
final class HeaderView: UIView {

  private let stackView: UIStackView = UIStackView()
  private let titleLabel: UILabel = UILabel()
  private let descLabel: UILabel = UILabel()

  // Public setter that updates label text
  var title: String = "" {
    didSet {
      self.titleLabel.text = title
      self.setNeedsLayout()
      self.layoutIfNeeded()
    }
  }

  // Public setter that updates label text
  var desc: String = "" {
    didSet {
      self.descLabel.text = desc
      self.setNeedsLayout()
      self.layoutIfNeeded()
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.setup()
  }

  private func setup() {
    // Stack View
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.spacing = 8
    stackView.axis = .vertical
    self.addSubview(stackView)

    // Title label
    titleLabel.font = UIFont.systemFont(ofSize: 16)
    titleLabel.textAlignment = .center
    stackView.addArrangedSubview(titleLabel)

    // Desc label
    descLabel.font = UIFont.systemFont(ofSize: 14)
    descLabel.textAlignment = .center
    descLabel.numberOfLines = 0
    stackView.addArrangedSubview(descLabel)

    stackView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
      stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
      stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
      stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
    ])
  }
}
