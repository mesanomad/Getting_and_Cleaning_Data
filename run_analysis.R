#Section 1
activity_labels <- read.table("activity_labels.txt")
subject_test <- read.table("subject_test.txt")
x_test <- read.table("X_test.txt")
y_test <- read.table("y_test.txt")
subject_train <- read.table("subject_train.txt")
x_train <- read.table("X_train.txt")
y_train <- read.table("y_train.txt")
features <- read.table("features.txt")

#Section 2
colnames(y_test ) <- "Activity"
colnames(y_train) <- "Activity"
colnames(subject_test) <- "Subject"
colnames(subject_train) <- "Subject" 

#Section 3
features_only <- select(features, -V1)
new_row1 <- data.frame(V2 = "Subject")
new_row2 <- data.frame(V2 = "Activity")
new_row3 <- data.frame(V2 = "Group")
features_only2 <-rbind(new_row3, features_only)
features_only3 <-rbind(new_row2, features_only2)
features_only4 <-rbind(new_row1, features_only3)

#Section 4
bind1 <- bind_cols(subject_test, x_test)
bind2 <- bind_cols(subject_train, x_train)
bind3 <- bind_cols(bind1, y_test) 
bind3.1 <- bind3[, c(1, 563, 2:562)]
bind3.2 <- mutate(bind3.1, Group = "Test")
bind3.3 <- bind3.2[, c(1:2, 564, 3:563)]
bind4 <- bind_cols(bind2, y_train)
bind4.1 <- bind4[, c(1, 563, 2:562)]
bind4.2 <- mutate(bind4.1, Group = "Train")
bind4.3 <- bind4.2[, c(1:2, 564, 3:563)]
bind3.3_df <- as.data.frame(bind3.3)
names(bind3.3_df) <- features_only4$V2
names(bind4.3) <- features_only4$V2
all_data <- rbind(bind3.3_df, bind4.3)

#Section 5
valid_column_names <- make.names(names=names(all_data), unique=TRUE, allow_ = TRUE)
names(all_data) <- valid_column_names
std_mean_data <- select(all_data, Subject, Activity, Group, contains("mean"), contains("std"))


#Section 6
std_mean_data$Activity <- factor(std_mean_data$Activity, levels = c(1, 2, 3, 4, 5, 6), labels = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))

#Section 7
data_melt <- melt(std_mean_data,id = c("Subject", "Activity", "Group"), measure.vars  = c(4:89))
subj_data <- dcast(data_melt, Subject ~ variable, mean)
activity_data <- dcast(data_melt, Activity ~ variable, mean)
merged_data <- merge(subj_data, activity_data, all = TRUE)
final_dataset <- merged_data[, c(87:88, 1:86)]
tidy_data <- final_dataset[order(final_dataset$Subject),]

View(tidy_data)