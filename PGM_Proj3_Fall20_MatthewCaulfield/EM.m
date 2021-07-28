function newNodeList = EM(nodeList, data)
[~, M] = size(data);
N = length(nodeList);
newNodeList = nodeList;

for i = 1:N
    [~,numPar] =  size(newNodeList(i).parents);
    newNodeList(i).theta = zeros((2^(numPar)), 2);
end
convergence = inf;
while convergence > 10^-16
nodeList = newNodeList; 
for i = 1:500
    dataSample = data(i,:);
    for j = 1:N
        currNode = nodeList(j);
        parentList = parentNumbers(currNode);
        [~, numPar] = size(parentList);
        if numPar == 0
            if dataSample(1,j) == 1
                newNodeList(j).theta(1,1) = newNodeList(j).theta(1,1) + 1;
            elseif dataSample(1,j) == 2
                newNodeList(j).theta(1,2) = newNodeList(j).theta(1,2) + 1;
            elseif dataSample(1,j) == -999
                newNodeList(j).theta = newNodeList(j).theta + nodeList(j).theta;
            end
        elseif numPar == 1
            par1 = currNode.parents;
            if dataSample(1,j) == 1
                if dataSample(1,par1) == 1
                    newNodeList(j).theta(1,1) = newNodeList(j).theta(1,1) + 1;
                elseif dataSample(1,par1) == 2
                    newNodeList(j).theta(2,1) = newNodeList(j).theta(2,1) + 1;
                end
            elseif dataSample(1,j) == 2
                if dataSample(1,par1) == 1
                    newNodeList(j).theta(1,1) = newNodeList(j).theta(1,2) + 1;
                elseif dataSample(1,par1) == 2
                    newNodeList(j).theta(2,2) = newNodeList(j).theta(2,2) + 1;
                end
            elseif dataSample(1,j) == -999
                if dataSample(1,par1) == 1
                    newNodeList(j).theta(1,:) = newNodeList(j).theta(1,:) + newNodeList(j).theta(1,:);
                elseif dataSample(1,par1) == 2
                    newNodeList(j).theta(2,:) = newNodeList(j).theta(2,:) + newNodeList(j).theta(2,:);
                end
            end        
        elseif numPar == 2
            par1 = newNodeList(j).parents(1);
            par2 = newNodeList(j).parents(2);
            if dataSample(1,j) == 1
                if dataSample(1,par1) == 1 && dataSample(1,par2) == 1
                    newNodeList(j).theta(1,1) = newNodeList(j).theta(1,1) + 1;
                elseif  dataSample(1,par1) == 1 && dataSample(1,par2) == 2
                    newNodeList(j).theta(2,1) = newNodeList(j).theta(2,1) + 1;
                elseif  dataSample(1,par1) == 2 && dataSample(1,par2) == 1
                    newNodeList(j).theta(3,1) = newNodeList(j).theta(3,1) + 1;
                elseif  dataSample(1,par1) == 2 && dataSample(1,par2) == 2
                    newNodeList(j).theta(4,1) = newNodeList(j).theta(4,1) + 1;
                end
            elseif dataSample(1,j) == 2
                if dataSample(1,par1) == 1 && dataSample(1,par2) == 1
                    newNodeList(j).theta(1,2) = newNodeList(j).theta(1,2) + 1;
                elseif  dataSample(1,par1) == 1 && dataSample(1,par2) == 2
                    newNodeList(j).theta(2,2) = newNodeList(j).theta(2,2) + 1;
                elseif  dataSample(1,par1) == 2 && dataSample(1,par2) == 1
                    newNodeList(j).theta(3,2) = newNodeList(j).theta(3,2) + 1;
                elseif  dataSample(1,par1) == 2 && dataSample(1,par2) == 2
                    newNodeList(j).theta(4,2) = newNodeList(j).theta(4,2) + 1;
                end
            elseif dataSample(1,j) == -999
                if dataSample(1,par1) == 1 && dataSample(1,par2) == 1
                    newNodeList(j).theta(1,:) = newNodeList(j).theta(1,:) + nodeList(j).theta(1,:);
                elseif  dataSample(1,par1) == 1 && dataSample(1,par2) == 2
                    newNodeList(j).theta(2,:) = newNodeList(j).theta(2,:) + nodeList(j).theta(2,:);
                elseif  dataSample(1,par1) == 2 && dataSample(1,par2) == 1
                    newNodeList(j).theta(3,:) = newNodeList(j).theta(3,:) + nodeList(j).theta(3,:);
                elseif  dataSample(1,par1) == 2 && dataSample(1,par2) == 2
                    newNodeList(j).theta(4,:) = newNodeList(j).theta(4,:) + nodeList(j).theta(4,:);
                end
            end 
