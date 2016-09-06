//
//  Finder.swift
//  Finder
//
//  Created by Дмитрий Козлов on 16/08/16.
//  Copyright © 2016 LinO_dska. All rights reserved.
//

import Foundation

extension String {
  var fileName: String {
    get {
      return (self as NSString).lastPathComponent
    }
    set {
      let s1 = (self as NSString).stringByDeletingLastPathComponent
      self = (s1 as NSString).stringByAppendingPathComponent(newValue)
    }
  }
  var fileExtension: String {
    get {
      return (self as NSString).pathExtension
    }
    set {
      let s1 = (self as NSString).stringByDeletingPathExtension
      self = (s1 as NSString).stringByAppendingPathExtension(newValue)!
    }
  }
  mutating func removeFileExtension() {
    self = (self as NSString).stringByDeletingPathExtension
  }
}

private let manager = NSFileManager.defaultManager()
var finderClipboard = [String]()
class Finder {
  var path: String = documents
  var autocreateFolders: Bool = false
  var autocreateFiles: Bool = false
  var selected: Set<File> = []
  
  func back() {}
  func open(name: String) throws {}
  func remove(name: String) {}
  func createFile(name: String) {}
  func createFolder(name: String) {}
  
  func go(path: String) {}
  
  func action(action: String) {
    let keys = Set(action.componentsSeparatedByString("+"))
    if keys.contains("select") {
      
    }
  }
  
  func select(name: String) throws -> File {
    let file = File(path: name)
    selected = [file]
    return file
  }
  func shiftSelect(name: String) {
    let file = File(path: name)
    if selected.contains(file) {
      selected.remove(file)
    } else {
      selected.insert(file)
    }
  }
  func selectAll() {
    let files = list(files: true, folders: true)
    for path in files {
      let file = File(path: path)
    }
  }
  
  func copy() {}
  func paste() {}
  
  func deselect() {}
  
  func list(files files: Bool, folders: Bool) -> [String] {
    
  }
  func files() -> [String] {}
  func exists(path: String) -> Bool {
    return manager.fileExistsAtPath(self.path+path)
  }
  func isDirectory(path: String) -> Bool {
    var a: ObjCBool = false
    manager.fileExistsAtPath(self.path+path, isDirectory: &a)
    return Bool(a)
  }
}

func ==(l:File,r:File)->Bool{return l.path==r.path}
class File: Hashable {
  var hashValue: Int { return path.hashValue }
  var path: String
  init(path: String) {
    self.path = path
  }
  func open() -> NSData? {
    return NSData(contentsOfFile: path)
  }
}

var documents = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first! + "/"
var temp = NSTemporaryDirectory()
var cache = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first! + "/"