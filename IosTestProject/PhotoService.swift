//
//  PhotoService.swift
//  IosTestProject
//
//  Created by sazzad on 1/27/17.
//  Copyright © 2017 Dynamic Solution Innovators. All rights reserved.
//

import Foundation
import Photos

class PhotoService {
    
    
    /**
     Retrieve an album from the Photos app with a specified name. If no such album exists, creates and returns a new one.
     
     - parameter named:      Name of the album.
     - parameter completion: Called in the background when an album was retrieved.
     */
    func getAlbum(name named: String,  completion: @escaping (_ album: PHAssetCollection?) -> ()) {
        DispatchQueue.global(qos: .background).async {
            let fetchOptions = PHFetchOptions()
            fetchOptions.predicate = NSPredicate(format: "title = %@", named)
            let collections = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
            
            
            DispatchQueue.main.async {
                if let album = collections.firstObject {
                    completion(album)
                    
                } else {
                    self.createAlbum(name: named, completion: {
                        album in
                        completion(album)
                    })
                }
            }
        }
        
        
    }
    
    /**
     Create and return an album in the Photos app with a specified name. Won't overwrite if such an album already exist.
     
     - parameter named:      Name of the album.
     - parameter completion: Called in the background when an album was created.
     */
    func createAlbum(name: String, completion: @escaping (_ album: PHAssetCollection?) -> ()) {
        DispatchQueue.global(qos: .background).async {
            var album: PHAssetCollection?
            var placeholder: PHObjectPlaceholder?
            PHPhotoLibrary.shared().performChanges({
                let createAlbumRequest = PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: name)
                placeholder = createAlbumRequest.placeholderForCreatedAssetCollection
            }, completionHandler: {
                success, error in
                if success {
                    let collectionFetchResult = PHAssetCollection.fetchAssetCollections(
                        withLocalIdentifiers: [placeholder?.localIdentifier ?? ""], options: nil)
                    album = collectionFetchResult.firstObject
                }
            })
            DispatchQueue.main.async {
                completion(album)
            }
        }
    
    }
    
    /**
     Try to save an image to a Photos album with a specified name. If no such album exists, creates a new one.
     - Important: The `error` parameter is only forwarded from the framework, if the image fails to save due to other reasons, even if the error is `nil` look at the `success` parameter which will be set to `false`.
     
     - parameter image:      Image to save.
     - parameter named:      Name of the album.
     - parameter completion: Called in the background when the image was saved or in case of any error.
     */
    func saveImage(image : UIImage, toAlbum named: String, completion: @escaping (_ success: Bool, _ error: Error?) -> ()){
        getAlbum(name: named, completion: {
            album in
            guard let album = album else {
                completion(false,nil)
                return
            }
            self.saveImage(image: image, to: album, completion: {
                success , error in
                if success {
                    print("image save successful")
                } else {
                    print(error.debugDescription)
                }
            })
            
        })
    }
    
    
    
    /**
     Try to save an image to a Photos album.
     - Important: The `error` parameter is only forwarded from the framework, if the image fails to save due to other reasons, even if the error is `nil` look at the `success` parameter which will be set to `false`.
     
     - parameter image:      Image to save.
     - parameter completion: Called in the background when the image was saved or in case of any error.
     */
    func saveImage(image: UIImage, to album: PHAssetCollection, completion: @escaping (_ success: Bool, _ error: Error?) -> ()) {
        DispatchQueue.global(qos: .background).async {
            PHPhotoLibrary.shared().performChanges({
                let assetRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
                let placeHolder = assetRequest.placeholderForCreatedAsset
                guard let _placeHolder = placeHolder else {
                    completion(false, nil)
                    return
                }
                let albumChangeRequest = PHAssetCollectionChangeRequest(for: album)
                let enumeration: NSArray = [_placeHolder]
                albumChangeRequest?.addAssets(enumeration)
                
            }, completionHandler: {
                success , error in
                if success {
                    print("image save successful")
                } else {
                    print(error.debugDescription)
                }
            })
            
            DispatchQueue.main.async {
                print("done")
            }
        }
        
    }
    
    

    
}
































