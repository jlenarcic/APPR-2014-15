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

uvoziBDP <- function() {
  return(read.table("podatki/BDP.csv", sep = ";", as.is = TRUE,
                    row.names = 1,
                    col.names = c("leto", "SLOVENIJA", "Zahodna Slovenija", "Obalno-kraška", "Goriška",
                                  "Gorenjska", "Osrednjeslovenska", "Vzhodna Slovenija", "Notranjsko-kraška",
                                  "Jugovzhodna Slovenija", "Spodnjeposavska", "Zasavska", "Savinjska",
                                  "Koroška", "Podravska", "Pomurska"),
                    skip = 1,
                    fileEncoding = "Windows-1250"))
}
cat("Uvažam podatke o BDP na prebivalca v posameznih slovenskih regijah...\n")
BDP <- uvoziBDP()


# Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih
# fazah.