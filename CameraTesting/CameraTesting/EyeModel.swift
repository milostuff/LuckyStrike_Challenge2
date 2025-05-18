//
//  EyeModel.swift
//  CameraTesting
//
//  Created by mrvl on 16/05/25.
//
import SwiftUI

enum DiseaseDescription: String, CaseIterable {
    case Glaucoma = "Glaucoma is a group of eye conditions that affect the optic nerve and can cause vision loss."
    case Cataract = "A cataract is a clouding of the lens in the eye that can cause vision loss."
    case DiabeticRetinopathy = "Diabetic retinopathy is a complication of diabetes that damages the blood vessels in the retina."
    case BlurredVision = "Blurred vision can be caused by various factors such as age-related macular degeneration, dry eye, or eye strain."
    case MacularDegeneration = "Macular degeneration is a group of eye conditions that affect the macula, the central part of the retina responsible for sharp vision."
}

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
    @Published var eyeDisease:EyeDisease = EyeDisease.Glaucoma
    @Published var severity:Severity = Severity.Early
    var description: String {
        switch eyeDisease {
        case .Glaucoma: return DiseaseDescription.Glaucoma.rawValue
        case .Cataract: return DiseaseDescription.Cataract.rawValue
        case .DiabeticRetinopathy: return DiseaseDescription.DiabeticRetinopathy.rawValue
        case .BlurredVision: return DiseaseDescription.BlurredVision.rawValue
        case .MacularDegeneration: return DiseaseDescription.MacularDegeneration.rawValue
        }
    } 
}
