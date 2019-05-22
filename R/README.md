[TOC]

# Course Objectives

- 딥러닝을 위한 데이터베이스로서 SQL 명령어를 내릴 수 있다.
- 관리자가 알아야 할 SQL 부분은 필요하지 않다.

# Terminology

- **SQL** : Structured Query Language. 구조화 질의어.
  - ANSI SQL(표준), Oracle SQL, MS SQL 등이 있습니다.
  - 크게 ANSI와 오라클로 나뉜다고 보면 됩니다.
  - **CRUD** : 기본적인 데이터 처리 기능을 일컽는 말이다.
    - C = Create(생성)
    - R = Retrieve(검색) 또는 Read(읽기)
    - U = Update(수정)
    - D = Delete(삭제)

- **T-SQL** = Transaction SQL = (ANSI SQL) + (MS SQL의 부가기능)
- **SELECT Queries** : 데이터를 조회하는 명령어
- **Database** : Table들의 모임.
  - Excel에 비유하자면
    - Excel 파일 하나를 테이블 하나로 볼 수도 있고
    - Excel 시트 하나를 테이블로 볼 수도 있다.
  - BUT 자료의 집합이 Table만 있는 것은 아님.
- **Join** : Table 단위로 자료를 합치는 작업
- **Sorting** : 정렬
- **Filtering** : 기준을 주고, 그 기준에 부합하는 데이터만 뽑아냄.
- **Data type**
- **DML** : Data Manipulation Language. 데이터 조작 언어
- **Transaction**
  - **Rollback** : transaction을 완료하지 않고, 처음으로 들어가겠다.
  - **Commit** : transaction을 완료하겠다.



# 실습 환경 구성

## Install MySQL

<https://dev.mysql.com/downloads/mysql/> > MySQL Community Server 5.7 클릭

MySQL Installer 실행 > Custom >

`Select Products and Features` 에서 다음을 추가하고 `Next` 버튼 :

​	`MySQL Workbench 8.0.16 - X64`

​	`MySQL Notifier 1.1.7 - X86` 

​	`Samples and Examples 5.7.26 -X86`

​	`MySQL Server 5.7.26 - X64`

...> Visual Studio 설치 > ... 



## Install R

<https://www.r-project.org/> > CRAN 클릭 > 서버 선택 > Windows 용 > base 클릭



## Install R-studio

<https://www.rstudio.com/>



## Implicit programming vs. Explicit programming

- Implicit programming
  - 조건을 모두 기술하지 않아도 적절하게 처리결과를 도출하는 형태의 프로그래밍 방법
- Explicit programming
  - 개발자가 입력조건과 프로그램 상태 조건에 따라 프로그래밍이 동작하는 방식을 모두 구현하는 프로그래밍 방식



## 시간복잡도

$$
1 < log n < n < nlog n < n^2 < n^3 < 2^n < n!
$$





## R-Studio 활용하기

Tools > Global Options > General > Default working directory > "C:/rwork"

```R
# R스크립트 작성영역
print("Hello")
# ctrl + enter = run
# ctrl+ l = clear

# 패키지설치
intall.packages("randomForest")

# load = 하드디스크에 있는 파일을 실행하기 위해서는 메모리에 적재해야 한다.
# 패키지 설치는 한번만 하면 되지만, load는 할 때마다 해야한다.
library(randomForest)

# 변수
a<-3
b<-2

# NA: 값이 없음을 나타내는 상수
# NA인지 아닌지 알려주는 함수
is.na(four)

# NULL : 변수가 초기화되지 않은 상태.
# NULL = 빈 바구니, NA = 바구니 조차도 없음.

is.null(five)

# factor : 범주형 (카테고리, 데이터가 사전에 정해진 유형으로만 분류가 되는 경우)
# 범주형 : 명목형, 순서형으로 나눌 수 있음.
	# 명목형 : 데이터간 크기 비교가 불가능. 예) 정치적 성향(좌/우)
	# 순서형 : 크기 비교가 가능. 예) 소/중/대
# 수치형 : factor(범주형)의 반대

```

