function [parentFlag, index] = isParent(node, otherNode)
    parInd = [];
    parents = node.parents;
    for p = 1:length(parents)
        %parInd = [parInd parents(p).number];
        parInd = [parInd parents(p)];
    end
    index = find(parInd==otherNode.number);
    if isempty(index)
        parentFlag = 0;
    else
        parentFlag = 1;
    end
end