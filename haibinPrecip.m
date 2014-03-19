%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% NAME: haibinPrecip.m
%% PROJECT: Bias-Corrected Spatial Disaggregation
%% AUTHOR: Yugarshi Mondal
%% DESCRIPTION: This routine bias corrects lgm and midH time series for a particular month
%%		at a particular point on the US map and returns the mean. This code was taken
%%		and edited from Haibin Li (2013)
%% INPUTS: obs, hist, lgm, midH (time sereis)
%% OUTPUTS: corrected means and stdDev of lgm & midH
%%
%% HISTORY:
%% YM 07/15/2013 -- Frist Fully Debugged Version Written

function [lgmMean, midHMean, lgmStd, midHStd] = haibinPrecip(obs,hist,lgm,midH)

	obs = tsStruct(obs); hist = tsStruct(hist); lgm = tsStruct(lgm); midH = tsStruct(midH);

	[lgmMean,lgmStd] = bcsdPrecip(obs,hist,lgm);
	[midHMean,midHStd] = bcsdPrecip(obs,hist,midH);

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%% NESTED FUNCTIONS
	%% 	1. Compute Shape Parameters
	%% 	2. Precipitation BCSD

	%% 1. Compute ts features
	function tsFeatures = tsStruct(ts)
		%dummy = squeeze(ts);
		tsFeatures = struct('tsFull',[],'ts0',[],'wet',[],'dry',[]);
		tsFeatures.tsFull = ts;
		tsFeatures.ts0 = ts(ts>0);
		tsFeatures.wet = length(tsFeatures.ts0)/length(ts);
		tsFeatures.dry = 1 - tsFeatures.wet;
	end

	%% 2. Precipitation BSD
	function [tsMean,tsStd] = bcsdPrecip(obs,modelCurrent,modelProjected)

		%% Run modelProjected thorugh mixed_gam function
		%% If there aren't enough days, set Xmp = 0 and create quantile lookup values
		if size(modelProjected.ts0,1)<8
			modelProjectedQuantile_control = rand(size(modelProjected.tsFull));
			Xmp = zeros(size(modelProjectedQuantile_control));
			modelProjectedQuantile = modelProjectedQuantile_control;
		else       
			%% 1. Find Model Projected Gamma Parameters
			[modelProjectedParams] = gamfitMOM(modelProjected.ts0);
			%% 2. Look up quantiles of each model projected in modelProjected mixed gamma dist
			modelProjectedQuantile = mixed_gamcdf(modelProjected.tsFull,modelProjectedParams,modelProjected.wet);
			%% 3. Look up the inverse quantiles in *modelProjected* distribution (*____* value is replaced in later sections)
			modelProjectedQuantile_control = (modelProjectedQuantile-modelProjected.dry)/modelProjected.wet;
			Xmp = mixed_gaminv(modelProjectedQuantile_control,modelProjectedParams);
		end

		%% Look up modelProjected in observedCurrent distribution
		if size(obs.ts0,1)<8
			%% Control for dry observation time series
			Xoc = zeros(size(modelProjectedQuantile));
		else
			[obsCurrentParams] = gamfitMOM(obs.ts0);
			obsCurrentQuantile = (modelProjectedQuantile-obs.dry)/obs.wet;
			%% 3. Look up the inverse quantiles in *observerdCurrent* distribution (*____* value is replaced in later sections)
			Xoc = mixed_gaminv(obsCurrentQuantile,obsCurrentParams);
		end

		%% Look up modelProjected in modelCurrent distribution
		if size(modelCurrent.ts0,1)<8
			Xmc = zeros(size(modelProjectedQuantile));
		else
			[modelCurrentParams] = gamfitMOM(modelCurrent.ts0);
			modelProjectedQuantile = (modelProjectedQuantile-modelCurrent.dry)/modelCurrent.wet;
			%% 3. Look up the inverse quantiles in *modelCurrent* distribution (*____* value is replaced in later sections)
			Xmc = mixed_gaminv(modelProjectedQuantile,modelCurrentParams);
		end

		%% Control for unrealistic small variability for precipitation.
		if sum(isnan(Xoc))>0
			%% This differs from Li, et al. (2010) eqn 2
			%%  this is scaled according to pg 10 paragraph 15
			biasCorrectedTS = mean(obs.tsFull+1.0e-6)/mean(Xmc+1.0e-6)*Xmp;
			if sum(biasCorrectedTS==0) && sum(obs.ts0)>0
				numObs = size(obs.tsFull,1);
				tp = min(ceil(obs.wet*numObs),numObs);
				idx = rand_int(1,numObs,tp);
				biasCorrectedTS(idx) = mean(obs.ts0)*(1+0.1*rand(size(idx))); 
			end
		else
			biasCorrectedTS = (Xmp+1.0e-6) + Xoc - (Xmc+1.0e-6);
			%biasCorrectedTS = (Xmp+1.0e-6) ./ (Xmc+1.0e-6) .* Xoc;
		end

		%% Control for unrealistic large values
		if obsCurrentParams(1)~=Inf && obsCurrentParams(2)~=Inf
		    xtrm = max(nanmax(Xoc),mixed_gaminv(0.9999,obsCurrentParams));
		else
		    xtrm = nanmax(Xoc);
		end
		biasCorrectedTS(biasCorrectedTS>5*xtrm) = Xmp(biasCorrectedTS>5*xtrm)/(nanmean(Xmc)+1.0e-6).*(nanmean(Xoc)+1.0e-6);
		biasCorrectedTS(biasCorrectedTS>5*xtrm) = 5*xtrm;

