--Author: Roy Xu 100999873
--type and data by Prof.Robert
--All Right Reserved


type Node = Int
type Edge = (Node, Node)
data Graph = Single Node | Union Graph Graph [Edge] deriving Show

--Question 1------------------

containNode :: Node -> Graph -> Bool
containNode node (Single n) = (node == n)
containNode node (Union g1 g2 edge)
  | containNode node g1 = True
  | otherwise = containNode node g2

--Question 2-------------------

containEdge :: Edge -> Graph -> Bool
containEdge _ (Single _) = False
containEdge edge' (Union g1 g2 edge)
  | arryContain edge edge' = True
  | containEdge edge' g1 = True
  | otherwise = containEdge edge' g2

--Question 3-------------------

listNodes :: Graph -> [Node]
listNodes (Single n) = (n:[])
listNodes (Union g1 g2 edge)
  = listNodes g1 ++ (listNodes g2)


--Question 4-------------------

listEdges :: Graph -> [Edge]
listEdges (Single _) = []
listEdges (Union g1 g2 edge)
  = edge ++ listEdges g1 ++ listEdges g2

--Question 5-------------------

isSingleton :: Graph -> Bool
isSingleton (Single g) = True
isSingleton _ = False

--Question 6-------------------

bfsGraph :: Graph -> Node -> [Node]
bfsGraph (Single graph) node
  | graph == node = ([node])
  | otherwise = []
bfsGraph graph node
  = sortEdges (listEdges graph) ([node])

--Question 7--------------------

graphFromAList :: [(Node,[Node])] -> Graph
graphFromAList [] = error "List can not be empty"
graphFromAList list =
  makeG list (edgesFromList list)


--Question 8---------------------

graphFromAMatrix :: [[Bool]] -> Graph
graphFromAMatrix [] = error "Matrix can not be empty"
graphFromAMatrix matrix =
  graphFromAList (convertMToL matrix 1)
  




--Helper Functions---------------

arryContain :: [Edge] -> Edge -> Bool
arryContain [] _ = False
arryContain (h:t) elem
  | h == elem = True
  | otherwise = arryContain t elem

sortEdges :: [Edge] -> [Node] -> [Node]
sortEdges _ [] = []
sortEdges edges (h:t) =
  let  newEdges = [(a,b) | (a,b) <- edges, (myElem b (h:t) /= True)]
  in (h : (sortEdges newEdges (t ++ (adjacentNodes newEdges h))))

adjacentNodes :: [Edge] -> Node -> [Node]
adjacentNodes [] _ = []
adjacentNodes edges node
  = mySort([n | (n1,n) <- edges, n1 == node])

mySort :: [Node] -> [Node]
mySort [] = []
mySort (h:t)
  = mySort ([small | small <- (h:t), small < h]) ++ [h]
  ++ mySort ([big | big <- (h:t), big > h])

myLength :: [a] -> Int
myLength [] = 0
myLength (h : t)
  = 1 + myLength t

myElem :: Node -> [Node] -> Bool
myElem _ [] = False
myElem n (h:t)
  | n == h = True
  | otherwise = myElem n t

edgesFromList :: [(Node,[Node])] -> [Edge]
edgesFromList [] = []
edgesFromList ((_,[]):t) = edgesFromList t
edgesFromList ((node,(nodeH:nodeT)):t)
  = (node,nodeH) : edgesFromList ((node, nodeT) : t)



makeG :: [(Node,[Node])] -> [Edge] -> Graph
makeG [(n,[])] [] = Single n
makeG [(n1,_),(n2,_)] edge = Union (Single n1) (Single n2) edge
makeG ((node,nodes):t) edge =
  let  nextEdge = [(e1,e2) | (e1,e2) <- edge, e1 /= node, e2 /= node]
  in Union (Single node) (makeG t nextEdge)
     ([(e1,e2) | (e1,e2) <- edge, e2 == node || e1 == node])

convertMToL :: [[Bool]] -> Node -> [(Node,[Node])]
convertMToL [] _ = []
convertMToL (h : t) count = 
  (count, (convertBool (h) 1)) : (convertMToL t (count + 1))

convertBool :: [Bool] -> Node -> [Node]
convertBool [] _ = []
convertBool (h : t) count
  | h = [count] ++ (convertBool t (count + 1))
  | otherwise = convertBool t (count + 1)
  

