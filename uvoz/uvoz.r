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
colnames(NBA1) <- c("GP","W","L","W%","MIN","FGM","FGA","FG%",
                    "3PM","3PA","3P%","FTM","FTA","FT%","OREB",
                    "DREB","REB","AST","TOV","STL","BLK","BLKA",
                    "PFC","PFD","PTS","+/-")

#DODATEN STOLPEC 1 (Razvrstil sem ekipe glede na število zmag v 4 kategorije)
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

#DODATEN STOLPEC 2 (Zvezne države)
uvozidrzave <- function() {
  return(read.table("podatki/usstates.csv", sep = ";", as.is = TRUE,
                    header = TRUE,
                    fileEncoding = "Windows-1250"))
}
cat("Uvažam podatke o zveznih drzavah... \n")
drzave <- uvozidrzave()

NBASTATES <- data.frame(NBA, drzave)

#TABELA 2 (Statistični podatki za vse ekipe v sezoni 13/14, ko so le te igrale v gosteh)
uvoziNbaRoadSeason <- function() {
  return(read.table("podatki/NbaRoadSeason.csv", sep = ";", as.is = TRUE,
                    header = TRUE,
                    fileEncoding = "Windows-1250"))
}
cat("Uvažam podatke o ekipah, ki so se uvrstile v končnico... \n")
NbaRoadSeason <- uvoziNbaRoadSeason()
colnames(NbaRoadSeason) <- c("GP","W","L","W%","MIN","FGM","FGA","FG%",
                    "3PM","3PA","3P%","FTM","FTA","FT%","OREB",
                    "DREB","REB","AST","TOV","STL","BLK","BLKA",
                    "PFC","PFD","PTS","+/-")


#TABELA 3 (Podatki za igralce ekipe Phoenix Suns v tekmovalnem letu 2013/2014)
uvoziphoenix <- function() {
  return(read.table("podatki/phoenix.csv", sep = ";", as.is = TRUE,
                    header = TRUE,
                    row.names = 1,
                    fileEncoding = "Windows-1250"))
}
cat("Uvažam podatke o igralcih ekipe Phoenix Suns za sezono 13/14... \n")
phoenix <- uvoziphoenix()
colnames(phoenix) <- c("GP","MIN","FGM","FGA","FG%",
                    "3PM","3PA","3P%","FTM","FTA","FT%","OREB",
                    "DREB","REB","AST","TOV","STL","BLK",
                    "PFC","PTS","+/-")

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

#DODATEK3 (Stolpec s  podatki o igralnem mestu za posameznega igralca)
uvozinationality <- function() {
  return(read.table("podatki/nationality.csv", sep = ";", as.is = TRUE,
                    header = TRUE,
                    fileEncoding = "Windows-1250"))
}
cat("Uvažam podatke o pozicijah... \n")
nationality <- uvozinationality()

PHOENIX2 <- data.frame(PHOENIX1, nationality)

#DODATNA TABELA - KOORDINATE AMERIŠKIH MEST (koordinate ameriških mest, kjer se igra liga NBA)
uvozinbacities <- function() {
  return(read.table("podatki/nbacities.csv", sep = ",", as.is = TRUE,
                    header = TRUE,
                    fileEncoding = "Windows-1250"))
}
cat("Uvažam podatke o mestih... \n")
nbacities <- uvozinbacities()

#DODATNA TABELA 2
uvozizmage <- function() {
  return(read.table("podatki/zmage2.csv", sep = ";", as.is = TRUE,
                    header = TRUE,
                    row.names = 1,
                    fileEncoding = "Windows-1250"))
}
cat("Uvažam podatke o zmagah... \n")
zmage <- uvozizmage()

#Podatki, ki jih potrebujem v tretji fazi (za divizije)
uvozipodatke <- function() {
  return(read.table("podatki/uscapitals.csv", sep = ",", as.is = TRUE,
                    header = TRUE,
                    row.names = 1,
                    fileEncoding = "Windows-1250"))
}
cat("Uvažam podatke... \n")
usa3 <- uvozipodatke()

