# This script demonstrates collapsing multiple nodes in a phylogenetic tree using ggtree.

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

#for user- # Specify the node numbers to be collapsed (10, 11 are simple examples)
nodes <- c(10, 11)

# Define a function to collapse clades to triangles
collapseCladesToTriangles <- function(tree, nodes, fill = "gray", alpha = 0.5) {
  p <- ggtree(tree) + geom_tiplab()
  
  for (node in nodes) {
    p <- p %>% collapse(node, mode = "mixed", fill = fill, alpha = alpha)
  }
  
  return(p)
}
# Collapse the specified nodes to triangles with custom fill
collapsed_tree <- collapseCladesToTriangles(tree, nodes, fill = "black")
# Plot the collapsed tree
print(collapsed_tree)
