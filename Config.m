%% %%%%%%%%% A MODIFIER %%%%%%%%%
%Information block size
% K = 960, 4320
K = 960;

% Code rate
% code_rate = '1/2','2/3','5/6'
code_rate = '1/2';

% Espacement des sous-porteuses
% k = 1,2,4,8,16,32,64; F_SC=k*24.4140625 kHz
k = 8; %LC Optimized mode

% Nombre de sous-porteuses
% N = 256,1024,2048,4096
N = 256;

% Atténuation du signal de sortie
% Echelle linéaire
A = 10;

%% GENERAL %%%% NE PAS MODIFIER
% Espacement des sous-porteuses (Hz)
F_SC = 24414.0625*k;

% Bande passante (Hz)
BW = F_SC*N;

% Facteur de surechantillonnage
R = 4;

%% CYCLIC PREFIX %%%% NE PAS MODIFIER
N_CP = N/4; 

%% FREQUENCY UP-SHIFT %%%% NE PAS MODIFIER
% Frequency up-shift (Hz)
Delta = 9e6;    % Compense l'élargissement de la bande passante
                % dû au préfixe cyclique
F_US = BW/2 + Delta;

%% LDPC ENCODER %%%% NE PAS MODIFIER
if strcmp(code_rate,'1/2')
    N_FEC = 2*K; %Number of output bits
    if K==960
        load('ParityCheckMatrices/H_1_2_S');
        Hc = H_1_2_S;
    else
        load('ParityCheckMatrices/H_1_2_L');
        Hc = H_1_2_L;
    end
elseif strcmp(code_rate,'2/3')
    N_FEC = 3*K/2; %Number of output bits
    if K==960
        load('ParityCheckMatrices/H_2_3_S');
        Hc = H_2_3_S;
    else
        load('ParityCheckMatrices/H_2_3_L');
        Hc = H_2_3_L;
    end
elseif strcmp(code_rate,'5/6')
    N_FEC = 6*K/5; %Number of output bits
    if K==960
        load('ParityCheckMatrices/H_5_6_S');
        Hc = H_5_6_S;
    else
        load('ParityCheckMatrices/H_5_6_L');
        Hc = H_5_6_L;
    end
end

% Parity-check matrix expansion
[c, t] = size(Hc); % Get number of rows and columns
M = N_FEC/t; % Expansion factor
H = matExpand(Hc, M);











