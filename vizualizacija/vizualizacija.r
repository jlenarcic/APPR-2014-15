# # 3. faza: Izdelava zemljevida
 
# Uvozimo funkcijo za pobiranje in uvoz zemljevida.
source("lib/uvozi.zemljevid.r")

# Uvozimo zemljevid.
cat("Uvažam zemljevid...\n")
# USA <- uvozi.zemljevid("http://biogeo.ucdavis.edu/data/gadm2/shp/USA_adm.zip",
#                           "USA", "USA_adm1.shp", mapa = "zemljevid",
#                           encoding = "Windows-1250")

USA <- uvozi.zemljevid("http://baza.fmf.uni-lj.si/states_21basic.zip",
                       "USA", "states.shp", mapa = "zemljevid")

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

# ZEMLJEVID 1 (Na njem so grafično prikazana mesta, v katerih se igra liga NBA)

#Hočemo dobiti le sklenjeni del ZDA, brez teritorialnih območij po svetu, ki so v lasti ZDA
nocemo <- c("Alaska", "Hawaii", "Puerto Rico", "U.S. Virgin Islands")
usa.states <- USA[!(USA$STATE_NAME %in% nocemo),]
usa.states$NAME_1 <- factor(usa.states$STATE_NAME)

# Narišimo zemljevid v PDF.
cat("Rišem zemljevid...\n")
pdf("slike/USAcities.pdf")

plot(usa.states,
     border = "grey",
     col = ifelse(usa4[as.character(usa.states$NAME_1),
                                   "conference"] == "Atlantic", "lightpink1",
                              ifelse(usa4[as.character(usa.states$NAME_1),
                                          "conference"]== "Central","lightskyblue2",
                                     ifelse(usa4[as.character(usa.states$NAME_1),
                                                 "conference"] == "Southeast", "lightsteelblue4",
                                            ifelse(usa4[as.character(usa.states$NAME_1),
                                                        "conference"] == "Northwest", "lightcyan3",
                                                   ifelse(usa4[as.character(usa.states$NAME_1),
                                                               "conference"] == "Pacific", "lightcoral",
                                                          ifelse(usa4[as.character(usa.states$NAME_1),
                                                                      "conference"] == "Southwest", "lightgoldenrod","white")))))))

title("Mesta, kjer se igra liga NBA")
sanantonio <- nbacities$capital =="San Antonio" #Zmagovalna ekipa sezone 13/14
points(coordinates(nbacities[c("long", "lat")]),
       pch = ifelse(sanantonio, 19, 19),
       cex = ifelse(sanantonio, 0.8, 0.6),
       col = ifelse(sanantonio, "gold", "orange"))

legend("topright",
       legend=c("Atlantic", "Central", "Southeast", "Northwest","Pacific","Southwest"),
       col=c("lightpink1","lightskyblue2","lightsteelblue4","lightcyan3","lightcoral","lightgoldenrod"),
       lty = c("solid", "solid", "solid", "solid","solid","solid"),
       title="Division",
       lwd = c(10, 10, 10, 10, 10, 10),
       bg = "white")

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
koordinate["Washington",1] <- koordinate["Washington",1] -2.5
koordinate["Philadelphia",1] <- koordinate["Philadelphia",1] + 3.1
koordinate["Los Angeles",2] <- koordinate["Los Angeles",2] -0.3
koordinate["New York",1] <- koordinate["New York",1] + 1.5
koordinate["Toronto",2] <- koordinate["Toronto",2] + 1.5
koordinate["Detroit",2] <- koordinate["Detroit",2] + 1.5
koordinate["Boston",1] <- koordinate["Boston",1] + 2.8
koordinate["Boston",2] <- koordinate["Boston",2] + 1.4
koordinate["Orlando",1] <- koordinate["Orlando",1] + 2.8
imena["Los Angeles"] <- "Los\nAngeles"
imena["San Antonio"] <- "San\nAntonio"

text(koordinate,labels=imena,cex=0.6, pos = 1, offset = 0.2,col = "black")

dev.off()

# ZEMLJEVID 2 (Podatki o domačih in gostujočih zmagah po zveznih državah. Bolj obarvana območja
# so bila bolj uspešna v tekmovalni sezoni 13/14 in obratno.)

zmage <- preuredi(zmage, usa.states)
usa.states$WHOME <- zmage$WHOME
usa.states$WAWAY <- zmage$WAWAY

# Narišimo zemljevid v PDF.
cat("Rišem zemljevid2...\n")
pdf("slike/USAstats.pdf")

k <- 2 #faktor povečave - da bo dovolj barv
max.homewin <- k*max(usa.states$WHOME, na.rm = TRUE)
max.awaywin <- k*max(usa.states$WAWAY, na.rm = TRUE)
max.win <- max(max.homewin, max.awaywin)
barve <- heat.colors(max.win)[max.win:1]
print(spplot(usa.states, "WHOME", col.regions = barve[1:max.homewin], main = "Število domačih zmag v sezoni 13/14 po zveznih državah"))
print(spplot(usa.states, "WAWAY", col.regions = barve[1:max.awaywin], main = "Število gostujočih zmag v sezoni 13/14 po zveznih državah"))

dev.off()
