function weights = getWeights(nodeList, data)
weights = zeros(500,2,5);
for m = 1:500
    currWeight = zeros(2, 5);
    for j = 1:5
        currWeight(:,j) = getWeight(nodeList, j, data(m,:));
    end
    weights(m,:,:) = currWeight;
end
clear('nodeList', 'data', 'currWeight');
end