# # 3. faza: Izdelava zemljevida
# 
# # Uvozimo funkcijo za pobiranje in uvoz zemljevida.
# source("lib/uvozi.zemljevid.r")
# 
# # Uvozimo zemljevid.
# cat("Uvažam zemljevid...\n")
# obcine <- uvozi.zemljevid("http://e-prostor.gov.si/fileadmin/BREZPLACNI_POD/RPE/OB.zip",
#                           "obcine", "OB/OB.shp", mapa = "zemljevid",
#                           encoding = "Windows-1250")
# 
# # Funkcija, ki podatke preuredi glede na vrstni red v zemljevidu
# preuredi <- function(podatki, zemljevid) {
#   nove.obcine <- c()
#   manjkajo <- ! nove.obcine %in% rownames(podatki)
#   M <- as.data.frame(matrix(nrow=sum(manjkajo), ncol=length(podatki)))
#   names(M) <- names(podatki)
#   row.names(M) <- nove.obcine[manjkajo]
#   podatki <- rbind(podatki, M)
#   
#   out <- data.frame(podatki[order(rownames(podatki)), ])[rank(levels(zemljevid$OB_UIME)[rank(zemljevid$OB_UIME)]), ]
#   if (ncol(podatki) == 1) {
#     out <- data.frame(out)
#     names(out) <- names(podatki)
#     rownames(out) <- rownames(podatki)
#   }
#   return(out)
# }
# 
# # Preuredimo podatke, da jih bomo lahko izrisali na zemljevid.
# druzine <- preuredi(druzine, obcine)
# 
# # Izračunamo povprečno velikost družine.
# druzine$povprecje <- apply(druzine[1:4], 1, function(x) sum(x*(1:4))/sum(x))
# min.povprecje <- min(druzine$povprecje, na.rm=TRUE)
# max.povprecje <- max(druzine$povprecje, na.rm=TRUE)
# 
# # Narišimo zemljevid v PDF.
# cat("Rišem zemljevid...\n")
# pdf("slike/povprecna_druzina.pdf", width=6, height=4)
# 
# n = 100
# barve = topo.colors(n)[1+(n-1)*(druzine$povprecje-min.povprecje)/(max.povprecje-min.povprecje)]
# plot(obcine, col = barve)
# 
# dev.off()

###########################

# Uvozimo funkcijo za pobiranje in uvoz zemljevida.
source("lib/uvozi.zemljevid.r")

# Uvozimo zemljevid.
cat("Uvažam zemljevid...\n")
USA <- uvozi.zemljevid("http://biogeo.ucdavis.edu/data/gadm2/shp/USA_adm.zip",
                          "USA", "USA_adm1.shp", mapa = "zemljevid",
                          encoding = "Windows-1250")


# Funkcija, ki podatke preuredi glede na vrstni red v zemljevidu
preuredi <- function(podatki, zemljevid) {
  nove.USA <- c()
  manjkajo <- ! nove.USA %in% rownames(podatki)
  M <- as.data.frame(matrix(nrow=sum(manjkajo), ncol=length(podatki)))
  names(M) <- names(podatki)
  row.names(M) <- nove.USA[manjkajo]
  podatki <- rbind(podatki, M)
  
  out <- data.frame(podatki[order(rownames(podatki)), ])[rank(levels(zemljevid$NAME_1)[rank(zemljevid$NAME_1)]), ]
  if (ncol(podatki) == 1) {
    out <- data.frame(out)
    names(out) <- names(podatki)
    rownames(out) <- rownames(podatki)
  }
  return(out)
}

#Hočemo dobiti le sklenjeni del ZDA, brez teritorialnih območij po svetu, ki so v lasti ZDA
nocemo <- c("Alaska", "Hawaii", "Puerto Rico", "U.S. Virgin Islands")
usa.states <- USA[!(USA$NAME_1 %in% nocemo),]
usa.states$NAME_1 <- factor(usa.states$NAME_1)

