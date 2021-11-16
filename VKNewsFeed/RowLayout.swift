//
//  RowLayout.swift
//  VKNewsFeed
//
//  Created by Дмитрий Межевич on 14.11.21.
//

import UIKit

protocol RowLayoutDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, photoAtIndexPath indexPath: IndexPath) -> CGSize
}

class RowLayout: UICollectionViewLayout {
    
    weak var delegate: RowLayoutDelegate!
    
    static var numbersOfRows = 2
    fileprivate var cellPadding: CGFloat = 8
    
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    
    fileprivate var contenWidth: CGFloat = 0
    fileprivate var contenHeight: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        
        let insets = collectionView.contentInset
        return collectionView.bounds.height - (insets.top + insets.bottom)
    }
    
    // MARK: - Переопределили св-во размера collectionView
    override var collectionViewContentSize: CGSize {
        CGSize(width: contenWidth, height: contenHeight)
    }
    
    // MARK: - Переопределили метод prepare, в котором высчитываем все размеры и позиции
    override func prepare() {
        contenWidth = 0
        cache = []
        guard cache.isEmpty, let collectionView = collectionView else { return }
        
        var photos = [CGSize]()
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let sizePhoto = delegate.collectionView(collectionView, photoAtIndexPath: indexPath)
            photos.append(sizePhoto)
        }
        
        let superviewWidth = collectionView.frame.width
        
        guard var rowHeight = RowLayout.rowHeightCounter(superviewWidth: superviewWidth, photosArray: photos) else { return }
        
        rowHeight /= CGFloat(RowLayout.numbersOfRows)
        
        let photoRatios = photos.map { $0.height / $0.width }
        
        var yOffset = [CGFloat]()
        for row in 0 ..< RowLayout.numbersOfRows {
            yOffset.append(CGFloat(row) * rowHeight)
        }
        
        var xOffset = [CGFloat](repeating: 0, count: RowLayout.numbersOfRows)
        
        var row = 0
        
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            let ratio = photoRatios[indexPath.row]
            let width = rowHeight / ratio
            let frame = CGRect(x: xOffset[row], y: yOffset[row], width: width, height: rowHeight)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attribute.frame = insetFrame
            cache.append(attribute)
            
            contenWidth = max(contenWidth, frame.maxX)
            xOffset[row] += width
            row = row < (RowLayout.numbersOfRows - 1) ? (row + 1) : 0
        }
    }
    
    // Вспомогательный метод для вычесления высоты collectionView на основе размеров всех фото
    static func rowHeightCounter(superviewWidth: CGFloat, photosArray: [CGSize]) -> CGFloat? {
        var rowHeight: CGFloat
        
        let photoWithMinRation = photosArray.min { first, second in
            (first.height / first.width) < (second.height / second.width)
        }
        guard let myPhotoWithMinRation = photoWithMinRation else { return nil }
        
        let difference = superviewWidth / myPhotoWithMinRation.width
        
        rowHeight = myPhotoWithMinRation.height * difference
        if photosArray.count < 4 {
            RowLayout.numbersOfRows = 1
        } else {
            RowLayout.numbersOfRows = 2
        }
        rowHeight *= CGFloat(RowLayout.numbersOfRows)
        return rowHeight
    }
    
    // MARK: - Переопределение методов возращающих атрибуты каждого элемента
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attribute in cache {
            if attribute.frame.intersects(rect) {
                visibleLayoutAttributes.append(attribute)
            }
        }
        
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        cache[indexPath.row]
    }
    
}
