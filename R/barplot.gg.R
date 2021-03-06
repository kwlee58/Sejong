barplot.gg <-
function(x, position, font.family = "", ggtitle = "", xlab = ""){
  switch(position,
         stack = barplot.gg.stack(x, font.family = font.family, ggtitle = ggtitle, xlab = xlab),
         dodge = barplot.gg.dodge(x, font.family = font.family, ggtitle = ggtitle, xlab = xlab),
         fill = barplot.gg.fill(x,  font.family = font.family, ggtitle = ggtitle, xlab = xlab))
}
barplot.gg.stack <-
function(df, font.family = "", ggtitle = "", xlab = ""){
x <- df[, 2]
y <- unlist(tapply(df$Freq, x, cumsum))
b1 <- ggplot(df, aes(x = x, y = Freq, fill = vote)) +
  geom_bar(stat = "identity", position = "stack")
b2 <- b1 +
  theme_bw(base_family = font.family) + 
  scale_x_discrete(name = xlab) +
  scale_y_continuous(name = "집계", breaks = NULL) +
  scale_fill_manual(name = "찬반", values = rainbow(2)[2:1], guide = guide_legend(reverse = TRUE))
b3 <- b2 +
  geom_text(aes(y = y/2), label = format(df$Freq, big.mark = ","), position = position_stack()) +
  ggtitle(ggtitle)
return(b3)
}
barplot.gg.dodge <-
function(df, font.family = "", ggtitle = "", xlab = ""){
x <- df[, 2]
y <- unlist(tapply(df$Freq, x, cumsum))
b1 <- ggplot(df, aes(x = x, y = Freq, fill = vote)) +
  geom_bar(stat = "identity", position = "dodge")
b2 <- b1 +
  theme_bw(base_family = font.family) + 
  scale_x_discrete(name = xlab) +
  scale_y_continuous(name = "집계", breaks = NULL) +
  scale_fill_manual(name = "찬반", values = rainbow(2)[2:1])
b3 <- b2 +
  geom_text(aes(y = df$Freq/2), label = format(df$Freq, big.mark = ","), position = position_dodge(width = 0.9)) +
  ggtitle(ggtitle)
return(b3)
}
barplot.gg.fill <-
function(df, font.family = "", ggtitle = "", xlab = ""){
x <- df[, 2]
y <- unlist(tapply(df$Freq, x, function(x){cumsum(x)/sum(x)}))
b1 <- ggplot(df, aes(x = x, y = Freq, fill = vote)) +
  geom_bar(stat = "identity", position = "fill")
b2 <- b1 +
  theme_bw(base_family = font.family) +
  scale_x_discrete(name = xlab) +
  scale_y_continuous(name = "집계", breaks = NULL) +
  scale_fill_manual(name = "찬반", values = rainbow(2)[2:1], guide = guide_legend(reverse = TRUE))
b3 <- b2 +
  geom_text(aes(y = y/2), label = format(df$Freq, big.mark = ","), position = position_stack()) +
  ggtitle(ggtitle)
return(b3)
}
