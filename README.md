# Analiza podatkov s programom R, 2014/15

Avtor: Jakob Lenarčič

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2014/15.

## Tematika

V mojem projektu se bom ukvarjal s podrobno analizo posameznih regij znotraj Slovenije. Predvsem se bom osredotočil na gospodarsko razvitost regij, torej regionalni BDP na prebivalca, stopnja brezposelnosti, povprečna plača, število podjetij znotraj regije, prometna povezanost, raven izobrazbe. Zanimala me bo tudi gostota poseljenosti in kriminaliteta.

Vse te podatke bom nato skrbno analiziral in ugotavljal v kolikšni meri se med seboj prepletajo (npr. ali je stopnja kriminalitete odvisna od stopnje brezposelnosti). Moj cilj je prav tako, da ugotovim, katere regije spadajo med najbolj razvite, katere se najhitreje razvijajo, katere so nad oz. pod slovenskim povprečjem glede BDP na prebivalca. Kar se tiče razvoja skozi čas bom vzel interval nekaj let (npr. od vstopa Slovenije v EU do danes) in pogledal, kakšni so trendi pri posameznih spremenljivkah.

Vse podatke za moj projekt bom dobil iz spletne strani Statističnega urada Republike Slovenije.
Podatki po statističnih regijah (http://pxweb.stat.si/pxweb/Database/Regije/Regije.asp).







## Program

Glavni program se nahaja v datoteki `projekt.r`. Ko ga poženemo, se izvedejo
programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`. Podatkovni
viri so v mapi `podatki/`. Slike, ki jih program naredi, se shranijo v mapo
`slike/`. Zemljevidi v obliki SHP, ki jih program pobere, se shranijo v mapo
`zemljevid/`.

## Poročilo

Poročilo se nahaja v mapi `porocilo/`. Za izdelavo poročila v obliki PDF je
potrebno datoteko `porocilo/porocilo.tex` prevesti z LaTeXom. Pred tem je
potrebno pognati program, saj so v poročilu vključene slike iz mape `slike/`.
