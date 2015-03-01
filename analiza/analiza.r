# # 4. faza: Analiza podatkov
# 
# # Uvozimo funkcijo za uvoz spletne strani.
# source("lib/xml.r")
# 
# # Preberemo spletno stran v razpredelnico.
# cat("Uvažam spletno stran...\n")
# tabela <- preuredi(uvozi.obcine(), obcine)
# 
# # Narišemo graf v datoteko PDF.
# cat("Rišem graf...\n")
# pdf("slike/naselja.pdf", width=6, height=4)
# plot(tabela[[1]], tabela[[4]],
#      main = "Število naselij glede na površino občine",
#      xlab = "Površina (km^2)",
#      ylab = "Št. naselij")
# dev.off()


pdf("slike/internationalplayers.pdf")

leto <- ANA2$SEZONA - 2000
ply <- ANA2$TUJCI

plot(leto, ply, xlab = "Leto", ylab = "Tuji igralci v NBA", main = "Naraščanje števila tujcev v ligi NBA")
legend(4.5, 102, c("Linearna", "Kvadratna"), lty=c(1,1), col = c("blue","red"))

#Napišem funkcijo za linearno rast

linearna <- lm(ply ~ leto)
abline(linearna, col="blue")

#Napišem funkcijo za kvadratno rast

kvadratna <- lm(ply ~ I(leto^2) + leto)
curve(predict(kvadratna, data.frame(leto=x)), add = TRUE, col = "red")  

#Loess model za primerjavo (model loess uporablja lokalno prilagajanje)

loess <- loess(ply ~ leto)

#Pogledamo ostanke pri modelih. Tisti, ki ima manjši ostanek je bolj natančen

vsota.kvadratov <- sapply(list(linearna, kvadratna, loess), function(x) sum(x$residuals^2))

dev.off()



#Narisali bomo napoved za rast števila tujcev v NBA za linearni in kvadratni model

pdf("slike/napoved.pdf")

plot(ANA2$SEZONA, ply, xlim = c(2005, 2030), ylim = c(50, 150), 
     xlab = "Leto", ylab = "Tuji igralci v NBA",
     main = "Predvidena rast števila tujcev v ligi NBA po različnih modelih")     
abline(h = 120,col = "black", lwd = 1.5, lty = 1)

#Presečišča izračunamo na roko

points(2028.950332, 120,  col = "black", pch = 21)
points(2016.57562, 120,  col = "black", pch = 21)

#V presečiščih potegnemo navpične črte

abline(v=2028.950332, col = "magenta", lty = 1)
abline(v=2016.57562, col = "magenta", lty = 1)


napoved <- function(x,model){predict(model, data.frame(leto=x-2000))}

curve(napoved(x, linearna), add= TRUE, lwd = 1.5, col = "blue")
curve(napoved(x, kvadratna), add = TRUE, lwd = 1.5, col = "red")

#Narišemo še legendo

legend(2004, 65, c("Linearna (lm(pop ~ leto))", "Kvadratna (lm(pop ~ I(leto^2) + leto))",
                    "120 tujcev"),
       lty=c(1,1), col = c("blue","red", "black"))

dev.off()


pdf("slike/analiza.pdf")

plot(ANA1$YEAR, ANA1$W, type = "l", col = "red", lwd = 3.6, xlab = "Leto", ylab = "Zmage",
     main = "Podatki za ekipo Phoenix Suns - korelacija med spremenljivkami")
lines(ANA1$YEAR, ANA1$REB, col = "blue")
abline(h = ANA1$W, lty = "dotted", col = "grey")
abline(v = ANA1$YEAR, lty = "dotted", col = "grey")
lines(ANA1$YEAR, 2* ANA1$AST, col = "green")
lines(ANA1$YEAR, 2* ANA1$TOV, col = "orange")
lines(ANA1$YEAR, ANA1$PTS / 3, col = "cyan")
legend("topright",
       legend=c("Zmage", "Skoki", "Asistence", "Napake","Točke"),
       col=c("red","blue","green","orange","cyan"),
       title="Legenda",
       lwd = c(5, 5, 5, 5, 5, 5),
       bg = "white")

dev.off()


pdf("slike/hierarhija1.pdf")

X <- scale(as.matrix(NBA2))
t <- hclust(dist(X), method = "ward.D")

plot(t, hang=-1, cex=0.4, main = "Športna uspešnost ekip")

legend("topright", 
       c("Skupina 1", "Skupina 2","Skupina 3"),
       lty=c(1,1,1), col = c("red","blue","green"))

rect.hclust(t,k=3,border=c("blue","green","red"))

p1 <- cutree(t, k=3)

dev.off()



pdf("slike/hierarhija2.pdf")

Y <- scale(as.matrix(place[1]))
z <- hclust(dist(Y), method = "ward.D")

plot(z, hang=-1, cex=0.4, main = "Izdatki za plače")

legend("topright", 
       c("Skupina 1", "Skupina 2","Skupina 3"),
       lty=c(1,1,1), col = c("red","blue","green"))

rect.hclust(z,k=3,border=c("red","blue","green"))

p2 <- cutree(z, k=3)

dev.off()


# V tem delu bom preveril, kateri izmed igralcev je bil najbolj koristen kar se košev tiče, glede na to, kako dolgo je preživel na parketu.
# Torej učinkovitost igralcev.

pdf("slike/indeksphx.pdf")

povprecje <- apply(phoenix, 1, function(x) x[20]/x[2])
phoenix$indeks <- povprecje

priimki <- gsub("^.* ", "", rownames(phoenix))
barplot(phoenix$indeks, las = 2, cex.names = 0.65,
        ylab = "Dane točke / minutaža",
        ylim = c(0,1),
        names.arg = priimki, col = "orange",
        main = "Učinkovitost posameznega igralca ekipe PHX Suns")

dev.off()

pdf("slike/dendogram1.pdf")

barve1 = c("red", "green", "blue")
XX <- scale(as.matrix(phoenix[c(2,20,21)]))
e1 <- hclust(dist(XX), method = "ward.D")
p1 <- cutree(e1, k=3)
pairs(XX, col = barve1[p1])

plot(e1, hang=-1, cex=0.4, main = "Razdelitev igralcev v skupine glede na minute in točke")
rect.hclust(e1,k=3,border=c("red","blue","green"))
legend("topright", 
       c("Skupina 1", "Skupina 2","Skupina 3"),
       lty=c(1,1,1), col = c("red","blue","green"))
dev.off()