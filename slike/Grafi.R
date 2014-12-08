pdf("slike/Grafi.pdf", paper="a4r")
#Graf1
barplot(phoenix$PTS, las = 2, cex.names = 0.65,
        ylab = "Povprečje točk na tekmo",
        ylim = c(0,25),
        names.arg = rownames(phoenix), col = "orange",
        main = "Povprečno število točk na tekmo za posameznega igralca.")

#Graf2
barplot(NBA1[1:5,"W"], ylim = c(0,82), ylab = "Število zmag", col = rainbow(5), xlab = "Ekipe", las = 2, main = "Število zmag v sezoni 2013/2014",
        cex.names = 0.8, legend.text = rownames(NBA1[1:5,]))

dev.off()