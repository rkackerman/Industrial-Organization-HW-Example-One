function prices=EQPriceObj(p0)
% PURPOSE: Compute the equilibrium prices for each duopoly market
%--------------------------------------------------------------------
% USAGE: prices = EQPriceObj(p0)
% where: p0 = 2 x 1 vector of initial price guesses
%
%        Beta0 Betax Alpha Sigmad are parameters as 
%        set in Berry (1994) pp. 257-258
%
%        x1 x2 xi1 xi2 are randomly generated independent                    
%        standard normal variables
%         
%        mc is a 2 x 1 vector of calculated marginal costs
%--------------------------------------------------------------------
% RETURNS: prices   = the equilibrium prices p1 and p2
%--------------------------------------------------------------------
% Steven T. Berry (1994) "Estimating Discrete-Choice Models
% of Product Differentiation". The RAND Journal of Economics,
% Vol. 25, No. 2(Summer, 1994), pp. 242-262.
% -------------------------------------------------------------------
% Written by Robert Ackerman, UNC Chapel Hill
% Feb. 5, 2014.

global Beta0 Betax Alpha Sigmad x1 x2 xi1 xi2 mc
   
prices = [p0(1,1) - 1 / (Alpha * (1 - (exp(Beta0 + (Betax * x1) + (Sigmad * xi1) - (Alpha * p0(1,1)))/ ... 
         (1 +exp(Beta0 + (Betax * x1) + (Sigmad * xi1) - (Alpha * p0(1,1))) + exp(Beta0 + (Betax * x2) + (Sigmad * xi2) - (Alpha * p0(2,1))))))) - mc(1) ; ...
         p0(2,1) - 1 / (Alpha * (1 - (exp(Beta0 + (Betax * x2) + (Sigmad * xi2) - (Alpha * p0(2,1)))/ ... 
         (1 +exp(Beta0 + (Betax * x1) + (Sigmad * xi1) - (Alpha * p0(1,1))) + exp(Beta0 + (Betax * x2) + (Sigmad * xi2) - (Alpha * p0(2,1))))))) - mc(2)]; 

end


