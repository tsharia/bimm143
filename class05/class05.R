#'---
#'title: "Class 05 Data Visualization"
#'author: "Tasnia Sharia (PID: A15931128)"
#'---


# Scatter plot
# Before we use the data, ggplot needs to be loaded

library(ggplot2)

# Every ggplot has a date + aes + geoms
# rather than geom_line, used geom_smooth to show trend line
ggplot(data = cars) +
  aes(x = speed, y = dist) +
  geom_point() + geom_smooth()

# change to linear model
p <- ggplot(data = cars) +
  aes(x = speed, y = dist) +
  geom_point() + geom_smooth(method="lm", se=FALSE) + 
  labs(title="Speed and Stopping Distance of Cars", 
       x="Speed (MPH)", 
       y="Stopping distance (ft)",
       caption="Dataset: 'cars'") 

# use theme_bw for more simple black and white look

# Base graphics is shorter
plot(cars)

# Trying more complicated data set of genes expressed
# First read the data set
# Need to run each line from the script!

url <- "https://bioboot.github.io/bimm143_S20/class-material/up_down_expression.txt"
genes <- read.delim(url)
head(genes)

# Q. How many genes?
nrow(genes)

# Q. How to access State column?
table(genes$State)

# Q. What are % up/down?
prec <- table(genes$State) / nrow(genes)
round(prec * 100, 2) # (round(data, sig figs))

# Q. names of columns?
colnames(genes)

#Q. # of columns?
ncol(genes)

# Time to plot
p <- ggplot(data = genes) + 
  aes(x = Condition1, y=Condition2, col=State) +
  geom_point() +
  labs(title = "Gene Expression Changes Upon Drug Treatment",
       x= "Control (No drugs)",
       y= "Drug Treatment")

p + scale_colour_manual(values = c("green", "gray", "purple"))

# Going Further: Gapminder
install.packages("gapminder")
library(gapminder)


install.packages("dplyr")  ## uncomment to install if needed
library(dplyr)
gapminder_2007 <- gapminder %>% filter(year==2007)

library(ggplot2) 
View(gapminder_2007)

# viewing plot 
# Points are colored based on continent (categorical)
ggplot(data = gapminder_2007) +
  aes(x=gdpPercap, y=lifeExp, color=continent, size=pop) +
  geom_point(alpha=0.5)
# pop= population, alpha makes points transparent  

# Points are colored based on population (numerical) 
ggplot(data = gapminder_2007) +
  aes(x=gdpPercap, y=lifeExp, color=pop) +
  geom_point(alpha=0.8)

# Point size based on population
ggplot(data = gapminder_2007) +
  aes(x=gdpPercap, y=lifeExp, size=pop) +
  geom_point(alpha=0.5)
# These points do not reflect pop differences since the sizes are not proportional

# Reflecting actual pop differences
ggplot(gapminder_2007) +
  geom_point(aes(x=gdpPercap, y=lifeExp,
                 size=pop), alpha=0.5) +
  scale_size_area(max_size = 10)
# max_size results in bigger point sizes

#viewing gapminder_1957 data
library(dplyr)
gapminder_1957 <- gapminder %>% filter(year==1957)

library(ggplot2) 
View(gapminder_1957)

# creating plot for gapminder_1957
ggplot(gapminder_1957) + 
  aes(x = gdpPercap, y = lifeExp, color=continent,
      size = pop) +
  geom_point(alpha=0.7) + 
  scale_size_area(max_size = 10) 

# comparing both 2007 and 1957
gapminder_1957 <- gapminder %>% filter(year==1957 | year==2007)

ggplot(gapminder_1957) + 
  geom_point(aes(x = gdpPercap, y = lifeExp, color=continent,
                 size = pop), alpha=0.7) + 
  scale_size_area(max_size = 10) +
  facet_wrap(~year)

#Intro to Bar charts
