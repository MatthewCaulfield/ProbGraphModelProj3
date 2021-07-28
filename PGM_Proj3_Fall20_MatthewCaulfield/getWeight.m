function weight = getWeight(nodeList, nodeInd, dataSample)
    currNode = nodeList(nodeInd);
    weight = zeros(2, 1);
    if dataSample(1,nodeInd) == 1
        weight(:,1) = [1; 0];
    elseif dataSample(1,nodeInd) == 2
        weight(:,1) = [0; 1];
    elseif dataSample(1,nodeInd) == -999
        parentList = parentNumbers(currNode);
        [~, numPar] = size(parentList);
        if numPar == 0
            weight(:,1) = currNode.theta(1,:);
        elseif numPar == 1
            par1 = currNode.parents;
            if dataSample(1,par1) == 1
                weight(:,1) = currNode.theta(1,:);
            elseif dataSample(1,par1) == 2
                weight(:,1) = currNode.theta(2,:);
            elseif dataSample(1,par1) == -999
                parentInd = currNode.parents(1);
                parWeight = getWeight(nodeList, parentInd, dataSample);
                weight(1,1) = currNode.theta(1,1)*parWeight(1,1)+ currNode.theta(2,1)*parWeight(2,1);
                weight(2,1) = currNode.theta(1,2)*parWeight(1,1)+ currNode.theta(2,2)*parWeight(2,1);
            end
        elseif numPar == 2
            par1 = currNode.parents(1);
            par2 = currNode.parents(2);
            if dataSample(1,par1) == 1 && dataSample(1,par1) == 1
                weight(:,1) = currNode.theta(1,:);
            elseif  dataSample(1,par1) == 1 && dataSample(1,par2) == 2
                weight(:,1) = currNode.theta(2,:);
            elseif  dataSample(1,par1) == 2 && dataSample(1,par2) == 1
                weight(:,1) = currNode.theta(3,:);
            elseif  dataSample(1,par1) == 2 && dataSample(1,par2) == 2
                weight(:,1) = currNode.theta(4,:);
            elseif  dataSample(1,par1) == -999 && dataSample(1,par2) == 1
                parentInd1 = currNode.parents(1);
                parWeight = getWeight(nodeList, parentInd1, dataSample);
                weight(1,1) = currNode.theta(1,1)*parWeight(1,1)+ currNode.theta(3,1)*parWeight(2,1);
                weight(2,1) = currNode.theta(1,2)*parWeight(1,1)+ currNode.theta(3,2)*parWeight(2,1);
            elseif  dataSample(1,par1) == -999 && dataSample(1,par2) == 2
                parentInd1 = currNode.parents(1);
                parWeight = getWeight(nodeList, parentInd1, dataSample);
                weight(1,1) = currNode.theta(2,1)*parWeight(1,1)+ currNode.theta(4,1)*parWeight(2,1);
                weight(2,1) = currNode.theta(2,2)*parWeight(1,1)+ currNode.theta(4,2)*parWeight(2,1);                
            elseif  dataSample(1,par1) == 1 && dataSample(1,par2) == -999
                parentInd2 = currNode.parents(2);
                parWeight = getWeight(nodeList, parentInd2, dataSample);
                weight(1,1) = currNode.theta(1,1)*parWeight(1,1)+ currNode.theta(2,1)*parWeight(2,1);
                weight(2,1) = currNode.theta(1,2)*parWeight(1,1)+ currNode.theta(2,2)*parWeight(2,1);  
            elseif  dataSample(1,par1) == 2 && dataSample(1,par2) == -999
                parentInd2 = currNode.parents(2);
                parWeight = getWeight(nodeList, parentInd2, dataSample);
                weight(1,1) = currNode.theta(3,1)*parWeight(1,1)+ currNode.theta(3,1)*parWeight(2,1);
                weight(2,1) = currNode.theta(4,2)*parWeight(1,1)+ currNode.theta(4,2)*parWeight(2,1);  
            elseif  dataSample(1,par1) == -999 && dataSample(1,par2) == -999
                parentInd1 = currNode.parents(1);
                parWeight1 = getWeight(nodeList, parentInd1, dataSample);
                parentInd2 = currNode.parents(2);
                parWeight2 = getWeight(nodeList, parentInd2, dataSample);
                weight(1,1) = currNode.theta(1,1)*parWeight1(1,1)*parWeight2(1,1)...
                    + currNode.theta(2,1)*parWeight1(1,1)*parWeight2(2,1)...
                    + currNode.theta(3,1)*parWeight1(2,1)*parWeight2(1,1)...
                    + currNode.theta(4,1)*parWeight1(2,1)*parWeight2(2,1);
                weight(2,1) = currNode.theta(1,2)*parWeight1(1,1)*parWeight2(1,1)...
                    + currNode.theta(2,2)*parWeight1(1,1)*parWeight2(2,1)...
                    + currNode.theta(3,2)*parWeight1(2,1)*parWeight2(1,1)...
                    + currNode.theta(4,2)*parWeight1(2,1)*parWeight2(2,1);
            end
            
