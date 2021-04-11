//
//  GameViewController.swift
//  Kamikaze War
//
//  Created by jose manuel carreiro galicia on 09/4/21.
//  Copyright © 2021 Jose Carreiro. All rights reserved.
//

import ARKit

class GameViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet private weak var sceneView: ARSCNView!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var bulletsStack: UIStackView!
    
    // MARK: Constants
    private let viewModel: GameViewModel
    private let configuration = ARWorldTrackingConfiguration()
    
    // MARK: Lifecycle
    init(viewModel: GameViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupComponents()
        addGestures()
        showBullets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let cameraOrientation = sceneView.session.currentFrame?.camera.transform
        viewModel.viewWasLoaded(cameraOrientation: cameraOrientation)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        sceneView.session.pause()
    }
    
    // MARK: Private Functions
    private func setupComponents() {
        sceneView.session.run(configuration)
        sceneView.session.delegate = self
        sceneView.scene.physicsWorld.contactDelegate = self
    }
    
    private func addGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapScreen))
        view.addGestureRecognizer(tap)
    }
    
    private func showBullets() {
        viewModel.ammoViewModels.forEach { vm in
            let view = AmmoView(viewModel: vm)
            view.onSelectBullet = viewModel.changeSelectedBulletTo
            bulletsStack.addArrangedSubview(view)
        }
    }
    
    @objc private func tapScreen() {
        viewModel.fire()
    }
    
    private func pauseGame() {
        viewModel.pauseGame()
        sceneView.session.pause()
    }
    
    private func resumeGame() {
        viewModel.resumeGame()
        sceneView.session.run(configuration)
    }
    
    private func exitGame() {
        viewModel.exitGame()
    }
    
    private func gameOverAlert(score: Int) {
        pauseGame()
        
        let exitAction = UIAlertAction(title: "Accept", style: .default, handler: { [weak self] _ in
            self?.exitGame()
        })
        
        let alert = UIAlertController(title: "GAME OVER", message: "Your score: \(score)", preferredStyle: .alert)
        alert.addAction(exitAction)
        
        self.present(alert, animated: true)
    }
    
    // MARK: IBActions
    @IBAction private func tapExitButton(_ sender: Any) {
        pauseGame()
        
        let exitAction = UIAlertAction(title: "Exit", style: .destructive, handler: { [weak self] _ in
            self?.exitGame()
        })
        let continueAction = UIAlertAction(title: "Continue", style: .cancel, handler: { [weak self] _ in
            self?.resumeGame()
        })
        
        let alert = UIAlertController(title: "Do you want exit?", message: "Your current score will not save", preferredStyle: .alert)
        alert.addAction(exitAction)
        alert.addAction(continueAction)
        
        self.present(alert, animated: true)
    }
}

//MARK: - GameViewDelegate
extension GameViewController: GameViewDelegate {
    
    func planeAdded(_ plane: Plane) {
        sceneView.prepare([plane]) { [weak self] _ in
            self?.sceneView.scene.rootNode.addChildNode(plane)
            self?.sceneView.scene.rootNode.addChildNode(plane.lifeBar)
        }
    }
    
    func ammoBoxAdded(_ ammoBox: AmmoBox) {
        sceneView.prepare([ammoBox]) { [weak self] _ in
            self?.sceneView.scene.rootNode.addChildNode(ammoBox)
        }
    }
    
    func bulletFired(_ bullet: Bullet) {
        guard let camera = self.sceneView.session.currentFrame?.camera else {
            return
        }
        
        bullet.fireFrom(camera)
        sceneView.scene.rootNode.addChildNode(bullet)
    }
    
    func showExplosion(on node: SCNNode) {
        Explossion.show(with: node, in: sceneView.scene)
    }
    
    func updateScore(score: Int) {
        scoreLabel.text = "\(score)"
    }
    
    func gameOver(score: Int) {
        gameOverAlert(score: score)
    }
}

//MARK: - Contact delegate
extension GameViewController: SCNPhysicsContactDelegate {
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        guard let categoryBitMaskA = contact.nodeA.physicsBody?.categoryBitMask,
            let categoryBitMaskB = contact.nodeB.physicsBody?.categoryBitMask else {
                return
        }
        
        let planeBit = Collisions.plane.rawValue
        let bulletBit = Collisions.bullet.rawValue
        let ammoBoxBit = Collisions.ammoBox.rawValue
        
        if (categoryBitMaskA == planeBit && categoryBitMaskB == bulletBit) ||
            (categoryBitMaskA == bulletBit && categoryBitMaskB == planeBit) {
            
            if let plane = contact.nodeA as? Plane {
                viewModel.planeBeaten(plane, node: contact.nodeA)
                contact.nodeB.removeFromParentNode()
            } else if let plane = contact.nodeB as? Plane {
                viewModel.planeBeaten(plane, node: contact.nodeB)
                contact.nodeA.removeFromParentNode()
            }
        } else if (categoryBitMaskA == ammoBoxBit && categoryBitMaskB == bulletBit) ||
            (categoryBitMaskA == bulletBit && categoryBitMaskB == ammoBoxBit) {
            
            if let ammoBox = contact.nodeA as? AmmoBox {
                viewModel.ammoBoxBeaten(ammoBox, node: contact.nodeA)
                contact.nodeB.removeFromParentNode()
            } else if let ammoBox = contact.nodeB as? AmmoBox {
                viewModel.ammoBoxBeaten(ammoBox, node: contact.nodeB)
                contact.nodeA.removeFromParentNode()
            }
        }
    }
}

//MARK: - ARSCNViewDelegate
extension GameViewController: ARSessionDelegate {
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        guard let cameraOrientation = session.currentFrame?.camera.transform else {
            return
        }
        
        viewModel.cameraOrientation = cameraOrientation
        viewModel.planes.forEach { $0.face(to: cameraOrientation) }
    }
}
