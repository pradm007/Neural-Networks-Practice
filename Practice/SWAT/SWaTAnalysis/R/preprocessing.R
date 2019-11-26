# Read data from 2 files ... Normal and Attack
swatNormal = read.csv("SWaT_Dataset_Normal_v0.csv", header = TRUE)
swatAttack = read.csv("SWaT_Dataset_Attack_v0.csv", header = TRUE)

# Extract only those rows which has correct spelling of Attack
swatAttack_attack = subset(swatAttack, Normal.Attack == "Attack")

# Extract only those rows which has incorrect spelling of A ttack
swatAttack_attackWronglyWritten = subset(swatAttack, Normal.Attack == "A ttack")

# Update the spelling with Attack for the wrongly written cells
for (i in seq_along(swatAttack_attackWronglyWritten)) {
  swatAttack_attackWronglyWritten[[i,53]] = "Attack"
}

# Merge all the data. This is our clean data now.
swat_train = rbind(swatNormal, swatAttack_attack, swatAttack_attackWronglyWritten)

# Remove rows with NA value
swat_train = na.omit(swat_train)

# Shuffle the data set because currently all the attacks are in bottom and normal on top.
swat_train_shuffled = swat_train[sample(nrow(swat_train)), ]

# Separate data set into 4 files: 2 for training and 2 for validation
totalTrainingRowCount_mini07 = as.integer(.07 * nrow(swat_train_shuffled))
totalTrainingRowCount_mini = as.integer(.20 * nrow(swat_train_shuffled))
totalTrainingRowCount = as.integer(.90 * nrow(swat_train_shuffled))
totalValidationRowCount = nrow(swat_train_shuffled) - totalTrainingRowCount

# Insert dataId as fixed index value
swat_train_shuffled$index = seq.int(nrow(swat_train_shuffled))

# Further separate data set into X and Y sets for training and validation using loss functions
swat_Y = subset(swat_train_shuffled, select = c("index", "Normal.Attack"))
swat_X = subset(swat_train_shuffled, select = -c(Normal.Attack))

# Separate data for training and validation
# swat_train_X90 = swat_X[1:totalTrainingRowCount, ]
# swat_train_Y90 = swat_Y[1:totalTrainingRowCount, ]

swat_train_07 = swat_train_shuffled[1:totalTrainingRowCount_mini07, ]

swat_train_X07 = swat_X[1:totalTrainingRowCount_mini07, ]
swat_train_Y07 = swat_Y[1:totalTrainingRowCount_mini07, ]

# swat_train_X20 = swat_X[1:totalTrainingRowCount_mini, ]
# swat_train_Y20 = swat_Y[1:totalTrainingRowCount_mini, ]
#
# swat_validation_X = tail(swat_X, totalValidationRowCount)
# swat_validation_Y = tail(swat_Y, totalValidationRowCount)

# Write everything to a file.
# write.csv(swat_train_X90, "swat_train_X90.csv")
# write.csv(swat_train_Y90, "swat_train_Y90.csv")
#

write.csv(swat_train_07, "swat_train_07.csv")

# write.csv(swat_train_X07, "swat_train_X07.csv")
# write.csv(swat_train_Y07, "swat_train_Y07.csv")

# write.csv(swat_train_X20, "swat_train_X20.csv")
# write.csv(swat_train_Y20, "swat_train_Y20.csv")
#
# write.csv(swat_validation_X, "swat_validation_X.csv")
# write.csv(swat_validation_Y, "swat_validation_Y.csv")