%         elseif numPar == 3
%             par1 = newNodeList(j).parents(1).number;
%             par2 = newNodeList(j).parents(2).number;
%             par3 = newNodeList(j).parents(3).number;
%             if dataSample(1,j) == 1
%                  if dataSample(1,par1) == 1 && dataSample(1,par2) == 1 && dataSample(1,par3) == 1
%                     newNodeList(j).theta(1,1) = newNodeList(j).theta(1,1) + 1;
%                 elseif dataSample(1,par1) == 1 && dataSample(1,par2) == 1 && dataSample(1,par3) == 2
%                     newNodeList(j).theta(2,1) = newNodeList(j).theta(2,1) + 1;
%                 elseif dataSample(1,par1) == 1 && dataSample(1,par2) == 2 && dataSample(1,par3) == 1
%                     newNodeList(j).theta(3,1) = newNodeList(j).theta(3,1) + 1;
%                 elseif dataSample(1,par1) == 1 && dataSample(1,par2) == 2 && dataSample(1,par3) == 2
%                     newNodeList(j).theta(4,1) = newNodeList(j).theta(4,1) + 1;
%                 elseif dataSample(1,par1) == 2 && dataSample(1,par2) == 1 && dataSample(1,par3) == 1
%                     newNodeList(j).theta(5,1) = newNodeList(j).theta(5,1) + 1;
%                 elseif dataSample(1,par1) == 2 && dataSample(1,par2) == 1 && dataSample(1,par3) == 2
%                     newNodeList(j).theta(6,1) = newNodeList(j).theta(6,1) + 1;
%                 elseif dataSample(1,par1) == 2 && dataSample(1,par2) == 2 && dataSample(1,par3) == 1
%                     newNodeList(j).theta(7,1) = newNodeList(j).theta(7,1) + 1;
%                 elseif dataSample(1,par1) == 2 && dataSample(1,par2) == 2 && dataSample(1,par3) == 2
%                     newNodeList(j).theta(8,1) = newNodeList(j).theta(8,1) + 1;
%                  end
%             elseif dataSample(1,j) == 2
%                  if dataSample(1,par1) == 1 && dataSample(1,par2) == 1 && dataSample(1,par3) == 1
%                     newNodeList(j).theta(1,1) = newNodeList(j).theta(1,2) + 1;
%                 elseif dataSample(1,par1) == 1 && dataSample(1,par2) == 1 && dataSample(1,par3) == 2
%                     newNodeList(j).theta(2,1) = newNodeList(j).theta(2,2) + 1;
%                 elseif dataSample(1,par1) == 1 && dataSample(1,par2) == 2 && dataSample(1,par3) == 1
%                     newNodeList(j).theta(3,1) = newNodeList(j).theta(3,2) + 1;
%                 elseif dataSample(1,par1) == 1 && dataSample(1,par2) == 2 && dataSample(1,par3) == 2
%                     newNodeList(j).theta(4,1) = newNodeList(j).theta(4,2) + 1;
%                 elseif dataSample(1,par1) == 2 && dataSample(1,par2) == 1 && dataSample(1,par3) == 1
%                     newNodeList(j).theta(5,1) = newNodeList(j).theta(5,2) + 1;
%                 elseif dataSample(1,par1) == 2 && dataSample(1,par2) == 1 && dataSample(1,par3) == 2
%                     newNodeList(j).theta(6,1) = newNodeList(j).theta(6,2) + 1;
%                 elseif dataSample(1,par1) == 2 && dataSample(1,par2) == 2 && dataSample(1,par3) == 1
%                     newNodeList(j).theta(7,1) = newNodeList(j).theta(7,2) + 1;
%                 elseif dataSample(1,par1) == 2 && dataSample(1,par2) == 2 && dataSample(1,par3) == 2
%                     newNodeList(j).theta(8,1) = newNodeList(j).theta(8,2) + 1;
%                  end
%             elseif dataSample(1,j) == -999
%                 if dataSample(1,par1) == 1 && dataSample(1,par2) == 1 && dataSample(1,par3) == 1
%                     newNodeList(j).theta(1,:) = newNodeList(j).theta(1,:) + nodeList.theta(1,:);
%                 elseif dataSample(1,par1) == 1 && dataSample(1,par2) == 1 && dataSample(1,par3) == 2
%                     newNodeList(j).theta(2,:) = newNodeList(j).theta(2,:) + nodeList.theta(2,:);
%                 elseif dataSample(1,par1) == 1 && dataSample(1,par2) == 2 && dataSample(1,par3) == 1
%                     newNodeList(j).theta(3,:) = newNodeList(j).theta(3,:) + nodeList.theta(3,:);
%                 elseif dataSample(1,par1) == 1 && dataSample(1,par2) == 2 && dataSample(1,par3) == 2
%                     newNodeList(j).theta(4,:) = newNodeList(j).theta(4,:) + nodeList.theta(4,:);
%                 elseif dataSample(1,par1) == 2 && dataSample(1,par2) == 1 && dataSample(1,par3) == 1
%                     newNodeList(j).theta(5,:) = newNodeList(j).theta(5,:) + nodeList.theta(5,:);
%                 elseif dataSample(1,par1) == 2 && dataSample(1,par2) == 1 && dataSample(1,par3) == 2
%                     newNodeList(j).theta(6,:) = newNodeList(j).theta(6,:) + nodeList.theta(6,:);
%                 elseif dataSample(1,par1) == 2 && dataSample(1,par2) == 2 && dataSample(1,par3) == 1
%                     newNodeList(j).theta(7,:) = newNodeList(j).theta(7,:) + nodeList.theta(7,:);
%                 elseif dataSample(1,par1) == 2 && dataSample(1,par2) == 2 && dataSample(1,par3) == 2
%                     newNodeList(j).theta(8,:) = newNodeList(j).theta(8,:) + nodeList.theta(8,:);
%                  end
%             end
        end
    end
end
convergence =0;
for i = 1:N
    theta = newNodeList(i).theta;
    newNodeList(i).theta = theta./sum(theta,2);
    convergence = convergence + abs(sum(nodeList(i).theta-newNodeList(i).theta));
end
nodeList = newNodeList;  

end
clear('nodeList', 'data', 'theta');
end