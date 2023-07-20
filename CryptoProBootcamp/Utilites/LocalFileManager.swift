//
//  LocalFileManager.swift
//  CryptoProBootcamp
//
//  Created by Kasharin Mikhail on 19.07.2023.
//

import SwiftUI

class LocalFileManager {
    
    static let instance = LocalFileManager()
    init() {}
    
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        
        // create folder
        createFolderIfNeeded(folderName: folderName)
        
        // get path for image
        guard
            let data = image.pngData(),
            let url = getUrlFromImage(imageName: imageName, folderName: folderName)
        else { return }
        
        // save image to path
        do {
            try data.write(to: url)
        } catch (let error) {
            print("Error saving image. Image name \(imageName).\(error.localizedDescription)")
        }
        
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard
            let url = getUrlFromImage(imageName: imageName, folderName: folderName),
              FileManager.default.fileExists(atPath: url.path)
        else { return nil }
        
        return UIImage(contentsOfFile: url.path)
    }
    
    // создаем папку для хранения
    private func createFolderIfNeeded(folderName: String) {
        guard let url = getUrlFromFolder(folderName: folderName) else { return }
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            } catch let error {
                print("Error create directory. Folder name: \(folderName). \(error.localizedDescription)")
            }
        }
    }
    
    // URL для папки в которую будем сохранять изображение
    private func getUrlFromFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        return url.appendingPathComponent(folderName, conformingTo: .image)
    }
    
    // получаем URL изображения в FileManager
    private func getUrlFromImage(imageName: String, folderName: String) -> URL? {
        guard let folderUrl = getUrlFromFolder(folderName: folderName) else { return nil}
        
        return folderUrl.appendingPathComponent(imageName + ".png", conformingTo: .image)
    }
    
}
