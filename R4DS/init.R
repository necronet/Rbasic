## This contains example from the book R for Datascience 
require(tidyverse)

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