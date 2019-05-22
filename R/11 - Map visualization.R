# 11-1 Making Choropleth Map on USArrests by states
library(ggiraphExtra)

str(USArrests)
head(USArrests)

library(tibble)

crime <-rownames_to_column(USArrests, var = "state")
crime

crime$state <-tolower(crime$state)
str(crime)

# Preparing the US map
library(ggplot2)
#install.packages("maps")
library(maps)
states_map <- map_data("state")
str(states_map)

#install.packages("mapproj")
library(mapproj)
ggChoropleth(data = crime,
             aes(fill = Murder,
                 map_id = state),
             map = states_map)

ggChoropleth(data = crime,
             aes(fill = Murder,
                 map_id = state),
             map = states_map,
             interactive = T)

# 11-2 Census statistics in South Korea with map data
#install.packages("devtools")
#install_github("cardiomoon/kormaps2014")

library(devtools)
library(kormaps2014)
library(dplyr)

# `korpop`을 확인해봅니다.
# 한글이 깨지는 경우에 `changeCode`를 사용하세요.
str(changeCode(korpop1))

# 변수명을 한글로 그대로 사용하면, 깨지는 현상이 발생하므로 `rename` 합니다.
korpop1 <- rename(korpop1,
                  pop = 총인구_명,
                  name = 행정구역별_읍면동)

# `kormap1`을 확인해봅니다.
str(changeCode(kormap1))

# Making Choropleth Map on population by region
ggChoropleth(data=korpop1,      # 지도에 표시할 데이터
             aes(fill = pop,    # 색깔로 표현할 변수
                 map_id=code,   # 지역 기준 변수
                 tooltip=name), # 지도 위에 표시할 지역명
             map=kormap1,       # 지도 데이터
             interactive = T)

# Making Choropleth Map on NewPts by region
str(changeCode(tbc))
ggChoropleth(data = tbc,
             aes(fill = NewPts,
                 map_id = code,
                 tooltip = name),
             map = kormap1,
             interactive = T)