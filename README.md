# Discrete II - HW 9
## Problems 11 & 13

### REQUIREMENTS

This program is designed to be run in Docker-Compose on Windows.  I was unable to get it working on my Linux machine, but I also didn't spend very long on it.

With the correct installed programs, this can be run by navigating to the top-level cloned directory and running `docker-compose up`.

Alternatively, the data could be stripped out and the information fed into a stand-alone MySQL database, and the connection string information updated to correctly reflect that of your database instance.

### Distances During dijkstra's Algorithm

Rather than do this by hand, I chose to write some code to do it.  I stored the Node and Edge information in a `MySQL` instance, and wrote a python script to access that information and calculate the minimum-length paths to each node from `a`.

The process was simple: store all of the `Nodes` in a table in the database.  Store all of the `Edges` in another table keyed to the first; each edge had a `source`, a `destination`, and a `weight`.  Starting from `a`, I pulled all edges with that Node as a Source.  If the current length to the destination was greater than the current length to the source plus the weight between, the new length replaced the old, the current path to that node was updated, and the destination was added to the queue to check if that new value would reduce any paths already calcuated.

This continued until all paths had been exhausted.

The results were stored in a dictionary, mapping each node to the current minimum path and its length, and outputted at each iteration.

```python
# Problem 11
{'a': ('a', 0), 'b': ('a', -1), 'c': ('a', -1), 'd': ('a', -1), 'e': ('a', -1), 'f': ('a', -1), 'g': ('a', -1), 'h': ('a', -1)}
{'a': ('a', 0), 'b': ('ab', 1), 'c': ('a', -1), 'd': ('a', -1), 'e': ('a', -1), 'f': ('a', -1), 'g': ('ag', 6), 'h': ('ah', 10)}
{'a': ('a', 0), 'b': ('ab', 1), 'c': ('a', -1), 'd': ('a', -1), 'e': ('a', -1), 'f': ('ahf', 15), 'g': ('ag', 6), 'h': ('ah', 10)}
{'a': ('a', 0), 'b': ('ab', 1), 'c': ('a', -1), 'd': ('abd', 2), 'e': ('a', -1), 'f': ('ahf', 15), 'g': ('ag', 6), 'h': ('abh', 3)}
{'a': ('a', 0), 'b': ('ab', 1), 'c': ('agc', 8), 'd': ('abd', 2), 'e': ('a', -1), 'f': ('ahf', 15), 'g': ('ag', 6), 'h': ('abh', 3)}
{'a': ('a', 0), 'b': ('ab', 1), 'c': ('agc', 8), 'd': ('abd', 2), 'e': ('a', -1), 'f': ('ahf', 15), 'g': ('ag', 6), 'h': ('abh', 3)}
{'a': ('a', 0), 'b': ('ab', 1), 'c': ('agc', 8), 'd': ('abd', 2), 'e': ('a', -1), 'f': ('abhf', 8), 'g': ('ag', 6), 'h': ('abh', 3)}
{'a': ('a', 0), 'b': ('ab', 1), 'c': ('agc', 8), 'd': ('abd', 2), 'e': ('abde', 5), 'f': ('abdf', 6), 'g': ('ag', 6), 'h': ('abh', 3)}
{'a': ('a', 0), 'b': ('ab', 1), 'c': ('agc', 8), 'd': ('abd', 2), 'e': ('abde', 5), 'f': ('abdf', 6), 'g': ('ag', 6), 'h': ('abh', 3)}
{'a': ('a', 0), 'b': ('ab', 1), 'c': ('agc', 8), 'd': ('abd', 2), 'e': ('abde', 5), 'f': ('abdf', 6), 'g': ('ag', 6), 'h': ('abh', 3)}
{'a': ('a', 0), 'b': ('ab', 1), 'c': ('agc', 8), 'd': ('abd', 2), 'e': ('abde', 5), 'f': ('abdf', 6), 'g': ('ag', 6), 'h': ('abh', 3)}
Problem complete
{'a': ('a', 0), 'b': ('a', -1), 'c': ('a', -1), 'd': ('a', -1), 'e': ('a', -1), 'f': ('a', -1), 'g': ('a', -1), 'h': ('a', -1), 'i': ('a', -1)}
{'a': ('a', 0), 'b': ('a', -1), 'c': ('a', -1), 'd': ('a', -1), 'e': ('a', -1), 'f': ('af', 4), 'g': ('a', -1), 'h': ('ah', 2), 'i': ('a', -1)}
{'a': ('a', 0), 'b': ('a', -1), 'c': ('ahc', 5), 'd': ('a', -1), 'e': ('a', -1), 'f': ('af', 4), 'g': ('ahg', 4), 'h': ('ah', 2), 'i': ('a', -1)}
{'a': ('a', 0), 'b': ('afb', 9), 'c': ('ahc', 5), 'd': ('a', -1), 'e': ('a', -1), 'f': ('af', 4), 'g': ('ahg', 4), 'h': ('ah', 2), 'i': ('a', -1)}
{'a': ('a', 0), 'b': ('afb', 9), 'c': ('ahc', 5), 'd': ('ahgd', 5), 'e': ('a', -1), 'f': ('af', 4), 'g': ('ahg', 4), 'h': ('ah', 2), 'i': ('a', -1)}
{'a': ('a', 0), 'b': ('afb', 9), 'c': ('ahc', 5), 'd': ('ahgd', 5), 'e': ('a', -1), 'f': ('af', 4), 'g': ('ahg', 4), 'h': ('ah', 2), 'i': ('ahci', 7)}
{'a': ('a', 0), 'b': ('afb', 9), 'c': ('ahc', 5), 'd': ('ahgd', 5), 'e': ('a', -1), 'f': ('af', 4), 'g': ('ahg', 4), 'h': ('ah', 2), 'i': ('ahci', 7)}
{'a': ('a', 0), 'b': ('afb', 9), 'c': ('ahc', 5), 'd': ('ahgd', 5), 'e': ('ahgde', 8), 'f': ('af', 4), 'g': ('ahg', 4), 'h': ('ah', 2), 'i': ('ahci', 7)}
{'a': ('a', 0), 'b': ('afb', 9), 'c': ('ahc', 5), 'd': ('ahgd', 5), 'e': ('ahgde', 8), 'f': ('af', 4), 'g': ('ahg', 4), 'h': ('ah', 2), 'i': ('ahci', 7)}
Problem complete
```