// source: https://www.geeksforgeeks.org/bellman-ford-algorithm-dp-23/
// by razorn7 - Razor#7311

Edge <- array(100, null);

class EdgeClass {
	src = 0; dest = 0; weight = 0;
}

class Graph {
	V = null;
	E = null;
	edge = Edge

	
	constructor(v, e) {
		this.V = v;
		this.E = e;
		local edge = Edge;
		for (local i = 0; i < e; i++) {
			edge[i] = EdgeClass();
		}
	}

	function BellmanFord(graph, src) {
		local V = graph.V, e = graph.E;
		local dist = array(V, null);

		for (local i = 0; i < V; i++) {
			dist[i] = 2147483647;
		}

		dist[src] = 0;

        	for (local i = 1; i < V; i++) {
            		for (local j = 0; j < E; j++) {
                		local u = graph.edge[j].src;
                		local v = graph.edge[j].dest;
                		local weight = graph.edge[j].weight;
                		if (dist[u] != 2147483647 && dist[u] + weight < dist[v])
                    			dist[v] = dist[u] + weight;
            		}
        	}

        	for (local j = 0; j < E; j ++) {
            		local u = graph.edge[j].src;
            		local v = graph.edge[j].dest;
            		local weight = graph.edge[j].weight;
            		if (dist[u] != 2147483647 && dist[u] + weight < dist[v]) {
                		print("Graph contains negative weight cycle");
                		return;
            		}
        	}
		printArr(dist, V);
	}
}

function printArr(dist, V) {
	print("Vertex Distance from Source");
	for (local i = 0; i < V; i++)
		print(i + "\n\n" + dist[i]);
}

local graph = Graph(5, 8);

graph.edge[0].src = 0;
graph.edge[0].dest = 1;
graph.edge[0].weight = -1;
	
graph.edge[1].src = 0;
graph.edge[1].dest = 2;
graph.edge[1].weight = 4;
 
// add edge 1-2 (or B-C in above figure)
graph.edge[2].src = 1;
graph.edge[2].dest = 2;
graph.edge[2].weight = 3;
 
// add edge 1-3 (or B-D in above figure)
graph.edge[3].src = 1;
graph.edge[3].dest = 3;
graph.edge[3].weight = 2;
 
// add edge 1-4 (or B-E in above figure)
graph.edge[4].src = 1;
graph.edge[4].dest = 4;
graph.edge[4].weight = 2;
 
// add edge 3-2 (or D-C in above figure)
graph.edge[5].src = 3;
graph.edge[5].dest = 2;
graph.edge[5].weight = 5;
 
// add edge 3-1 (or D-B in above figure)
graph.edge[6].src = 3;
graph.edge[6].dest = 1;
graph.edge[6].weight = 1;
 
// add edge 4-3 (or E-D in above figure)
graph.edge[7].src = 4;
graph.edge[7].dest = 3;
graph.edge[7].weight = -3;
         
// Function call
graph.BellmanFord(graph, 0);
