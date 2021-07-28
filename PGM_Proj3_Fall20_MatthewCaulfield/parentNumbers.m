function parentList = parentNumbers(node)
    parInd = [];
    parents = node.parents;
    for p = 1:length(parents)
        parInd = [parInd parents(p)];
    end
    parentList = parInd;
end