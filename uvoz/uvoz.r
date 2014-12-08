# # 2. faza: Uvoz podatkov
# 
# # Funkcija, ki uvozi podatke iz datoteke druzine.csv
# uvoziDruzine <- function() {
#   return(read.table("podatki/druzine.csv", sep = ";", as.is = TRUE,
#                       row.names = 1,
#                       col.names = c("obcina", "en", "dva", "tri", "stiri"),
#                       fileEncoding = "Windows-1250"))
# }
# 
# # Zapišimo podatke v razpredelnico druzine.
# cat("Uvažam podatke o družinah...\n")
# druzine <- uvoziDruzine()

#TABELA 1 (Statistični podatki za vse ekipe v sezoni 13/14)
uvoziNBA1 <- function() {
  return(read.table("podatki/NBA1.csv", sep = ";", as.is = TRUE,
                    header = TRUE,
                    row.names = 1,
                    fileEncoding = "Windows-1250"))
}
cat("Uvažam podatke o vseh ekipah... \n")
NBA1 <- uvoziNBA1()


#DODATEN STOLPEC(Razvrstil sem ekipe glede na število zmag v 4 kategorije)
attach(NBA1)
moznosti <- c("Dobra ekipa", "Povprečna ekipa", "Slaba ekipa", "Zelo slaba ekipa", "Zelo dobra ekipa")
stolpec <- character(nrow(NBA1))
stolpec[W > 58] <- "Zelo dobra ekipa"
stolpec[W <= 50 & W > 35] <- "Povprečna ekipa"
stolpec[W > 50 & W <= 58] <- "Dobra ekipa"
stolpec[W > 20 & W <= 35] <- "Slaba ekipa"
stolpec[W <= 20] <- "Zelo slaba ekipa"
Status <- factor(stolpec, levels = moznosti, ordered = TRUE)
detach(NBA1)
NBA <- data.frame(NBA1, Status)

#TABELA 2 (Statistični podatki za vse ekipe v sezoni 13/14, ko so le te igrale v gosteh)
uvoziNbaRoadSeason <- function() {
  return(read.table("podatki/NbaRoadSeason.csv", sep = ";", as.is = TRUE,
                    header = TRUE,
                    fileEncoding = "Windows-1250"))
}
cat("Uvažam podatke o ekipah, ki so se uvrstile v končnico... \n")
NbaRoadSeason <- uvoziNbaRoadSeason()
View(NbaRoadSeason)

#TABELA 3 (Podatki za igralce ekipe Phoenix Suns v tekmovalnem letu 2013/2014)
uvoziphoenix <- function() {
  return(read.table("podatki/phoenix.csv", sep = ";", as.is = TRUE,
                    header = TRUE,
                    row.names = 1,
                    fileEncoding = "Windows-1250"))
}
cat("Uvažam podatke o igralcih ekipe Phoenix Suns za sezono 13/14... \n")
phoenix <- uvoziphoenix()


#DODATEK1 (Stolpec strelske učinkovitosti za igralce ekipe Phoenix Suns)
attach(phoenix)
moznosti <- c("Dober strelec", "Srednje dober strelec", "Slab strelec")
PHXtocke <- character(nrow(phoenix))
PHXtocke[PTS >= 15 ] <- "Dober strelec"
PHXtocke[PTS >= 5 & PTS < 15] <- "Srednje dober strelec"
PHXtocke[PTS < 5] <- "Slab strelec"
Natancnost <- factor(PHXtocke, levels = moznosti, ordered = TRUE)
detach(phoenix)
PHOENIX <- data.frame(phoenix, Natancnost)

#DODATEK2 (Stolpec s  podatki o igralnem mestu za posameznega igralca)
uvozipositions <- function() {
  return(read.table("podatki/positions.csv", sep = ";", as.is = TRUE,
                    header = TRUE,
                    fileEncoding = "Windows-1250"))
}
cat("Uvažam podatke o pozicijah... \n")
positions <- uvozipositions()

PHOENIX1 <- data.frame(phoenix, positions)

# Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih
# fazah.