//
//  UserCardEntityExtension.swift
//  Cardfit
//
//  Created by 서동운 on 6/22/23.
//

import Foundation

extension UserCardEntity {
    func convertToCards() -> [Card] {
        guard let cardsSet = self.cards else { return [] }
        var cardEntities = [CardEntity]()
        
        guard let cardsArray = cardsSet.allObjects as? [CardEntity] else { return [] }
        
        for card in cardsArray {
            cardEntities.append(card)
        }
        
        let cards = cardEntities.map { cardEntity in
            let benefit = try? JSONDecoder().decode(Benefits.self, from: cardEntity.benefit ?? Data())
            return Card(id: Int(cardEntity.cardNumber!), cardName: cardEntity.cardName, cardNumber: cardEntity.cardNumber, cardImageURL: cardEntity.cardImageURL, imageData: cardEntity.imageData, domesticAnnualFee: cardEntity.domesticAnnualFee, requiredPreviousMonthUsage: cardEntity.requiredPreviousMonthUsage, mainBenefit: cardEntity.mainBenefit, company: cardEntity.company, benefit: benefit)
        }
        return cards
    }
}
