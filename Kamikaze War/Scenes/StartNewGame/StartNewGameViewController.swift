//
//  StartNewGameViewController.swift
//  Kamikaze War
//
//  Created by jose manuel carreiro galicia on 09/4/21.
//  Copyright © 2021 Jose Carreiro. All rights reserved.
//

import UIKit

class StartNewGameViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var modeSwitch: UISwitch!
    
    // MARK: Constants
    private let viewModel: StartNewGameViewModel
    
    // MARK: Lifecycle
    init(viewModel: StartNewGameViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.viewWasLoaded()
    }
    
    // MARK: Private functions
    private func configureNavigationBar() {
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: IBActions
    @IBAction private func tapStartNewGameButton(_ sender: Any) {
        viewModel.startNewGame(hardIsOn: modeSwitch.isOn)
    }
}

// MARK: NewGameViewDelegate
extension StartNewGameViewController: NewGameViewDelegate {
    
    func scoreFetched() {
        scoreLabel.text = "Hight Score: \(viewModel.highScore)"
    }
}
