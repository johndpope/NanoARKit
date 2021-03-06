//
//  GameSettingsViewController.swift
//  caretAR
//
//  Created by Rafael Galdino on 19/02/20.
//  Copyright © 2020 Rafael Galdino. All rights reserved.
//

import Foundation
import UIKit

final class GameSettingsViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private let viewModel: GameSettingsViewModel

    init(viewModel: GameSettingsViewModel) {
           self.viewModel = viewModel
           super.init(nibName: nil, bundle: nil)
       }

       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                                                  target: self,
                                                                                  action: #selector(saveSettings))
        tableView.backgroundColor = .systemRed
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        layoutInterface()
    }

    @objc private func saveSettings() {
        viewModel.done()
    }

    private func layoutInterface() {
        tableView.rowHeight = 40
        self.view.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
    }

}

extension GameSettingsViewController: UITableViewDelegate {

}

extension GameSettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfExpressions()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = GameSettingsCell()
        cell.expressionLabel.text = viewModel.name(index: indexPath.row)
        cell.expressionSwitch.isOn = viewModel.state(index: indexPath.row)
        cell.delegate = self
        return cell
    }
}

extension GameSettingsViewController: GameSettingsCellDelegate {
    func pass(state: Bool, cell: UITableViewCell) {
        if let index = tableView.indexPath(for: cell)?.row {
            viewModel.stateChanged(atIndex: index, withState: state)
        }
    }
}
