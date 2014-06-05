%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% NAME: quantileMatching.m
%% PROJECT: MVZ Downscaling
%% AUTHOR: Yugarshi Mondal
%% DESCRIPTION: This shell script either downscales precipitation or sends temperature t-series
%%			for downscaling elsewhere.
%% INPUTS: obs, hist, lgm, midH (unprocessed tseries), pptFlag, mask (depricated)
%% OUTPUTS: lgmMean (mean for lgm at that point), miHMean (mean for midH at this point), etc.
%%
%% HISTORY:
%% YM 02/27/2014 -- First Draft Written

function [lgmMean, midHMean, lgmStd, midHStd] = quantileMatch(obs,hist,lgm,midH,pptFlag)

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
		%[lgmMean, midHMean, lgmStd, midHStd, lgmNanHandled, midHNanHandled] = haibinPrecip(obs,hist,lgm,midH);
		lgmMean = mean(obs)*mean(lgm)/mean(hist);
		midHMean = mean(obs)*mean(midH)/mean(hist);
		lgmStd = std(obs)*std(lgm)/std(hist);
		midHStd = std(obs)*std(midH)/std(hist);
	else
		[lgmMean, midHMean, lgmStd, midHStd] = tempBcsd(obs,hist,lgm,midH);
	end
		
end