%		tsMean = mean(biasCorrectedTS); tsStd = std(biasCorrectedTS);

		[bcParams] = gamfitMOM(biasCorrectedTS([biasCorrectedTS>0]));
		rainDays = length(biasCorrectedTS([biasCorrectedTS>0]))/length(biasCorrectedTS);
		tsMean = bcParams(1)*bcParams(2);

		if tsMean < 0 || tsMean == NaN
			tsMean = 0;
		end

		tsStd = 0;

		%% Compute Mean -- this biasCorrected mean is itself! a gamma distritbution
		%% experimental mean return
%		tsStd = sqrt(bcParams(1)*bcParams(2)^2);
		%% Modify means and stdev for dry days
%		bcNoRain = length(biasCorrectedTS([abs(biasCorrectedTS)<=3]))/length(biasCorrectedTS);
%		modVar = (tsMean - tsStd)*(1-bcNoRain);
%		tsStd = tsMean - modVar;
%		tsMean = tsMean*(1-bcNoRain);
%		if tsMean < 0 || isnan(tsMean)
%			tsMean = mean(biasCorrectedTS);  %% next experiment

%			if tsMean < 0
%				tsMean = 0;
%			end
%		end
%		if tsStd < 0 || isnan(tsStd)
%			tsStd = rand;
%		end

		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		%% NESTED HELPER FUNCTIONS; PART DUEX
		%% 	1. Compute Quantiles of mixed Gamma Cdf
		%%	2. Invert mixed gamma function
		%%	3. Computer parameters of gamma function

		function [quantiles] = mixed_gamcdf(precipVals,params,wetPortion)
			%functions to get the quantile values for the mixed gamma distribution.
			quantiles = zeros(size(precipVals));
			dryPortion = 1 - wetPortion;
			if dryPortion<1.0e-6
				dryPortion=0;
			end
			idx1 = find(precipVals > 0);
			idx2 = find(precipVals <= 0);
			%quantiles(idx1) = gamcdf(precipVals(idx1),Para1,Para2);
			%This is to scale the wet portion quantile values.
			quantiles(idx1) = wetPortion*gamcdf(precipVals(idx1),params(1),params(2))+dryPortion;
			%This is to get a random # for the dry portion.
			quantiles(idx2) = dryPortion*rand(size(precipVals(idx2)));
		end


		function [scaledPrecip] = mixed_gaminv(quantiles,params)
			%functions to get the inverse F of mixed gamma distribution with considerable portion of zeros.
			scaledPrecip = zeros(size(quantiles));
			idx1 = find(quantiles>0);
			scaledPrecip(idx1) = gaminv(quantiles(idx1),params(1),params(2));
		end

		function [params] = gamfitMOM(ts)
			params = gamfit(ts);
%			m = mean(ts); s = std(ts);
%			params(1) = (m/s)^2; % shape param
%			params(2) = (s^2)/m; % scale param
		end

	end

end
