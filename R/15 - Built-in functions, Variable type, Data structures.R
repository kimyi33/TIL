### 15-1. Extractubg data using Built-in Functions

exam <- read.csv("Data/csv_exam.csv")

# Extracting Rows
exam[2,]
exam[exam$class == 1,] # == exam %>% filter(class == 1)
exam[exam$math >= 80,]
exam[exam$class == 2 & exam$english >=70,]
exam[exam$english <90 | exam$science <50,]

# Extracting Columns
exam[,1]
exam[,"id"]
exam[,c(2,3)]
exam[,c("class","math")]

# Extracting elements
exam[1,3]
exam[5,"math"]
exam[exam$math >= 50, c("english","science")]

# For students with "math>= 50, english >= 80",
# get the average value of the total score for each class.
# Using `dplyr`
exam %>%
  filter(math>=50 & english>=80) %>%
  mutate(tot = (math + english + science)/3) %>%
  group_by(class) %>% 
  summarise(mean=mean(tot))

# Using built-in function
exam$tot <- (exam$math + exam$english + exam$science)/3
aggregate(data = exam[exam$math>=50 & exam$english>=80,], tot ~ class, mean)

# `mpg` data, `dplyr` package
# class 중 compact와 suv 차종의 도시 및 고속도로
# 통합 연비에 대한 평균을 출력

mpg %>% 
  mutate(total = (cty + hwy)/2) %>%
  group_by(class) %>%
  summarise(mean = mean(total)) %>%
  filter(class =="compact" | class == "suv")

### 15-2. Variable Type
#1. Continuous Variable : Numeric type
#2. Categorical Variable : Factor type
#others. numeric, integer, complex, character, logical, factor, Date, ...

var1 <- c(1,2,3,1,2)
var2 <- factor(c(1,2,3,1,2))

var1 + 2
var2 + 2

class(var1)
class(var2)

levels(var1) #범주를 알려줌
levels(var2)

var3 <- c("a","b","b","c")
var4 <- factor(c("a","b","b","c"))
var3
var4

class(var3)
class(var4)

mean(var1)
mean(var2)

# Coercion Function
# as.numeric(), as.factor(), as.character(), as.Date(), as.data.frame(), ...
var2 <- as.numeric(var2)
mean(var2)
class(var2)
levels(var2)

# Excercise
class(mpg$drv)
class(as.factor(mpg$drv))
levels(as.factor(mpg$drv))

### 15-3. Data structures

#1. Vector(dim1/one-type)
a <- 1
a         
b <- "hello"
b

class(a)
class(b)

#2. Data Frame (dim2/multiple-type)
x1 <- data.frame(var1 = c(1,2,3),
                 var2 = c("a","b","c"))
x1
class(x1)

#3. Matrix (dim2/one-type)
x2 <- matrix(c(1:12), ncol = 2)
x2
class(x2)

#4. Array (multiple-dim/one-type)
x3 <- array(1:20, dim = c(2, 5, 2))
x3
class(x3)

#5. List (multiple-dim/multiple data structure)
x4 <-list(f1 = a,
          f2 = x1,
          f3 = x2,
          f4 = x3)
x4
class(x4)

# output of `boxplot()` == List
mpg <- ggplot2::mpg
x <- boxplot(mpg$cty)
x

x$stats[,1]
x$stats[,1][3]
x$stats[,1][2]
