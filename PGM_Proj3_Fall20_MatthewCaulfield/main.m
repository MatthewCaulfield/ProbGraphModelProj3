load('data_missing_500.mat')

B = struct("number", 2, "parents", [], "theta", []);
A = struct("number", 1, "parents", [], "theta", []);
D = struct("number", 4, "parents", [], "theta", []);
E = struct("number", 5, "parents", [], "theta", []);
C = struct("number", 3, "parents", [], "theta", []);

W = [0 0 0 0 0; 0 0 0 0 0; 0 0 0 0 0 ;  0 0 0 0 0; 0 0 0 0 0];

N = 5;
nodeList = [A B C D E];
for i = 1:N
    [~,numPar] =  size(nodeList(i).parents);
    nodeList(i).theta = zeros((2^(numPar)), 2) + 0.5;
end

nodeList = hillClimbEM(nodeList, data_500, W)

fprintf("\r\n")
for n =1:N
    fprintf("node "+ num2str(n) + " parents: " + ...
        num2str(parentNumbers(nodeList(n))) + "\r\n")
end
