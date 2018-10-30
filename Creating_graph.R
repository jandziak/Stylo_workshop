# Installing packages
install.packages("networkD3")
install.packages("dplyr")
install.packages("FNN")

library("networkD3")
library("dplyr")
library("FNN")

# Graph combo! 

# Labels creation 
rownames(df)
labels <- as.character(sapply(strsplit(rownames(df), '_'), function(x) x[1]))
novel <- rownames(df)

#' Visualization of the graph of "neighbours" 
#' Data with counts is required for thois part in the skill_to_count variable
#' additionally one should set the threshold for 
#' min number of neighbours 
#' max number of neighbours
#' threshold for valid connection
min_n <- 1
k <- 6
threshold <- 1
graph_train <- df
graph_train$cluster <- labels
graph_train$novel <- novel
#' Feel skills for which tere is no counts
graph_train[is.na(graph_train)] <- 0

neigh <- get.knn(graph_train[,1:301], k)
neighbours <- data.frame(from = rep(1:nrow(graph_train), rep(k, nrow(graph_train))), 
                         to = as.vector(t(neigh$nn.index)), 
                         dist = as.vector(t(neigh$nn.dist)),
                         number = rep(1:k, nrow(graph_train)))

# Calculating KNN


neighbours <- neighbours %>% filter(dist <= threshold | number <= min_n) #%>% summarize(n())

MisLinks <- neighbours
MisLinks$from <- MisLinks$from - 1
MisLinks$to <- MisLinks$to - 1
MisLinks$simmilarity <- (1 - MisLinks$dist)
MisNodes <- data.frame(node_ID = graph_train$novel, cluster = graph_train$cluster)

forceNetwork(Links = MisLinks, Nodes = MisNodes, Source = "from",
             Target = "to", Value = "simmilarity", NodeID = "node_ID",
             Group = "cluster", opacity = 1, zoom = T,  opacityNoHover = TRUE,
             fontSize = 20)#, Nodesize = "size")


