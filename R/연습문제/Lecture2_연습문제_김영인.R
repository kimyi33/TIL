# Excercise 1
data1 <- mpg %>% select(class,cty)
data1

# Excercise 2
suv_cty <- data1 %>% filter(class=="suv")
cpt_cty <- data1 %>% filter(class=="compact")
mean(suv_cty$cty) #13.5
mean(cpt_cty$cty) #20.12766

# Excercise 3
audi <- mpg %>% filter(manufacturer=="audi")
audi %>% arrange(desc(hwy)) %>% head(5)

# Excercise 4
library(ggplot2)
head(midwest)
tail(midwest)
View(midwest)
dim(midwest)
str(midwest)
summary(midwest)

# Excercise 5
midwest <- rename(midwest, total=poptotal)
midwest <- rename(midwest, asian=popasian)

# Excercise 6
midwest$ratio <- 100 * midwest$asian/midwest$total
View(midwest)
hist(midwest$ratio)

# Excercise 7
mean_ratio <- mean(midwest$ratio) # 0.4872462
midwest$densAsian <- ifelse(midwest$ratio >= mean_ratio, "large", "small")

# Excercise 8
table(midwest$densAsian)

library(ggplot2)
qplot(midwest$densAsian)