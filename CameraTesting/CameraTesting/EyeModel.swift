//
//  EyeModel.swift
//  CameraTesting
//
//  Created by mrvl on 16/05/25.
//
import SwiftUI

enum EyeDisease: String, CaseIterable {
    case Glaucoma = "Glaucoma"
    case Cataract = "Cataract"
    case DiabeticRetinopathy = "Diabetic Retinopathy"
    case BlurredVision = "Blurred Vision"
    case MacularDegeneration = "Macular Degeneration"
}

enum Severity: String, CaseIterable {
    case Early = "Early"
    case Middle = "Middle"
    case Late = "Late"
}

class EyeModel: ObservableObject
{
    @Published   var eyeDisease:EyeDisease = EyeDisease.Glaucoma
    @Published   var severity:Severity = Severity.Early
}
