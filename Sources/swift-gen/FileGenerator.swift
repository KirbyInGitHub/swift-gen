//
//  FileGenerator.swift
//  swift-gen
//
//  Created by Arror on 2019/5/26.
//

import Foundation

class FileGenerator {
    
    private let enumGenerator: EnumGenerator
    private let structGenerator: StructGenerator
    private let serviceGenerator: ServiceGenerator
    
    init(thrift: TThrift) {
        self.enumGenerator = EnumGenerator(enums: thrift.enums.map { $0.value })
        self.structGenerator = StructGenerator(structs: thrift.structs.map { $0.value })
        self.serviceGenerator = ServiceGenerator(services: thrift.services.map { $0.value })
    }
    
    func generateFile(scope: Scope, printer p: inout CodePrinter) {
        self.generateFileHeader(printer: &p)
        self.enumGenerator.generateThriftEnums(scope: .client, printer: &p)
        self.structGenerator.generateThriftStructs(scope: .client, printer: &p)
        self.serviceGenerator.generateThriftService(scope: .client, printer: &p)
    }
    
    private func generateFileHeader(printer p: inout CodePrinter) {
        p.print("//\n")
        p.print("// Code generated by thrift & swift-gen.\n")
        p.print("// Don't edit manually.\n")
        p.print("//\n")
        p.print("\n")
        p.print("import Foundation\n")
        p.print("import RTSession\n")
        p.print("\n")
    }
}
