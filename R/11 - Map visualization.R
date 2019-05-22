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

# `korpop`�� Ȯ���غ��ϴ�.
# �ѱ��� ������ ��쿡 `changeCode`�� ����ϼ���.
str(changeCode(korpop1))

# �������� �ѱ۷� �״�� ����ϸ�, ������ ������ �߻��ϹǷ� `rename` �մϴ�.
korpop1 <- rename(korpop1,
                  pop = ���α�_��,
                  name = ����������_���鵿)

# `kormap1`�� Ȯ���غ��ϴ�.
str(changeCode(kormap1))

# Making Choropleth Map on population by region
ggChoropleth(data=korpop1,      # ������ ǥ���� ������
             aes(fill = pop,    # ����� ǥ���� ����
                 map_id=code,   # ���� ���� ����
                 tooltip=name), # ���� ���� ǥ���� ������
             map=kormap1,       # ���� ������
             interactive = T)

# Making Choropleth Map on NewPts by region
str(changeCode(tbc))
ggChoropleth(data = tbc,
             aes(fill = NewPts,
                 map_id = code,
                 tooltip = name),
             map = kormap1,
             interactive = T)