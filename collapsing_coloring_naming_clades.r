# This script demonstrates collapsing, coloring and naming multiple nodes in a phylogenetic tree using ggtree.
# Load the necessary libraries
library("ggtree")

# Read the phylogenetic tree from the file "example_tree" (make sure it's in the same directory as this script)
tree <- read.tree("example_tree")

# Plot the original phylogenetic tree
plot(tree)

# Visualizing nodes with tip labels
p <- ggtree(tree) + geom_tiplab() +
  geom_text(aes(label = node), size = 3, hjust = -0.1, vjust = 0)
plot(p)

# Coloring, collapsing and naming clades only with node number
# Specify the node numbers to be colored, collapsed, and named
colored_nodes <- c(9, 11, 10)  # Add more node numbers if needed
collapsed_nodes <- c(11)        # Add more node numbers if needed

# Define a vector of colors
colors <- c("steelblue", "pink", "greenyellow")  # Add more colors if needed

# Create the plot
p <- ggtree(tree) +
  geom_text(aes(label = node)) +
  geom_tiplab(size = 3, offset = 0.1)

# Add highlights and clade labels for colored nodes
for (i in seq_along(colored_nodes)) {
  node <- colored_nodes[i]
  color <- colors[i]
  
  p <- p + geom_hilight(node = node, fill = color, alpha = 0.5)
}

# Collapse the specified nodes to triangles with custom fill
for (node in collapsed_nodes) {
  p <- p %>% collapse(node = node, mode = "mixed", fill = "black", alpha = 0.5)
    p <- p + geom_cladelabel(node = node, label = paste("clade", node), align = TRUE,
                            color = 'black', fontsize = 4)
}

# Print the final plot
print(p)
