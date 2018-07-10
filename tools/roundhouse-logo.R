# Load required packages
library(ggimage)
library(ggplot2)
library(grid)
library(png)

# Load vip image
img <- rasterGrob(readPNG("tools/chuck_norris.png"), interpolate = TRUE,
                  width = 0.5)

# Hexagon data
hex <- data.frame(x = 1.35 * 1 * c(-sqrt(3) / 2, 0, rep(sqrt(3) / 2, 2), 0,
                                   rep(-sqrt(3) / 2, 2)),
                  y = 1.35 * 1 * c(0.5, 1, 0.5, -0.5, -1, -0.5, 0.5))

# Hexagon logo
g <- ggplot() +
  geom_polygon(data = hex, aes(x, y), color = "black",
               fill = 'white', size = 3) +
  annotation_custom(img, xmin = -Inf, xmax = Inf, ymin = -0.5, ymax = 1) +
  annotate(geom = "text", x = 0, y = 0.5, color = "black", size = 9,
           label = "roundhouse") +
  coord_equal(xlim = range(hex$x), ylim = range(hex$y)) +
  scale_x_continuous(expand = c(0.04, 0)) +
  scale_y_reverse(expand = c(0.04, 0)) +
  theme_void() +
  theme_transparent() +
  theme(axis.ticks.length = unit(0, "mm"))
print(g)

png("tools/roundhouse-logo.png", width = 181, height = 209,
    bg = "transparent", type = "cairo-png")
print(g)
dev.off()

svg("tools/roundhouse-logo.svg", width = 181 / 72, height = 209 / 72,
    bg = "transparent")
print(g)
dev.off()
