# Install missing packages
install.packages("wordcloud") # word-cloud generator 
install.packages("RColorBrewer") # color palettes
library("wordcloud")
library("RColorBrewer")

# Ensure reproducibility
set.seed(1234)

wordcloud(words = names(df), freq = as.numeric(df[1,1:2543]), min.freq = 0.01,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))

wordcloud(words = names(df), freq = as.numeric(df[1,1:2543]), min.freq = -0.81,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(3, "Reds"),vfont=c("gothic english","plain"))