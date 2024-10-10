function incomingEdges = findsourcenode(G,targetNode)
    
    % 获取所有边的终点  
    destinations = G.Edges.EndNodes(:,2);  
    
    % 查找终点为 targetNode 的边的索引  
    incomingEdgesIdx = find(destinations == targetNode);  
    
    % 获取这些边的起点和终点  
    incomingEdges = G.Edges.EndNodes(incomingEdgesIdx, 1);  
    
end