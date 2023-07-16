//
//  CoinRowView.swift
//  CryptoProBootcamp
//
//  Created by Kasharin Mikhail on 15.07.2023.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: CoinModel
    let showHoldingColumn: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            leftColumn
            
            Spacer()
            
            if showHoldingColumn {
                centerColumn
            }
            
            rightColumn
        }
        .font(.subheadline)
    }
}

extension CoinRowView {
    private var leftColumn: some View {
        HStack(spacing: 0) {
            Text(coin.rank.formatted())
                .font(.caption)
                .foregroundColor(.theme.secondaryText)
                .frame(minWidth: 30)
            /*
            AsyncImage(url: URL(string: coin.image)) { phase in
                switch phase {
                case .success(let image): // само изображение
                    image.resizable().scaledToFit().frame(width: 30, height: 30)
                case .empty: // кейс отвечающий за знак загрузки
                    ProgressView()
                case .failure(_): // если изображение не загрузилось
                    Image(systemName: "questionmark")
                        .font(.headline)
                default:
                    Image(systemName: "questionmark")
                        .font(.headline)
                }
            }
            */
            Circle()
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(.theme.accent)
        }
    }
    
    private var centerColumn: some View {
            VStack(alignment: .trailing) {
                Text(coin.currentHoldingsValue.asCurrencyWith2Decimal())
                    .bold()
                Text((coin.currentHoldings ?? 0).asNumberString())
            }
            .foregroundColor(.theme.accent)
    }
    
    private var rightColumn: some View {
        VStack(alignment: .trailing) {
            /*
            используем расширение для типа Double чтобы перевести из дабла в стринг со знаком доллара и форматом вывода с запятой
            */
            Text(coin.currentPrice.asCurrencyWith6Decimal())
                .bold()
                .foregroundColor(.theme.accent)
            /*
            также используем расширения Double для отображения числа с двумя знаками после запятой и символом процента
            */
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundColor(
                    (coin.priceChangePercentage24H ?? 0) <= 0
                                 ? .theme.red
                                 : .theme.green
                )
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinRowView(coin: dev.coin, showHoldingColumn: true)
                .previewLayout(.sizeThatFits)
            
            CoinRowView(coin: dev.coin, showHoldingColumn: true)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
