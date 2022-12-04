import Foundation

public protocol FileLoading {
    func loadFile<T: LosslessStringConvertible>(name: String, withExtension: String, year: String, omittingEmptySubsequences: Bool) -> [T?]
    func loadFile<T: LosslessStringConvertible>(name: String, withExtension: String, year: String) -> [T]
    func loadFileAsString(name: String, withExtension: String, year: String) -> String
}

extension FileLoading {
    public func loadFile<T: LosslessStringConvertible>(
        name: String = #function,
        withExtension: String = "",
        year: String = #filePath,
        omittingEmptySubsequences: Bool = true
    ) -> [T?] {
        guard
            let url = fileURL(name: name, withExtension: withExtension, year: year),
            let string = try? String(contentsOf: url)
        else {
            return []
        }
        
        return string
            .split(separator: "\n", omittingEmptySubsequences: omittingEmptySubsequences)
            .map(String.init)
            .map(T.init)
    }
    
    public func loadFile<T: LosslessStringConvertible>(
        name: String = #function,
        withExtension: String = "",
        year: String = #filePath
    ) -> [T] {
        loadFile(name: name, withExtension: withExtension, year: year)
            .compactMap { $0 }
    }
    
    public func loadFileAsString(
        name: String = #function,
        withExtension: String = "txt",
        year: String = #filePath
    ) -> String {
        guard
            let url = fileURL(name: name, withExtension: withExtension, year: year),
            let string = try? String(contentsOf: url)
        else {
            return ""
        }
        
        return string
    }

    private func fileURL(name: String, withExtension: String, year: String) -> URL? {
        let bundle = Bundle(for: CurrentBundle.self)
        let fileManager = FileManager.default
        
        guard
            let resourceURL = bundle.resourceURL?.absoluteURL,
            let enumerator = fileManager.enumerator(at: resourceURL, includingPropertiesForKeys: nil)
        else { return nil }
        
        // last 4 are the `_X()` where X is the challenge part indicator
        let file = name.dropLast(4) + (withExtension.isEmpty ? "" :  "." + withExtension)
        var yearPath = year.split(separator: "/")
        let year = yearPath.remove(at: yearPath.count - 2)
        let filename = year + "/" + file
        
        var fileURL: URL?
        while let url = enumerator.nextObject() as? URL {
            if url.path.contains(filename) {
                fileURL = url
            }
        }

        return fileURL
    }
}

private class CurrentBundle { }
