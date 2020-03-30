library("dplyr")
library("rmatio")
library("RWeka")
library("caret")
library("RSNNS")
library("frbs")
library("FSinR")
library("forecast")

################################################################
#################### Function definition #######################
################################################################


feature_selection <- function(df, num_features = 100){
    # E := vectors of entorpies
    # E_k := entropy without Fk
    # d := distance
    # s := similarity
    # alpha := parameter
    E = c()
    d <- dist(df)
    alpha = -log(0.5)/mean(d)
    for (feature in names(df)){
        temp_df <- df %>% select(-feature)
        d <- dist(temp_df)
        s <- exp(-alpha*d)
        E_k <- -s*log2(s)-(1-s)*log2(1-s)
        E_k <- sum(E_k)
        E <- c(E, E_k)
    }
    feature_selected <- names(df)[order(E, decreasing = T)]
    feature_selected <- feature_selected[1:num_features]
    return(feature_selected)
}


################################################################
######################### Read data ############################
################################################################

cat("Reading data...\n")
temp_dat <- read.mat("stack_train.mat")
temp_names <- read.mat("variables.mat")
brain_data <- as.data.frame(temp_dat$data_train)
names(brain_data) <- temp_names$variables[[1]]
Class <- factor(temp_dat$labels,
                labels = c("HC", "MCI", "cMCI", "AD"))
rm(temp_dat)
rm(temp_names)

attach(brain_data)

brain_data2 <- as.data.frame(lapply(brain_data, scale))
# Discard useless features
brain_data2 <- brain_data2 %>% select(-GENDER,
                                      -AGE,
                                      -Left.WM.hypointensities, 
                                      -Right.WM.hypointensities, 
                                      -Left.non.WM.hypointensities, 
                                      -Right.non.WM.hypointensities)



################################################################
################### Hierarchical Clustering ####################
################################################################

# Initial parametres
k = 4
method = "ward.D2"
select_features = T
distance_metric = "manhattan"

# Feature selection
if (select_features){
    feature_selected <- feature_selection(brain_data2,
                                          num_features = 50)
    brain_data3 <- brain_data2 %>% select(feature_selected)
}else{
    brain_data3 <- brain_data2
}

# Compute clustering
hc=hclust(dist(brain_data3, method = distance_metric),
          method = method)
# Plot dendogram
png(filename="test_image.png")
par(mar = c(3,5,3,3))
plot(hc, labels = FALSE, 
     main = paste("Cluster dendogram using", method, "method"),
     xlab = "",
     sub = "")
dev.off()
cat("Check test_image.png\n")


################################################################
################### C4.5 tree to test RWeka ####################
################################################################
cat("Check RWeka...")
modelC4.5 = J48(Species~., data=iris)
modelC4.5.pred = predict(modelC4.5, iris[, 1:4])