%         elseif numPar == 3   
%             par1 = currNode.parents(1).number;
%             par2 = currNode.parents(2).number;
%             par3 = currNode.parents(3).number;
%             if dataSample(1,par1) == 1 && dataSample(1,par2) == 1 && dataSample(1,par3) == 1
%                 weight(:,1) = currNode.theta(1,:);
%             elseif dataSample(1,par1) == 1 && dataSample(1,par2) == 1 && dataSample(1,par3) == 2
%                 weight(:,1) = currNode.theta(2,:);
%             elseif dataSample(1,par1) == 1 && dataSample(1,par2) == 2 && dataSample(1,par3) == 1
%                 weight(:,1) = currNode.theta(3,:);
%             elseif dataSample(1,par1) == 1 && dataSample(1,par2) == 2 && dataSample(1,par3) == 2
%                 weight(:,1) = currNode.theta(4,:);
%             elseif dataSample(1,par1) == 2 && dataSample(1,par2) == 1 && dataSample(1,par3) == 1
%                 weight(:,1) = currNode.theta(5,:);
%             elseif dataSample(1,par1) == 2 && dataSample(1,par2) == 1 && dataSample(1,par3) == 2
%                 weight(:,1) = currNode.theta(6,:);
%             elseif dataSample(1,par1) == 2 && dataSample(1,par2) == 2 && dataSample(1,par3) == 1
%                 weight(:,1) = currNode.theta(7,:);
%             elseif dataSample(1,par1) == 2 && dataSample(1,par2) == 2 && dataSample(1,par3) == 2
%                 weight(:,1) = currNode.theta(8,:);
%             elseif dataSample(1,par1) == 1 && dataSample(1,par2) == 1 && dataSample(1,par3) == -999
%                 parentInd3 = currNode.parents(3).number;
%                 parWeight3 = getWeight(nodeList, parentInd3);
%                 weight(1,1) = currNode.theta(1,1)*parWeight3(1,1)+ currNode.theta(2,1)*parWeight3(2,1);
%                 weight(2,1) = currNode.theta(1,2)*parWeight3(1,1)+ currNode.theta(2,2)*parWeight3(2,1);
%             elseif dataSample(1,par1) == 1 && dataSample(1,par2) == 2 && dataSample(1,par3) == -999
%                 parentInd3 = currNode.parents(3).number;
%                 parWeight3 = getWeight(nodeList, parentInd3);
%                 weight(1,1) = currNode.theta(3,1)*parWeight3(1,1)+ currNode.theta(4,1)*parWeight3(2,1);
%                 weight(2,1) = currNode.theta(3,2)*parWeight3(1,1)+ currNode.theta(4,2)*parWeight3(2,1);
%             elseif dataSample(1,par1) == 2 && dataSample(1,par2) == 1 && dataSample(1,par3) == -999
%                 parentInd3 = currNode.parents(3).number;
%                 parWeight3 = getWeight(nodeList, parentInd3);
%                 weight(1,1) = currNode.theta(5,1)*parWeight3(1,1)+ currNode.theta(6,1)*parWeight3(2,1);
%                 weight(2,1) = currNode.theta(5,2)*parWeight3(1,1)+ currNode.theta(6,2)*parWeight3(2,1);
%             elseif dataSample(1,par1) == 2 && dataSample(1,par2) == 2 && dataSample(1,par3) == -999
%                 parentInd3 = currNode.parents(3).number;
%                 parWeight3 = getWeight(nodeList, parentInd3);
%                 weight(1,1) = currNode.theta(7,1)*parWeight3(1,1)+ currNode.theta(8,1)*parWeight3(2,1);
%                 weight(2,1) = currNode.theta(7,2)*parWeight3(1,1)+ currNode.theta(8,2)*parWeight3(2,1);
%             elseif dataSample(1,par1) == 1 && dataSample(1,par2) == -999 && dataSample(1,par3) == 1
%                 parentInd2 = currNode.parents(2).number;
%                 parWeight2 = getWeight(nodeList, parentInd2);
%                 weight(1,1) = currNode.theta(1,1)*parWeight2(1,1)+ currNode.theta(3,1)*parWeight2(2,1);
%                 weight(2,1) = currNode.theta(1,2)*parWeight2(1,1)+ currNode.theta(3,2)*parWeight2(2,1);
%             elseif dataSample(1,par1) == 1 && dataSample(1,par2) == -999 && dataSample(1,par3) == 2
%                 parentInd2 = currNode.parents(2).number;
%                 parWeight2 = getWeight(nodeList, parentInd2);
%                 weight(1,1) = currNode.theta(2,1)*parWeight2(1,1)+ currNode.theta(4,1)*parWeight2(2,1);
%                 weight(2,1) = currNode.theta(2,2)*parWeight2(1,1)+ currNode.theta(5,2)*parWeight2(2,1);
%             elseif dataSample(1,par1) == 2 && dataSample(1,par2) == -999 && dataSample(1,par3) == 1
%                 parentInd2 = currNode.parents(2).number;
%                 parWeight2 = getWeight(nodeList, parentInd2);
%                 weight(1,1) = currNode.theta(5,1)*parWeight2(1,1)+ currNode.theta(7,1)*parWeight2(2,1);
%                 weight(2,1) = currNode.theta(5,2)*parWeight2(1,1)+ currNode.theta(7,2)*parWeight2(2,1);
%             elseif dataSample(1,par1) == 2 && dataSample(1,par2) == -999 && dataSample(1,par3) == 2
%                 parentInd2 = currNode.parents(2).number;
%                 parWeight2 = getWeight(nodeList, parentInd2);
%                 weight(1,1) = currNode.theta(6,1)*parWeight2(1,1)+ currNode.theta(8,1)*parWeight2(2,1);
%                 weight(2,1) = currNode.theta(6,2)*parWeight2(1,1)+ currNode.theta(8,2)*parWeight2(2,1);
%             elseif dataSample(1,par1) == -999 && dataSample(1,par2) == 1 && dataSample(1,par3) == 1
%                 parentInd1 = currNode.parents(1).number;
%                 parWeight1 = getWeight(nodeList, parentInd1);
%                 weight(1,1) = currNode.theta(1,1)*parWeight1(1,1)+ currNode.theta(5,1)*parWeight1(2,1);
%                 weight(2,1) = currNode.theta(1,2)*parWeight1(1,1)+ currNode.theta(5,2)*parWeight1(2,1);
%             elseif dataSample(1,par1) == -999 && dataSample(1,par2) == 1 && dataSample(1,par3) == 2
%                 parentInd1 = currNode.parents(1).number;
%                 parWeight1 = getWeight(nodeList, parentInd1);
%                 weight(1,1) = currNode.theta(2,1)*parWeight1(1,1)+ currNode.theta(6,1)*parWeight1(2,1);
%                 weight(2,1) = currNode.theta(2,2)*parWeight1(1,1)+ currNode.theta(6,2)*parWeight1(2,1);
%             elseif dataSample(1,par1) == -999 && dataSample(1,par2) == 2 && dataSample(1,par3) == 1
%                 parentInd1 = currNode.parents(1).number;
%                 parWeight1 = getWeight(nodeList, parentInd1);
%                 weight(1,1) = currNode.theta(3,1)*parWeight1(1,1)+ currNode.theta(7,1)*parWeight1(2,1);
%                 weight(2,1) = currNode.theta(3,2)*parWeight1(1,1)+ currNode.theta(7,2)*parWeight1(2,1);
%             elseif dataSample(1,par1) == -999 && dataSample(1,par2) == 2 && dataSample(1,par3) == 2
%                 parentInd1 = currNode.parents(1).number;
%                 parWeight1 = getWeight(nodeList, parentInd1);
%                 weight(1,1) = currNode.theta(4,1)*parWeight1(1,1)+ currNode.theta(8,1)*parWeight1(2,1);
%                 weight(2,1) = currNode.theta(4,2)*parWeight1(1,1)+ currNode.theta(8,2)*parWeight1(2,1);
%             elseif dataSample(1,par1) == 1 && dataSample(1,par2) == -999 && dataSample(1,par3) == -999
%                 parentInd2 = currNode.parents(2).number;
%                 parWeight2 = getWeight(nodeList, parentInd2);
%                 parentInd3 = currNode.parents(3).number;
%                 parWeight3 = getWeight(nodeList, parentInd3);
%                 weight(1,1) = currNode.theta(1,1)*parWeight2(1,1)*parWeight3(1,1)...
%                     + currNode.theta(2,1)*parWeight2(1,1)*parWeight3(2,1)...
%                     + currNode.theta(3,1)*parWeight2(2,1)*parWeight3(1,1)...
%                     + currNode.theta(4,1)*parWeight2(2,1)*parWeight3(2,1);
%                 weight(2,1) = currNode.theta(1,2)*parWeight2(1,1)*parWeight3(1,1)...
%                     + currNode.theta(2,2)*parWeight2(1,1)*parWeight3(2,1)...
%                     + currNode.theta(3,2)*parWeight2(2,1)*parWeight3(1,1)...
%                     + currNode.theta(4,2)*parWeight2(2,1)*parWeight3(2,1);
%             elseif dataSample(1,par1) == 2 && dataSample(1,par2) == -999 && dataSample(1,par3) == -999
%                 parentInd2 = currNode.parents(2).number;
%                 parWeight2 = getWeight(nodeList, parentInd2);
%                 parentInd3 = currNode.parents(3).number;
%                 parWeight3 = getWeight(nodeList, parentInd3);
%                 weight(1,1) = currNode.theta(5,1)*parWeight2(1,1)*parWeight3(1,1)...
%                     + currNode.theta(6,1)*parWeight2(1,1)*parWeight3(2,1)...
%                     + currNode.theta(7,1)*parWeight2(2,1)*parWeight3(1,1)...
%                     + currNode.theta(8,1)*parWeight2(2,1)*parWeight3(2,1);
%                 weight(2,1) = currNode.theta(5,2)*parWeight2(1,1)*parWeight3(1,1)...
%                     + currNode.theta(6,2)*parWeight2(1,1)*parWeight3(2,1)...
%                     + currNode.theta(7,2)*parWeight2(2,1)*parWeight3(1,1)...
%                     + currNode.theta(8,2)*parWeight2(2,1)*parWeight3(2,1);
%             elseif dataSample(1,par1) == -999 && dataSample(1,par2) == 1 && dataSample(1,par3) == -999
%                 parentInd1 = currNode.parents(1).number;
%                 parWeight1 = getWeight(nodeList, parentInd1);
%                 parentInd3 = currNode.parents(3).number;
%                 parWeight3 = getWeight(nodeList, parentInd3);
%                 weight(1,1) = currNode.theta(1,1)*parWeight1(1,1)*parWeight3(1,1)...
%                     + currNode.theta(2,1)*parWeight1(1,1)*parWeight3(2,1)...
%                     + currNode.theta(5,1)*parWeight1(2,1)*parWeight3(1,1)...
%                     + currNode.theta(6,1)*parWeight1(2,1)*parWeight3(2,1);
%                 weight(2,1) = currNode.theta(1,2)*parWeight1(1,1)*parWeight3(1,1)...
%                     + currNode.theta(2,2)*parWeight1(1,1)*parWeight3(2,1)...
%                     + currNode.theta(5,2)*parWeight1(2,1)*parWeight3(1,1)...
%                     + currNode.theta(6,2)*parWeight1(2,1)*parWeight3(2,1);
%             elseif dataSample(1,par1) == -999 && dataSample(1,par2) == 2 && dataSample(1,par3) == -999
%                 parentInd1 = currNode.parents(1).number;
%                 parWeight1 = getWeight(nodeList, parentInd1);
%                 parentInd3 = currNode.parents(3).number;
%                 parWeight3 = getWeight(nodeList, parentInd3);
%                 weight(1,1) = currNode.theta(3,1)*parWeight1(1,1)*parWeight3(1,1)...
%                     + currNode.theta(4,1)*parWeight1(1,1)*parWeight3(2,1)...
%                     + currNode.theta(7,1)*parWeight1(2,1)*parWeight3(1,1)...
%                     + currNode.theta(8,1)*parWeight1(2,1)*parWeight3(2,1);
%                 weight(2,1) = currNode.theta(3,2)*parWeight1(1,1)*parWeight3(1,1)...
%                     + currNode.theta(4,2)*parWeight1(1,1)*parWeight3(2,1)...
%                     + currNode.theta(7,2)*parWeight1(2,1)*parWeight3(1,1)...
%                     + currNode.theta(8,2)*parWeight1(2,1)*parWeight3(2,1);
%             elseif dataSample(1,par1) == -999 && dataSample(1,par2) == -999 && dataSample(1,par3) == 1
%                 parentInd1 = currNode.parents(1).number;
%                 parWeight1 = getWeight(nodeList, parentInd1);
%                 parentInd2 = currNode.parents(2).number;
%                 parWeight2 = getWeight(nodeList, parentInd2);
%                 weight(1,1) = currNode.theta(1,1)*parWeight1(1,1)*parWeight2(1,1)...
%                     + currNode.theta(3,1)*parWeight1(1,1)*parWeight2(2,1)...
%                     + currNode.theta(5,1)*parWeight1(2,1)*parWeight2(1,1)...
%                     + currNode.theta(7,1)*parWeight1(2,1)*parWeight2(2,1);
%                 weight(2,1) = currNode.theta(1,2)*parWeight1(1,1)*parWeight2(1,1)...
%                     + currNode.theta(3,2)*parWeight1(1,1)*parWeight2(2,1)...
%                     + currNode.theta(5,2)*parWeight1(2,1)*parWeight2(1,1)...
%                     + currNode.theta(7,2)*parWeight1(2,1)*parWeight2(2,1);
%             elseif dataSample(1,par1) == -999 && dataSample(1,par2) == -999 && dataSample(1,par3) == 2
%                 parentInd1 = currNode.parents(1).number;
%                 parWeight1 = getWeight(nodeList, parentInd1);
%                 parentInd2 = currNode.parents(2).number;
%                 parWeight2 = getWeight(nodeList, parentInd2);
%                 weight(1,1) = currNode.theta(2,1)*parWeight1(1,1)*parWeight2(1,1)...
%                     + currNode.theta(4,1)*parWeight1(1,1)*parWeight2(2,1)...
%                     + currNode.theta(6,1)*parWeight1(2,1)*parWeight2(1,1)...
%                     + currNode.theta(8,1)*parWeight1(2,1)*parWeight2(2,1);
%                 weight(2,1) = currNode.theta(2,2)*parWeight1(1,1)*parWeight2(1,1)...
%                     + currNode.theta(4,2)*parWeight1(1,1)*parWeight2(2,1)...
%                     + currNode.theta(6,2)*parWeight1(2,1)*parWeight2(1,1)...
%                     + currNode.theta(8,2)*parWeight1(2,1)*parWeight2(2,1);
%             elseif dataSample(1,par1) == -999 && dataSample(1,par2) == -999 && dataSample(1,par3) == -999
%                 parentInd1 = currNode.parents(1).number;
%                 parWeight1 = getWeight(nodeList, parentInd1);
%                 parentInd2 = currNode.parents(2).number;
%                 parWeight2 = getWeight(nodeList, parentInd2);
%                 parentInd3 = currNode.parents(3).number;
%                 parWeight3 = getWeight(nodeList, parentInd3);
%                 weight(1,1) = currNode.theta(1,1)*parWeight1(1,1)*parWeight2(1,1)*parWeight1(1,1)...
%                     + currNode.theta(1,1)*parWeight1(1,1)*parWeight2(1,1)*parWeight1(2,1)...
%                     + currNode.theta(3,1)*parWeight1(1,1)*parWeight2(2,1)*parWeight1(1,1)...
%                     + currNode.theta(4,1)*parWeight1(1,1)*parWeight2(2,1)*parWeight1(2,1)...
%                     + currNode.theta(5,1)*parWeight1(2,1)*parWeight2(1,1)*parWeight1(1,1)...
%                     + currNode.theta(6,1)*parWeight1(2,1)*parWeight2(1,1)*parWeight1(2,1)...
%                     + currNodse.theta(7,1)*parWeight1(2,1)*parWeight2(2,1)*parWeight1(1,1)...
%                     + currNode.theta(8,1)*parWeight1(2,1)*parWeight2(2,1)*parWeight1(2,1);
%                 weight(2,1) = currNode.theta(1,2)*parWeight1(1,1)*parWeight2(1,1)*parWeight1(1,1)...
%                     + currNode.theta(1,2)*parWeight1(1,1)*parWeight2(1,1)*parWeight1(2,1)...
%                     + currNode.theta(3,2)*parWeight1(1,1)*parWeight2(2,1)*parWeight1(1,1)...
%                     + currNode.theta(4,2)*parWeight1(1,1)*parWeight2(2,1)*parWeight1(2,1)...
%                     + currNode.theta(5,2)*parWeight1(2,1)*parWeight2(1,1)*parWeight1(1,1)...
%                     + currNode.theta(6,2)*parWeight1(2,1)*parWeight2(1,1)*parWeight1(2,1)...
%                     + currNode.theta(7,2)*parWeight1(2,1)*parWeight2(2,1)*parWeight1(1,1)...
%                     + currNode.theta(8,2)*parWeight1(2,1)*parWeight2(2,1)*parWeight1(2,1);
%             end
        end            
    end
    clear('currNode', 'nodeList', 'dataSample');
end