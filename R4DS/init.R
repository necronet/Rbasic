## This contains example from the book R for Datascience 
require(tidyverse)
require(maps)

# Run ggplot(data = mpg). What do you see?
# Answer nothing will happen ggplot requires another layer to render the data
ggplot(data = mpg)
# The first argument of ggplot() is the dataset to use in the graph. So ggplot(data = mpg) 
# creates an empty graph, but it’s not very interesting so I’m not going to show it here.

# How many rows are in mpg? How many columns?
# Answer: 234x11
  dim(mpg)
  
# What does the drv variable describe? Read the help for ?mpg to find out.
# Answer: f = front-wheel drive, r = rear wheel drive, 4 = 4wd

# Make a scatterplot of hwy vs cyl.
ggplot(data = mpg) + geom_point(mapping=aes(x=cyl, y = hwy))

# What happens if you make a scatterplot of class vs drv? Why is the plot not useful?
# It does not show any trend or correlation as many class of car will have different driving mode
ggplot(data = mpg) + geom_point(mapping=aes(x=drv, y = class))
  

# Aesthetic
ggplot(data = mpg) + geom_point(mapping=aes(x=displ, y = hwy, color=class))

# What’s gone wrong with this code? Why are the points not blue?
# ggplot(data = mpg) + 
#   geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))
# Answer: The color attribute is inside aes should be outside like this:
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

# Which variables in mpg are categorical? Which variables are continuous? 
# (Hint: type ?mpg to read the documentation for the dataset). 
# How can you see this information when you run mpg?
# Only engine displacement (displ) is a continous variable the rest are categorical
  
# Map a continuous variable to color, size, and shape. 
# How do these aesthetics behave differently for categorical vs. continuous variables?
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = class, size=displ, alpha=trans))
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = year, size=displ, alpha=drv))
  
# What happens if you map the same variable to multiple aesthetics?
# It is very redundant to do so, but it will be use nonetheless
  
# What does the stroke aesthetic do? What shapes does it work with? (Hint: use ?geom_point)
# Strokes control a "border" like in each point in the graph

# What happens if you map an aesthetic to something other than a variable name, like aes(colour = displ < 5)?
# Answer: will color the ones that have a displ less than 5 different
  ggplot(data = mpg) + geom_point(mapping=aes(x=displ, y = hwy, color=displ<5),stroke=0)

  
# Facets 
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy)) + facet_wrap(~ class, nrow = 3)
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy)) + facet_grid(drv ~ cyl)
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy)) + facet_grid(. ~ class)


# What happens if you facet on a continuous variable?
# It will try to factor them, it takes longer and is not efficient plus is giving nothing useful
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy)) + facet_wrap(~ displ, nrow=4)

# What do the empty cells in plot with facet_grid(drv ~ cyl) mean? How do they relate to this plot?
#   
#   ggplot(data = mpg) + 
#   geom_point(mapping = aes(x = drv, y = cyl))
# It means that there is no vehicle that is front-wheel drive(r) that has 4 or 5 cylinders for example
ggplot(data = mpg) + geom_point(mapping = aes(x = drv, y = cyl))
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy)) + facet_grid(drv ~ cyl)

# What plots does the following code make? What does . do?
# It will aggregate them base on the left or right depending on which will render it horizontal or vertical
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)


# Take the first faceted plot in this section:
  ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy)) + facet_wrap(~ class, nrow = 2)
# What are the advantages to using faceting instead of the colour aesthetic? 
  # It Focus the view of points per class without the noise of having everything together
# What are the disadvantages? How might the balance change if you had a larger dataset?
  # The colour can help detect some extreme cases of the global distribution faster
  
  # Combine them and take full advantages of both
  ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color=displ<5)) + facet_wrap(~ class, nrow = 2)

# Read ?facet_wrap. What does nrow do? What does ncol do? 
# Answer: Split the graph per a specific number of row or columns
# Why doesn’t facet_grid() have nrow and ncol arguments?
# Answer: Facetgrid does a cross relationship between two variables no need to specify the nrow
  
  
# Geometric objects
  
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) + geom_smooth(mapping = aes(x = displ, y = hwy))


ggplot(data = mpg) + geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) + geom_smooth(mapping = aes(x = displ, y = hwy, group = drv))

ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, color = drv),
    show.legend = FALSE
  )

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))


ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth(method='loess')

# What geom would you use to draw a line chart? A boxplot? A histogram? An area chart?
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + geom_line()
ggplot(data = mpg, mapping = aes(x = drv, y = hwy)) + geom_boxplot()
ggplot(data = mpg, mapping = aes(x = hwy),color=red) + geom_histogram()

# Run this code in your head and predict what the output will look like. 
# Then, run the code in R and check your predictions.

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE)

# What does show.legend = FALSE do? What happens if you remove it?
# Why do you think I used it earlier in the chapter?
# It obviously remove the legend and it was probably use to not make a graph obvious and make the reader think a bit

# What does the se argument to geom_smooth() do?
# Basically remove the confident level cool shadow that is calculated


# Will these two graphs look different? Why/why not?
#   They are gonna be the same graph different syntax.

#   ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
#   geom_point() + 
#   geom_smooth()
# 
# ggplot() + 
#   geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
#   geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

# Recreate the R code necessary to generate the following graphs.
# Graph 1
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + geom_point() + geom_smooth(se=FALSE)
# Graph 2
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, group=drv)) + geom_point() + geom_smooth(se=FALSE)
# Graph 3
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, group=drv, color=drv)) + geom_point() + geom_smooth(se=FALSE)
# Graph 4
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping=aes(color=drv)) + 
  geom_smooth(se=FALSE)
# Graph 5
ggplot(data = mpg, mapping = aes(x = displ, y = hwy,linetype=drv)) + 
  geom_point(mapping=aes(color=drv)) + 
  geom_smooth(se=FALSE)
# Graph 6
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(color='white',stroke=4)  + geom_point(mapping=aes(color=drv),size=3)


# 3.7 Statistical transformations
ggplot(data = diamonds) + geom_bar(mapping = aes(x = cut))
ggplot(data = diamonds) + stat_count(mapping = aes(x = cut))

demo <- tribble(
  ~cut,         ~freq,
  "Fair",       1610,
  "Good",       4906,
  "Very Good",  12082,
  "Premium",    13791,
  "Ideal",      21551
)

ggplot(data = demo) + geom_bar(mapping = aes(x = cut, y = freq), stat = "identity")

ggplot(data = diamonds) + geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1))

ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  )

# 3.8 Position adjustments

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, colour = cut))
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut))

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))

ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) + 
  geom_bar(alpha = 1/5, position = "identity")
ggplot(data = diamonds, mapping = aes(x = cut, colour = clarity)) + 
  geom_bar(fill = NA, position = "identity")

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")

ggplot(data = mpg) + 
  geom_jitter(mapping = aes(x = displ, y = hwy)) 


# 3.9 Coordinate systems

ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot()
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot() +
  coord_flip()


nz <- map_data("nz")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black") +
  coord_quickmap()


bar <- ggplot(data = diamonds) + 
  geom_bar(
    mapping = aes(x = cut, fill = cut), 
    show.legend = FALSE,
    width = 1
  ) + 
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

bar + coord_flip()
bar + coord_polar()