% Robert Ackerman

% Steven T. Berry (1994) "Estimating Discrete-Choice Models
% of Product Differentiation". The RAND Journal of Economics,
% Vol. 25, No. 2(Summer, 1994), pp. 242-262.

%% Step 1: Prelminary Settings
% Set Parameters:
global Beta0 Betax Alpha Sigmad x1 x2 xi1 xi2 mc
Beta0 = 5; Betax = 2; Alpha = 1; 
Gamma0 = 1; Gammax = 0.5; Gammaw = 0.25;
Sigmaomega = 0.25; Sigmac = 0.25; Sigmad = 1;

% Set initial price guesses:
p0 = [0; 0];

% Set empty vectors to be filled with results:
mc = zeros(1,2); 
X1 = zeros(1,500); X2 = zeros(1,500);
W1 = zeros(1,500); W2 = zeros(1,500);
P1 = zeros(1,500); P2 = zeros(1,500);
Q1 = zeros(1,500); Q2 = zeros(1,500);
Xi1 = zeros(1,500); Xi2 = zeros(1,500);
S0 = zeros(1,500);
Omega1 = zeros(1,500); Omega2 = zeros(1,500);
Data = zeros(1000,7);
observable_data = zeros(1000,6);
exog_data = zeros(1000,6);

%% Step 2: Data Generation and Estimation

% Set seed so results are the same each time the file is run:

defaultStream = RandStream.getGlobalStream;
defaultStream.reset(0);

% Loop for 500 duopoly markets: 
for i = 1:500;
    
% Generating the random data for each market:
    x = randn(2,4);
    x1 = x(1,1); x2 = x(2,1);
    w1 = x(1,2); w2 = x(2,2);
    xi1 = x(1,3); xi2 = x(2,3);
    omega1 = x(1,4); omega2 = x(2,4);

% Calculating the marginal costs for each firm and market: 

    mc(1,1) = exp(Gamma0 + Gammax * x1 + Sigmac * xi1 + Gammaw* w1 + Sigmaomega * omega1); 
    mc(1,2) = exp(Gamma0 + Gammax * x2 + Sigmac * xi2 + Gammaw* w2 + Sigmaomega * omega2);
    
% Solve for fhe equilibrium prices for each firm and market:  
% (Note: This line calls on the Matlab function fsolve, which minimizes 
% multiple equations of the form f(x) = 0 my adusting the parameters in 
% the second input.  In this particularr case, it is minimizing two firm 
% first order condition equations contained in the function EQPriceObj.)  

    [prices, mins] = (fsolve('EQPriceObj',p0));

% Calculate market shares for each firm and market:

    s = zeros(1,2);
    s(1,1) = (exp(Beta0 + (Betax * x1) + (Sigmad * xi1) - (Alpha * prices(1,1)))/ ... 
             (1 +exp(Beta0 + (Betax * x1) + (Sigmad * xi1) - (Alpha * prices(1,1))) + ... 
             exp(Beta0 + (Betax * x2) + (Sigmad * xi2) - (Alpha * prices(2,1)))));
    s(1,2) = (exp(Beta0 + (Betax * x2) + (Sigmad * xi2) - (Alpha * prices(2,1)))/ ... 
             (1 +exp(Beta0 + (Betax * x1) + (Sigmad * xi1) - (Alpha * prices(1,1))) + ...
             exp(Beta0 + (Betax * x2) + (Sigmad * xi2) - (Alpha * prices(2,1)))));

% Store the results for each loop in the appropriate vectors:

    X1(1,i) = x1; X2(1,i) = x2; 
    W1(1,i) = w1; W2(1,i) = w2;
    P1(1,i) = prices(1,1); P2(1,i) = prices(2,1);
    Q1(1,i) = s(1,1)*1000000; Q2(1,i) = s(1,2)*1000000;
    Xi1(1,i) = xi1; Xi2(1,i) = xi2;
    Omega1(1,i) = omega1; Omega2(1,i) = omega2;
    S0(1,i) = 1 - s(1,1) - s(1,2);
    
    

end


%% Step 3: Store the Variables in Separate CSV Files

% This loop re-shapes the data from 500 x 1 vectors into three matrices:
% 1000 x 6 for the two submission files, 1000 x 7 for the STATA file.
for i = 2:2:1000
    Data(i,1) = i/2;
    Data(i-1,1) = i/2;
    Data(i,2) = 2;
    Data(i-1,2) = 1;
    Data(i,3) = X2(1,(i/2));
    Data(i-1,3) = X1(1,(i/2));
    Data(i,4) = W2(1,(i/2));
    Data(i-1,4) = W1(1,(i/2));
    Data(i,5) = P2(1,(i/2));
    Data(i-1,5) = P1(1,(i/2));
    Data(i,6) = Q2(1,(i/2));
    Data(i-1,6) = Q1(1,(i/2));
    Data(i,7) = S0(1, (i/2));
    Data(i-1,7) = S0(1, (i/2));
    observable_data(i,1) = i/2;
    observable_data(i-1,1) = i/2;
    observable_data(i,2) = 2;
    observable_data(i-1,2) = 1;
    observable_data(i,3) = X2(1,(i/2));
    observable_data(i-1,3) = X1(1,(i/2));
    observable_data(i,4) = W2(1,(i/2));
    observable_data(i-1,4) = W1(1,(i/2));
    observable_data(i,5) = P2(1,(i/2));
    observable_data(i-1,5) = P1(1,(i/2));
    observable_data(i,6) = Q2(1,(i/2));
    observable_data(i-1,6) = Q1(1,(i/2));
    exog_data(i,1) = i/2;
    exog_data(i-1,1) = i/2;
    exog_data(i,2) = 2;
    exog_data(i-1,2) = 1;
    exog_data(i,3) = X2(1,(i/2));
    exog_data(i-1,3) = X1(1,(i/2));
    exog_data(i,4) = W2(1,(i/2));
    exog_data(i-1,4) = W1(1,(i/2));
    exog_data(i,5) = Xi2(1,(i/2));
    exog_data(i-1,5) = Xi1(1,(i/2));
    exog_data(i,6) = Omega2(1,(i/2));
    exog_data(i-1,6) = Omega1(1,(i/2));
end

% Uncomment the following lines to save the two files for submission, and the 
% one for STATA estimation

% csvwrite('STATA_data.csv', Data)  
% csvwrite('observable_data.csv', observable_data)
% csvwrite('exog_data.csv', exog_data)




