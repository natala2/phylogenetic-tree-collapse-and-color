# Load the necessary libraries
library("ape")
library("ggtree")
# Read the phylogenetic tree from the file "example_tree" (make sure it's in the same directory as this script)
tree <- read.tree("example_tree")
# Plot the original phylogenetic tree
plot(tree)
# Function to extract letters after '#' in species names
take_letters_after_hash <- function(species1, species2) {
  hash_pos1 <- regexpr("#", species1)
  hash_pos2 <- regexpr("#", species2)
  
  if (hash_pos1 > 0) {
    letters_after_hash1 <- substr(species1, hash_pos1 + 1, nchar(species1))
  } else {
    print('no letters after hashtag')
  }
  
  if (hash_pos2 > 0) {
    letters_after_hash2 <- substr(species2, hash_pos2 + 1, nchar(species2))
  } else {
    print('no letters after hashtag')
  }
  
  if (letters_after_hash1 == letters_after_hash2) {
    return(letters_after_hash1)
  } else {
    print('those species do not come from a common clade')
  }
}

# Function to perform analysis and generate the tree plot
func <- function(tree, species1, species2, color) {
  # Find nodes for the two species
  w <- which(tree$tip.label %in% c(species1, species2))
  
  # Get the most recent common ancestor (MRCA) node
  mr <- getMRCA(tree, tip = w)
  
  # Get label
  letters_after_hash <- take_letters_after_hash(species1, species2)
  
  # Coloring and labeling
  p <- ggtree(tree) +
    geom_text(aes(label = node)) +
    geom_tiplab(size = 3, offset = 0.1) +
    geom_hilight(node = mr, fill = color) +
    geom_cladelabel(node = mr, label = letters_after_hash, align = TRUE,
                    color = 'black', fontsize = 4)
  
  return(p)
}

# Call the function
species1 <- 'speciesz#A'
species2 <- 'speciesxyz#A'
color <- 'pink'
func(tree, species1, species2, color)