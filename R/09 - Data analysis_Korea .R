library(foreign)
library(dplyr)
library(ggplot2)
library(readxl)

raw_welfare <- read.spss(file = "Koweps_hpc10_2015_beta1.sav", to.data.frame = T)
welfare <- raw_welfare
welfare <- rename(welfare,
                  sex = h10_g3,            # 성별
                  birth = h10_g4,          # 태어난 연도
                  marriage = h10_g10,      # 혼인 상태
                  religion = h10_g11,      # 종교
                  income = p1002_8aq1,     # 월급
                  code_job = h10_eco9,     # 직종 코드
                  code_region = h10_reg7)

## 성별에 따른 월급차이
class(welfare$sex)
table(welfare$sex)
welfare$sex <- ifelse(welfare$sex == 1, "male", "female")
table(welfare$sex)
qplot(welfare$sex)

# 월급
# 범위 : 1~9998
# 모름/무응답 : 9999
class(welfare$income)
summary(welfare$income)
welfare$income <- ifelse(welfare$income %in% c(0, 9999), NA, welfare$income)
table(is.na(welfare$income))

# 성별에 따른 평균 월급
sex_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(sex) %>%
  summarise(mean_income = mean(income))

sex_income
ggplot(data = sex_income, aes(x = sex, y = mean_income)) + geom_col()

## 나이와 월급의 관계
# birth : 태어난 연도
# 범위 : 1900~2014
#모름/무응답 : 9999
class(welfare$birth)
summary(welfare$birth)
qplot(welfare$birth)
table(is.na(welfare$birth))

welfare$birth <- ifelse(welfare$birth == 9999, NA, welfare$birth)
table(is.na(welfare$birth))

# '나이' 추가
welfare$age <- 2019 - welfare$birth + 1
summary(welfare$age)
qplot(welfare$age)

# 나이에 따른 평균 월급
age_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(age) %>%
  summarise(mean_income = mean(income))
head(age_income)
ggplot(data = age_income, aes(x = age, y = mean_income)) + geom_line()

## 연령대(ageg)에 따른 월급차이
# 연령대 ageg 파생변수 추가
welfare <- welfare %>%
  mutate(ageg = ifelse(age <30, "young",
                       ifelse(age <= 59, "middle", "old")))
table(welfare$ageg)
qplot(welfare$ageg)

# ageg에 따른 평균 월급 항목 추가
ageg_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(ageg) %>%
  summarise(mean_income = mean(income))

ageg_income
ggplot(data = ageg_income, aes(x = ageg, y = mean_income)) + geom_col()

# 범주 순서를 정하여 시각화 하기 "scale_x_discrete"
ggplot(data = ageg_income, aes(x = ageg, y = mean_income)) +
  geom_col() +
  scale_x_discrete(limits = c("young", "middle","old"))

## 연령대 및 성별 월급 차이
# 성별과 나이대에 따른 평균 월급
sex_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(ageg, sex) %>%
  summarise(mean_income = mean(income))

sex_income
ggplot(data = sex_income, aes(x = ageg, y = mean_income, fill = sex)) +
  geom_col() +
  scale_x_discrete(limits = c("young", "middle", "old"))

# 막대를 분리하여 비교하기 "dodge"
ggplot(data = sex_income, aes(x = ageg, y = mean_income, fill = sex)) +
  geom_col(position = "dodge") +
  scale_x_discrete(limits = c("young", "middle", "old"))

# 나이 및 성별 월급 평균표 만들기
sex_age <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(age, sex) %>%
  summarise(mean_income = mean(income))
head(sex_age)
ggplot(data = sex_age, aes(x = age, y = mean_income, col = sex)) + geom_line()

## 직업별 월급 차이
# 직종코드 정보에 따라 직업 정보 추가하기 
class(welfare$code_job)
table(welfare$code_job)

library(readxl)
list_job <- read_excel("Koweps_Codebook.xlsx", col_names = T, sheet = 2)
head(list_job)
dim(list_job)

welfare <- left_join(welfare, list_job, id = "code_job")

welfare %>%
  filter(!is.na(code_job)) %>%
  select(code_job, job) %>%
  head(10)

# 직업에 따른 평균 월급 
job_income <- welfare %>%
  filter(!is.na(income) & !is.na(income)) %>% 
  group_by(job) %>% 
  summarise(mean_income = mean(income))

head(job_income)

# 상위 10개 추출
top10 <- job_income %>%
  arrange(desc(mean_income)) %>% 
  head(10)

top10

# 그래프 만들기
ggplot(data = top10,
       aes(x=reorder(job,mean_income),
           y=mean_income)) +
  geom_col() +
  coord_flip()

# 하위 10개 추출
bottom10 <- job_income %>% 
  arrange(mean_income) %>% 
  head(10)

bottom10

# 그래프 만들기
ggplot(data = bottom10, aes(x = reorder(job, -mean_income),
                            y = mean_income)) +
  geom_col() +
  coord_flip() +
  ylim(0, 850)

## 성별 직업 빈도
# 남성 직업 빈도 상위 10개 추출
job_male <- welfare %>%
  filter(!is.na(job) & sex=="male") %>%
  group_by(job) %>%
  summarise(job_num = n()) %>% 
  arrange(desc(job_num)) %>% 
  head(10)

job_male

# 여성 직업 빈도 상위 10개 추출
job_female <- welfare %>%
  filter(!is.na(job) & sex=="female") %>%
  group_by(job) %>%
  summarise(job_num = n()) %>% 
  arrange(desc(job_num)) %>% 
  head(10)

job_female

# 그래프 만들기
ggplot(data = job_male,
       aes(x=reorder(job, job_num),
           y=job_num)) +
  geom_col() +
  coord_flip()

ggplot(data = job_female,
       aes(x=reorder(job, job_num),
           y=job_num)) +
  geom_col() +
  coord_flip()

## 종교 유무에 따른 이혼율