# Narišimo zemljevid v PDF.
cat("Rišem zemljevid...\n")
pdf("slike/USA.pdf")

plot(usa.states)
sanantonio <- nbacities$capital =="San Antonio" #Zmagovalna ekipa sezone 13/14
points(coordinates(nbacities[c("long", "lat")]),
       pch = ifelse(sanantonio, 19, 19),
       cex = ifelse(sanantonio, 0.8, 0.6),
       col = ifelse(sanantonio, "gold", "orange"))

#Spremenjene koordinate in imena za ameriška mesta
koordinate <- coordinates(nbacities[c("long", "lat")])
imena <- as.character(nbacities$capital)
rownames(koordinate) <- imena
names(imena) <- imena
koordinate["Sacramento",1] <- koordinate["Sacramento",1] + 1.5
koordinate["Golden State",1] <- koordinate["Golden State",1] + 0.5
koordinate["San Antonio",1] <- koordinate["San Antonio",1] - 1.4
koordinate["Miami",1] <- koordinate["Miami",1] + 1
koordinate["New Orleans",2] <- koordinate["New Orleans",2] - 0.6
koordinate["New Orleans",1] <- koordinate["New Orleans",1] + 0.3
koordinate["Washington",1] <- koordinate["Washington",1] -1.7
koordinate["Philadelphia",1] <- koordinate["Philadelphia",1] + 2.3
koordinate["Los Angeles",2] <- koordinate["Los Angeles",2] -0.3
koordinate["New York",1] <- koordinate["New York",1] + 1.5
koordinate["Toronto",2] <- koordinate["Toronto",2] + 1.5
koordinate["Detroit",2] <- koordinate["Detroit",2] + 1.5
koordinate["Boston",1] <- koordinate["Boston",1] + 2.8
koordinate["Boston",2] <- koordinate["Boston",2] + 1.4
imena["Los Angeles"] <- "Los\nAngeles"
imena["San Antonio"] <- "San\nAntonio"

text(koordinate,labels=imena,cex=0.6, pos = 1, offset = 0.2,col = "grey")

dev.off()

# usstates <- c(nbacities$state)
# stevilo <- NBA$W
# stevilo <- stevilo[order(stevilo)]
# barve <- rgb(0, 1, 0, match(usstates, stevilo)/length(usstates))
# names(barve) <- names(drzave)
# plot(USA, col = barve[as.character(USA$STATE_1)])


#zemljevid 2 
# Narišimo zemljevid v PDF.
cat("Rišem zemljevid...\n")
pdf("slike/USAwin.pdf")

usa.states$WHOME <- zmage$WHOME
usa.states$WAWAY <- zmage$WAWAY

k <- 2 #faktor povečave - da bo dovolj barv
max.homewin <- k*max(usa.states$WHOME)
max.awaywin <- k*max(usa.states$WAWAY)
barve <- heat.colors(max.homewin)[max.homewin:1]
print(spplot(usa.states, "WHOME", col.regions = barve))
print(spplot(usa.states, "WAWAY", col.regions =
               barve[1:max.awaywin]))

dev.off()




# contiguous.states$ekipe <- c(1:7, rep(NA, 42)) # tukaj seveda podaš dejanske podatke
# 
# 
# spplot(contiguous.states, "ekipe", col.regions = topo.colors(100),
#        col = "white")
# 
# spplot(contiguous.states, 2, col.regions=rainbow(16))
# 
# contiguous.states$WHOME <- zmage$WHOME
# spplot(contiguous.states, "WHOME", col.regions = topo.colors(100))

###

# usa.states$W <- zmage$W
# usa.states$NAME_1 <- levels(usa.states$NAME_1)


# m <- match(usa.states$NAME_1, rownames(zmage))
# pop <- zmage[m,1] # podatki o zmagah v 1. stolpcu
# n <- 10 # 6 kategorije
# q <- quantile(pop, (1:n)/n, na.rm = TRUE)
# barve <- topo.colors(n)
# plot(usa.states, col = barve[sapply(pop, function(x) which(x <= q)[1])])
