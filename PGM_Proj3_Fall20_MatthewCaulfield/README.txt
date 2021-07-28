To run this code run main. 

To change the intitial configuration of the network
add the number of the parents node to the parents array field of the node
in lines 3-7 of main. For example if we want to intialize node B with parent A
we would change line 3 to 
B = struct("number", 2, "parents", [1], "theta", []);

To change the intialization of the parameters from uniform change lines 13-15 
of main.
