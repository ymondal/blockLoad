%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% NAME: quantileMatching.m
%% PROJECT: Bias-Corrected Spatial Disaggregation
%% AUTHOR: Yugarshi Mondal
%% DESCRIPTION: This shell script preps t-series for BCSD and sends them to appropriate scripts
%%			or returns NaN if nothing is to be computed at the point.
%% INPUTS: obs, hist, lgm, midH (unprocessed tseries), pptFlag, mask (depricated)
%% OUTPUTS: lgmMean (mean for lgm at that point), miHMean (mean for midH at this point), etc.
%%
%% HISTORY:
%% YM 02/27/2014 -- First Draft Written

function [lgmMean, midHMean, lgmStd, midHStd, lgmNanHandled, midHNanHandled] = quantileMatch(obs,hist,lgm,midH,pptFlag)

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%% PREPROCESS
	%% 1. Prep t-series
	%% 2. Check that point isn't to be masked
	%% 3. Send tsereies down to 

	%% 1. Prep
	obs = squeeze(obs); hist = squeeze(hist); lgm = squeeze(lgm); midH = squeeze(midH);

	%% 2. Check
	if isnan(sum(obs)) %% || masks.hist
		lgmMean = NaN; midHMean = NaN;
		lgmStd = NaN; midHStd = NaN;
		lgmNanHandled = NaN; midHNanHandled = NaN;
		return
	end

	%% 3. Send them down for processing
	if ~isempty(pptFlag)
		[lgmMean, midHMean, lgmStd, midHStd, lgmNanHandled, midHNanHandled] = haibinPrecip(obs,hist,lgm,midH);
	else
		[lgmMean, midHMean, lgmStd, midHStd] = tempBcsd(obs,hist,lgm,midH);
		lgmNanHandled = 0; midHNanHandled = 0;
	end
		
end
