library(stylo)
# Load corpus
raw.corpus <- load.corpus(files = 'all', corpus.dir = 'corpus', encoding = 'UTF-8')
# Summary of corpus files
summary(raw.corpus)
# Tokenization
tokenized.corpus <- txt.to.words.ext(raw.corpus, language = 'English.all', preserve.case = FALSE)
# Austin's Pride and Prejudice famous sentence
tokenized.corpus$Austen_Pride.txt[8:30]

# English pronouns
stylo.pronouns(language = 'English')

# Deleting unuseful words
corpus.no.pronouns <- delete.stop.words(tokenized.corpus, stop.words = stylo.pronouns(language = 'English'))

# Counting frequent features
frequent.features <- make.frequency.list(corpus.no.pronouns, head = 3000)
freqs <- make.table.of.frequencies(corpus.no.pronouns, features = frequent.features, relative = FALSE)
freqs <- make.table.of.frequencies(corpus.no.pronouns, features = frequent.features)

# Culling (words in at least 80% of samples)
culled.freqs <- perform.culling(freqs, culling.level = 80)

# Simple cluster analysis with stylo 
stylo(frequencies = culled.freqs, gui = FALSE)

# More options in stylo 
stylo(frequencies = culled.freqs, gui = FALSE, analysis.type = 'PCR', custom.graph.title = "PCA analysis for novels")



# Creating word clouds
nrows <- length(culled.freqs)/27
nrows
df <- as.data.frame(culled.freqs[1:27,1:2543])



