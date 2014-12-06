# Analiza podatkov s programom R, 2014/15

Avtor: Jakob Lenarčič

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2014/15.

## Tematika

V mojem projektu se bom ukvarjal s podrobno analizo NBA ekip v sezoni 2013/2014. Za vsako ekipo me bo zanimalo število zmag in porazov, povprečno število košev na tekmo in druge spremenljivke. Nekatere bom dodal sam (npr. ali je igralec v moštvu dober strelec; kriterij za dobrega strelca pa bo recimo več kot 20 točk na tekmo). Primerjal bom dve statistični spremenljivki, in sicer povprečno število košev na tekmo in število zmag. Podatke za vsako ekipo bom primerjal s podatki za ostale ekipe in na podlagi tega sklepal, ali je ekipa svoj uspeh gradila na čvrsti obrambi ali na zaneslivem napadu. Na podlagi vsake statistične spremenljivke bom ekipe razvrstil od najboljše do najslabše, nato pa bom ugotavljal, katere pozitivno vplivajo na njihovo uspešnost.
Prav tako bom uvozil še eno podobno tabelo. Razlikovala pa se bo v tem, da bodo na tej le podatki za tekme v gosteh. Ti dve tabeli bom med seboj primerjal, saj me bo zanimalo, v kakšni meri vpliva kraj tekme (doma, v gosteh) na uspešnost ekipe.
V drugem delu projekta pa se bom osredotočil na NBA ekipo Phoenix Suns. Zanimali me bosta predvsem dve spremenljivki, in sicer strelska uspešnost in povprečnen čas, ki ga igralec preživi na parketu. Ti dve   spremenljivki mi bosta v pomoč pri ugotavljanju, kateri izmed igralcev je bil najučinkovitejši glede na minutažo.
Cilj projekta je analiziranje in obdelava podatkov na konkretnem primeru S programom R ter pridobitev novih znanj na področju statistične obdelave podatkov.

Vse podatke za moj projekt bom pridobil iz naslednjih spletnih strani:
http://stats.nba.com/league/team/#!/?Season=2013-14
http://stats.nba.com/league/team/#!/?Season=2013-14&Location=Road
http://stats.nba.com/team/#!/1610612756/players/?Season=2013-14




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
