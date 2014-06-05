%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% NAME: tempBcsd.m
%% PROJECT: MVZ Downscaling
%% AUTHOR: Yugarshi Mondal
%% DESCRIPTION: bias corrects lgm and mid-holocene temperature series using EDCSFm
%% INPUTS: obs, hist, lgm, midH (time sereis)
%% OUTPUTS: corrected means and stdDev of lgm & midH
%%
%% HISTORY:
%% YM 05/22/2013 -- First Draft Written

function [lgmMean, midHMean, lgmStd, midHStd] = tempBcsd(obs,hist,lgm,midH)

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%% TEMPERATURE BCSD
	%% We now proceed to compute a bias corrected time series -- which is itself a beta distribution.
	%% So we compute estimates of the beta dist parameters for this new distribution. We use these 
	%% parameters to compute the stdev and mean of this distirbution bias corrected dist.
	%% 	A. Bias Correction
	%%	B. Compute Shape parameters & use them to compute distribution means and stdevs
	%%	C. Invert stdev and mean to recover statistics for bias corrected beta dist
	%% Beta Dist defs: http://www.itl.nist.gov/div898/handbook/eda/section3/eda366h.htm

	histParams = computeShapeParameters(hist);
	obsParams = computeShapeParameters(obs);

	% 1. LGM
			
		% A. Bias Correction
		lgmParams = computeShapeParameters(lgm);
		projQuantiles = Fmp_lookup(lgmParams,lgm);
		Term2 = Foc_inv(obsParams,projQuantiles);
		Term3 = Fmc_inv(histParams,projQuantiles);
		adjustedLgm = lgm + Term2 - Term3;

		% B. Compute Shape Parameter Estimates & Compute Distribution Statistics
		lgP = computeShapeParameters(adjustedLgm);
		lgmMean = lgP.p / (lgP.p + lgP.q);
		lgmStd = sqrt((lgP.p * lgP.q)/((lgP.p + lgP.q)^2*(lgP.p + lgP.q + 1)));

		% C. Adjust the old Means and Stdevs: Invert the renormalization to recover means & std devs
		lgmMean = lgmMean * (lgP.b-lgP.a) + lgP.a;
		lgmStd = sqrt(lgmStd^2*(lgP.b-lgP.a)^2);

	% 2. MidH

		% A. Bias Correction
		midHParams = computeShapeParameters(midH);
		projQuantiles = Fmp_lookup(midHParams,midH);
		Term2 = Foc_inv(obsParams,projQuantiles);
		Term3 = Fmc_inv(histParams,projQuantiles);
		adjustedMidH = midH + Term2 - Term3;

		% B. Compute Shape Parameter Estimates & Compute Distribution Statistics
		mdHP = computeShapeParameters(adjustedMidH);
		midHMean = mdHP.p / (mdHP.p + mdHP.q);
		midHStd = sqrt((mdHP.p * mdHP.q)/((mdHP.p + mdHP.q)^2*(mdHP.p + mdHP.q + 1)));

		% C. Adjust the old Means and Stdevs: Invert the renormalization to recover means & std devs
		midHMean = midHMean * (mdHP.b-mdHP.a) + mdHP.a;
		midHStd = sqrt(midHStd^2*(mdHP.b-mdHP.a)^2);

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%% NESTED HELPER FUNCTIONS
	%% 	1. Compute Shape Parameters
	%%	2. Assoicate model projections with their quantile.
	%%	3. Use model projection quantiles to find Observered Current Values
	%%	4. Use model projection quantiles to find Model Current Values.


	%% 1. Compute Shape Parameters
	function parameters = computeShapeParameters(tseries)

		% Shape Parameters are estimated via Method of Moments. MLE estimates
		% of beta and gamma distributions don't have closed form solutions and
		% would be computationally intensive to compute for the entire grid.
		parameters = struct('a',[],'b',[],'p',[],'q',[]);
		m = mean(tseries);
		s = std(tseries);

		% definitions as per Li et al, pg 7
		parameters.a = min(tseries) - .5*std(tseries);
		parameters.b = max(tseries) + .5*std(tseries);

		% source: http://www.itl.nist.gov/div898/handbook/eda/section3/eda366h.htm
		%m = mean(tseries);
		%s2 = var(tseries);
		%m = (m - parameters.a) / (parameters.b-parameters.a); % shifted mean
		%s2 = s2/(parameters.b-parameters.a)^2; % shifted var
		%parameters.p = m*((m*(1-m))/s2-1);
		%parameters.q = (1-m)*((m*(1-m))/s2-1);

		% 2.5 times slower!!
		reScaledTemps = (tseries - parameters.a)/(parameters.b - parameters.a);
		[d1 d2] = betafit(reScaledTemps);
		parameters.p = d1(1); parameters.q = d1(2);

	end

	%% 2. Assoicate model projections with their quantile.
	function projQuantiles = Fmp_lookup(params,tseries);
		% beta dist -- rescale all values so they're between 0 and 1
		reScaledTemps = (tseries - params.a)/(params.b - params.a);
		projQuantiles = betacdf(reScaledTemps,params.p,params.q);
	end

	%% 3. Use model projection quantiles to find Observered Current Values.
	function term2 = Foc_inv(obsParams,projQuantiles);
		term2 = betainv(projQuantiles,obsParams.p,obsParams.q)*(obsParams.b-obsParams.a)+obsParams.a;
	end

	%% 4. Use model projection quantiles to find Model Current Values.
	function term3 = Fmc_inv(histParams,projQuantiles);
		term3 = betainv(projQuantiles,histParams.p,histParams.q)*(histParams.b-histParams.a)+histParams.a;
	end

end
