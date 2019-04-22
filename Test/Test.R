#1. asama icin yapilan dogruluk tablosunda

l = df$points >= 0 & df$price >5
summary(l) # puanladirma 0 dan buyuk ve fiyatlandirma 5 ten buyuk olacaklar

summary(l)
#V1
#Mode :logical
#FALSE:2982
#TRUE :18

summary(asil) # sonucu minimum 80 maximum 100 puanlandirma acisindan
# fiyat acisindan minimum 4.00 maximum 2300.00

parca <- 20/3 # fiyatlandirmayi tablonun birinci kismini ifade eden kisim icin
# parcaliyoruz.

firstpiece <- 100-parca
secondpiece <- firstpiece - parca
thirdpiece <- secondpiece - parca

l1 <- asil$points < firstpiece & asil$points > secondpiece
summary(l1)
#Mode   FALSE    TRUE
#logical   57624   93306

#> 57624/93306
#[1] 0.6175809 ### Butun verisetinin, 1. sinif sarap kisminin testi.
#> 2982/18
#[1] 165.6667
#> 18/2982
#[1] 0.006036217 ### Parcalanmis verisetinin, 1. sinif dogruluk orani

# Dogruluk orani 0.6175809/0.006036217
FirstClassWineAccuracyRatio <- 0.006036217/0.6175809
FirstClassWineAccuracyRatio
