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
contiguous.states <- USA[!(USA$NAME_1 %in% nocemo),]
contiguous.states$NAME_1 <- factor(contiguous.states$NAME_1)

# Narišimo zemljevid v PDF.
cat("Rišem zemljevid...\n")
pdf("slike/USA.pdf")

plot(contiguous.states)
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
koordinate["Washington",1] <- koordinate["Washington",1] -1.3
koordinate["Philadelphia",1] <- koordinate["Philadelphia",1] + 1.7
koordinate["Los Angeles",2] <- koordinate["Los Angeles",2] -0.3
koordinate["New York",1] <- koordinate["New York",1] + 1.5
koordinate["Toronto",2] <- koordinate["Toronto",2] + 1.5
imena["Los Angeles"] <- "Los\nAngeles"
imena["San Antonio"] <- "San\nAntonio"

text(koordinate,labels=imena,cex=0.6, pos = 1, offset = 0.2,col = "black")

dev.off()