attach(usa3)
divizije <- c("Atlantic", "Central", "Southeast", "Northwest", "Pacific", "Southwest")
div1 <- character(nrow(usa3))
div1[rownames(usa3) == "Massachusetts"] <- "Atlantic"
div1[rownames(usa3) == "Pennsylvania"] <- "Atlantic"
div1[rownames(usa3) == "New York"] <- "Atlantic"
div1[rownames(usa3) == "Illinois"] <- "Central"
div1[rownames(usa3) == "Ohio"] <- "Central"
div1[rownames(usa3) == "Wisconsin"] <- "Central"
div1[rownames(usa3) == "Indiana"] <- "Central"
div1[rownames(usa3) == "Michigan"] <- "Central"
div1[rownames(usa3) == "Georgia"] <- "Southeast"
div1[rownames(usa3) == "District of Columbia"] <- "Southeast"
div1[rownames(usa3) == "Florida"] <- "Southeast"
div1[rownames(usa3) == "North Carolina"] <- "Southeast"
div1[rownames(usa3) == "Oregon"] <- "Northwest"
div1[rownames(usa3) == "Oklahoma"] <- "Northwest"
div1[rownames(usa3) == "Colorado"] <- "Northwest"
div1[rownames(usa3) == "Utah"] <- "Northwest"
div1[rownames(usa3) == "Minnesota"] <- "Northwest"
div1[rownames(usa3) == "California"] <- "Pacific"
div1[rownames(usa3) == "Arizona"] <- "Pacific"
div1[rownames(usa3) == "Texas"] <- "Southwest"
div1[rownames(usa3) == "Louisiana"] <- "Southwest"
div1[rownames(usa3) == "Tennessee"] <- "Southwest"
conference <- factor(div1, levels = divizije, ordered = TRUE)
detach(usa3)

usa4 <- data.frame(usa3, conference)
usa4$vote.2012 <- NULL
usa4$electoral.votes <- NULL
# Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih
# fazah.


#TE TABELE SEM UVOYIL V 4. FAZI
#TABELA 1 -> (4. faza) (Podatki za ekipo Phoenix Suns za obdobje petih let - le določene spremenljivke)
uvozianaliza1 <- function() {
  return(read.table("podatki/analiza1.csv", sep = ";", as.is = TRUE,
                    header = TRUE,
                    fileEncoding = "Windows-1250"))
}
cat("Uvažam podatke ... \n")
ANA1 <- uvozianaliza1()

#TABELA 2 -> (4. faza) (Število tujcev po sezonah v ligi NBA)
uvozianaliza2 <- function() {
  return(read.table("podatki/analiza2.csv", sep = ";", as.is = TRUE,
                    header = TRUE,
                    fileEncoding = "Windows-1250"))
}
cat("Uvažam podatke ... \n")
ANA2 <- uvozianaliza2()


uvoziigralci <- function() {
  return(read.table("podatki/placeigralcev.csv", sep = ";", as.is = TRUE,
                    header = TRUE,
                    row.names = 1,
                    fileEncoding = "Windows-1250"))
}
cat("Uvažam podatke o vseh ekipah... \n")
place <- uvoziigralci()
colnames(place) <- c("Salary")

uvoziNBA2 <- function() {
  return(read.table("podatki/NBA2.csv", sep = ";", as.is = TRUE,
                    header = TRUE,
                    row.names = 1,
                    fileEncoding = "Windows-1250"))
}
cat("Uvažam podatke o vseh ekipah... \n")
NBA2 <- uvoziNBA2()
colnames(NBA2) <- c("W","FG%",
                    "3P%","FT%","REB","AST","STL","BLK","BLKA",
                    "PTS","+/-", "DIVISION")
NBA2$DIVISION <- NULL
