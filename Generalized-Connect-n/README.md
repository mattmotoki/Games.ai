# Generalized Connect-n
Connect four with added features

## Implemented
* game design
   * variable sized grid
   * variable length connection criterion
   * fixed-location wildcard pieces
   * fixed-location null pieces
   * random initial board configuration
    
* board definition
    * allow border wrap
    * use a 2-d normal to randomize inital board

* opponent
   * random opponent
   * greedy opponent using a one step look ahead with state values from a random opponent

## To do:
* special pieces definition
    * bomb
    * drill (drop column)
    * non-transparent special pieces (need a bomb or drill to pass through)
    * uni- and bi-directional wildcards
    * player dependent wildcards

    
* objective definition
    * connect-n (variable size n)
    * horizontal/vertical/diagonal connection
    * max score
    * finite piece supply (time limit)
    
* player move definition  
    * swap pieces
    * remove piece

