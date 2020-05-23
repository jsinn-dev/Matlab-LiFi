function H = matExpand(Hc, M)
%MATEXPAND performs parity-check matrix expansion by the following process
%https://www.youtube.com/watch?v=piDWLauBJ-8
%   Hc : Compact parity-check matrix
%   M : Expansion factor

[c, t] = size(Hc); % Get number of rows and columns
H = zeros(M*c,M*t); % Expanded parity-check matrix initialization

for i=0:c-1
    for j=0:t-1
        if Hc(1+i,1+j)==-1
            % If Hc(i,j)==-1, fill with zeros
            H(1+(M*i:M*(i+1)-1),1+(M*j:M*(j+1)-1)) = zeros(M,M); 
        else
            % Else fill with identity matrix rotated Hc(i,j) times
            H(1+(M*i:M*(i+1)-1),1+(M*j:M*(j+1)-1)) = circshift(eye(M),-Hc(1+i,1+j)); 
        end
    end
end
H = sparse(H);

end

