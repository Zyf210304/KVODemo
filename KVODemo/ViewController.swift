//
//  ViewController.swift
//  KVODemo
//
//  Created by     马世杰 on 2024/11/7.
//

import UIKit

class ViewController: UIViewController {

    var person:Person = Person()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        person.addObserver(self, forKeyPath: #keyPath(Person.name), options: [.new,.old], context: nil)
        person.name = "John"
        
        view.addSubview(btn)
        
        //通过KVC设置Value能否生效
        //可以 调用了set方法 set方法已经被动态生成子类重写了  可以出发KVO
        person.setValue("bda", forKey: "name")
        
        //通过成员变量的直接复制 value能否生效
        //不生效
        person.changeName()
        //手动KVO
        person.changeName2()
    }
    
    
    lazy var btn: UIButton = {
        let r = UIButton(frame: CGRectMake(100, 100, 100, 100))
        r.backgroundColor = .red
        r.addTarget(self, action: #selector(changeName), for: .touchUpInside)
        return r
    }()
    
    @objc func changeName() {
        print(#line, person.name)
        person.name = "abc"
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == #keyPath(Person.name) {
            if let newName = change?[.newKey] as? String {
                print("New name: \(newName)")
            }
            
            if let oldName = change?[.oldKey] as? String {
                print("Old name: \(oldName)")
            }
        }
    }
    
    
    deinit {
        person.removeObserver(self, forKeyPath: #keyPath(Person.name))
    }


}

class Person: NSObject {
    @objc dynamic var name: String = ""
    
    func changeName() {
        name = "changeName"
    }
    
    /// 直接为成员变量赋值
    func changeName2() {
        willChangeValue(forKey: "name")
        name = "changeName2"
        didChangeValue(forKey: "name")
    }
}


