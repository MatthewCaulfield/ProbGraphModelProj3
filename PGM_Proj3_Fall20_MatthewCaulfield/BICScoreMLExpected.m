function score = BICScoreMLExpected(nodeList, data, weights)
weightProb = 0;
[M,N] = size(data);
for i = 1:M
    currWeights = weights(i,:,:);
    %prob = probabilityOfData(nodeList,data(i,:));
    prob = 1;
    for n = 1:N
        if data(M,n) == 1
            prob = prob*sum(nodeList(n).theta(:,1));
        elseif data(1,n) == 2
            prob = prob*sum(nodeList(n).theta(:,2));
        end
    end
    for j = 1:N
        if data(i,j) == -999
            weightProb = weightProb + currWeights(1,j)*log(prob) + ...
                + currWeights(1,2,j)*log(prob);
        end
    end
end

d = 0;
for j = 1:N
    d = d+length(nodeList(j).theta);
end
score = weightProb/M-(d)/2*log(M);
clear('currWeights', 'nodeList', 'data', 'weightProb', 'prob');
end