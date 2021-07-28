function nodeList = hillClimbEM(nodeList, data, W)

[M,N] = size(data);

nodeList = EM(nodeList, data);
weights = getWeights(nodeList, data);
bestScore = BICScoreMLExpected(nodeList, data, weights);

prevTotal = inf;
iterations = 0;
bestNodeList = nodeList;
Wbest = W;
while prevTotal ~= bestScore
    iterations = iterations+1
    prevTotal = bestScore
    for n = 1:N
        nodeInd = nodeList(n).number;
        otherNodes = [[1:nodeInd-1] [nodeInd+1:N]];
        for o = otherNodes
            [parentFlag, parInd] = isParent(nodeList(n), nodeList(o));
            [childFlag, childInd] = isParent(nodeList(o), nodeList(n));
            if ~parentFlag && ~childFlag
                % If the other node is not a parent and not a child
                % check and if the being a child or being a parent has a 
                % a better score.
                newNodeList = nodeList;
                Wnew = W;
                newNodeList(n).parents = [newNodeList(n).parents newNodeList(o).number];
                %check if DAG is satisfied
                Wnew(n,o) = 1;
                Wnew(o,n) = 1;
                hW = trace(exp(Wnew))-5;
                if hW == 0
                    newNodeList = EM(newNodeList, data);
                    weights = zeros(500,2,5);
                    for m = 1:500
                        currWeight = zeros(2, 5);
                        for j = 1:5
                            currWeight(:,j) = getWeight(newNodeList, j, data(m,:));
                        end
                        weights(m,:,:) = currWeight;
                    end
                    score = BICScoreMLExpected(newNodeList, data, weights);
                    if score > bestScore
                        bestScore = score;
                        bestNodeList = newNodeList;
                        Wbest = Wnew;
                    end
                end
                newNodeList = nodeList;
                Wnew = W;
                newNodeList(o).parents = [newNodeList(o).parents newNodeList(n).number];
                %check if DAG is satisfied
                Wnew(n,o) = 1;
                Wnew(o,n) = 1;
                hW = trace(exp(Wnew))-5;
                if hW == 0
                    newNodeList = EM(newNodeList, data);
                    weights = zeros(500,2,5);
                    for m = 1:500
                        currWeight = zeros(2, 5);
                        for j = 1:5
                            currWeight(:,j) = getWeight(newNodeList, j, data(m,:));
                        end
                        weights(m,:,:) = currWeight;
                    end
                    score = BICScoreMLExpected(newNodeList, data, weights);
                    if score > bestScore
                        bestScore = score;
                        bestNodeList = newNodeList;
                        Wbest = Wnew;
                    end
                end
            elseif ~parentFlag && childFlag
                %if the other node is a child try the other
                %node as a parent and then try removing it. 

                newNodeList = nodeList;
                Wnew = W;
                newNodeList(o).parents(childInd) = [];
                newNodeList(n).parents = [newNodeList(n).parents newNodeList(o).number];
                %check if DAG is satisfied
                Wnew(n,o) = 1;
                Wnew(o,n) = 1;
                hW = trace(exp(Wnew))-5;
                if hW == 0
                    newNodeList = EM(newNodeList, data);
                    weights = zeros(500,2,5);
                    for m = 1:500
                        currWeight = zeros(2, 5);
                        for j = 1:5
                            currWeight(:,j) = getWeight(newNodeList, j, data(m,:));
                        end
                        weights(m,:,:) = currWeight;
                    end
                    score = BICScoreMLExpected(newNodeList, data, weights);
                    if score > bestScore
                        bestScore = score;
                        bestNodeList = newNodeList;
                        Wbest = Wnew;
                    end
                end
                
                newNodeList = nodeList;
                Wnew = W;
                newNodeList(o).parents(childInd) = [];
                %check if DAG is satisfied
                Wnew(n,o) = 0;
                Wnew(o,n) = 0;
                hW = trace(exp(Wnew))-5;
                if hW == 0
                    newNodeList = EM(newNodeList, data);
                    weights = zeros(500,2,5);
                    for m = 1:500
                        currWeight = zeros(2, 5);
                        for j = 1:5
                            currWeight(:,j) = getWeight(newNodeList, j, data(m,:));
                        end
                        weights(m,:,:) = currWeight;
                    end
                    score = BICScoreMLExpected(newNodeList, data, weights);
                    if score > bestScore
                        bestScore = score;
                        bestNodeList = newNodeList;
                        Wbest = Wnew;
                    end
                end
            elseif parentFlag && ~childFlag
                %if the other node is a parent try the other
                %node as a child and then try removing it.
                
                newNodeList = nodeList;
                Wnew = W;
                newNodeList(o).parents = [newNodeList(n).parents newNodeList(o).number];
                newNodeList(n).parents(parInd) = [];
                %check if DAG is satisfied
                Wnew(n,o) = 1;
                Wnew(o,n) = 1;
                hW = trace(exp(Wnew))-5;
                if hW == 0
                    newNodeList = EM(newNodeList, data);
                    weights = zeros(500,2,5);
                    for m = 1:500
                        currWeight = zeros(2, 5);
                        for j = 1:5
                            currWeight(:,j) = getWeight(newNodeList, j, data(m,:));
                        end
                        weights(m,:,:) = currWeight;
                    end
                    score = BICScoreMLExpected(newNodeList, data, weights);
                    if score > bestScore
                        bestScore = score;
                        bestNodeList = newNodeList;
                        Wbest = Wnew;
                    end
                end
                newNodeList = nodeList;
                Wnew = W;
                newNodeList(n).parents(parInd) = [];
                %check if DAG is satisfied
                Wnew(n,o) = 0;
                Wnew(o,n) = 0;
                hW = trace(exp(Wnew))-5;
                if hW == 0
                    weights = getWeights(newNodeList, data);
                    newNodeList = EM(newNodeList, data);
                    score = BICScoreMLExpected(newNodeList, data, weights);
                    if score > bestScore
                        bestScore = score;
                        bestNodeList = newNodeList;
                        Wbest = Wnew;
                    end
                end
            end
        end
        
        W = Wbest;
        nodeList = bestNodeList;
    end
    bestScore
end
end