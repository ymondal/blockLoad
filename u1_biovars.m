load /home/ubuntu/data/blockLoad/testData/CONUS/final/TAS_F.mat
load /home/ubuntu/data/blockLoad/testData/CONUS/final/TMAX_F.mat
load /home/ubuntu/data/blockLoad/testData/CONUS/final/TMIN_F.mat
load /home/ubuntu/data/blockLoad/testData/CONUS/final/PRECIP_F.mat

disp('loads complete, starting biovars...')

% precip by quarter (3 months)		
for i = 1:12
	d = [mod(i,12) mod(i+1,12) mod(i+2,12)]; d(d==0) = 12;
	f.lgm(:,:,i) = squeeze(sum(precip.lgm.mean(:,:,d),3));
	f.midH(:,:,i) = squeeze(sum(precip.midH.mean(:,:,d),3));
	f.obs(:,:,i) = squeeze(sum(precip.obs(:,:,d),3));
end

disp('P16. Precipitation of Wettest Quarter')
[P16.lgm.val, idx.lgm.wet] = max(f.lgm,[],3);
[P16.midH.val, idx.midH.wet] = max(f.midH,[],3);
[P16.obs.val, idx.obs.wet] = max(f.obs,[],3);
%writeAsc(16,P16,0)

disp('P17. Precipitation of Driest Quarter')
[P17.lgm.val, idx.lgm.dry] = min(f.lgm,[],3);
[P17.midH.val, idx.midH.dry] = min(f.midH,[],3);
[P17.obs.val, idx.obs.dry] = min(f.obs,[],3);
%writeAsc(17,P17,0)

disp('P8/P9')
for i = 1:3105
	for j = 1:7025
		% P8. Mean Temperature of Wettest Quarter 
		P08.lgm.val(i,j) = tas.lgm.mean(i,j,idx.lgm.wet(i,j));
		P08.midH.val(i,j) = tas.midH.mean(i,j,idx.midH.wet(i,j));
		P08.obs.val(i,j) = tas.obs(i,j,idx.obs.wet(i,j));

		% P9. Mean Temperature of Driest Quarter 
		P09.lgm.val(i,j) = tas.lgm.mean(i,j,idx.lgm.dry(i,j));
		P09.midH.val(i,j) = tas.midH.mean(i,j,idx.midH.dry(i,j));
		P09.obs.val(i,j) = tas.obs(i,j,idx.obs.dry(i,j));
	end
end
%writeAsc(8,P08,0)
%writeAsc(9,P09,0)

% temp by quarter (3 months)		
for i = 1:12
	d = [mod(i,12) mod(i+1,12) mod(i+2,12)]; d(d==0) = 12;
	f.lgm(:,:,i) = squeeze(sum(tas.lgm.mean(:,:,d),3));
	f.midH(:,:,i) = squeeze(sum(tas.midH.mean(:,:,d),3));
	f.obs(:,:,i) = squeeze(sum(tas.obs(:,:,d),3));
end

disp('P10 Mean Temperature of Warmest Quarter')
[P10.lgm.val, idx.lgm.warm] = max(f.lgm,[],3);
[P10.midH.val, idx.midH.warm] = max(f.midH,[],3);
[P10.obs.val, idx.obs.warm] = max(f.obs,[],3);
%writeAsc(10,P10,0)

disp('P11 Mean Temperature of Coldest Quarter')
[P11.lgm.val, idx.lgm.cool] = min(f.lgm,[],3);
[P11.midH.val, idx.midH.cool] = min(f.midH,[],3);
[P11.obs.val, idx.obs.cool] = min(f.obs,[],3);
%writeAsc(11,P11,0)

disp('P18/P19')
for i = 1:3105
	for j = 1:7025
		% P18. Precipitation of Warmest Quarter 
		P18.lgm.val(i,j) = precip.lgm.mean(i,j,idx.lgm.warm(i,j));
		P18.midH.val(i,j) = precip.midH.mean(i,j,idx.midH.warm(i,j));
		P18.obs.val(i,j) = precip.obs(i,j,idx.obs.warm(i,j));

		% P19. Precipitation of Coldest Quarter
		P19.lgm.val(i,j) = precip.lgm.mean(i,j,idx.lgm.cool(i,j));
		P19.midH.val(i,j) = precip.midH.mean(i,j,idx.midH.cool(i,j));
		P19.obs.val(i,j) = precip.obs(i,j,idx.obs.cool(i,j));
	end
end
%writeAsc(18,P18,0)
%writeAsc(19,P19,0)

disp('P1. Annual Mean Temperature')
P01.lgm.val = mean(tas.lgm.mean,3);
P01.midH.val = mean(tas.midH.mean,3);
P01.obs.val = mean(tas.obs,3);
%writeAsc(1,P01,0)

disp('P2. Mean Diurnal Range(Mean(period max-min)')
P02.lgm.val = mean(tmax.lgm.mean - tmin.lgm.mean,3);
P02.midH.val = mean(tmax.midH.mean - tmin.midH.mean,3);
P02.obs.val = mean(tmax.obs - tmin.obs,3);
%writeAsc(2,P02,0)

disp('P4. Temperature Seasonality (standard deviation)')
P04.lgm.val = std(tas.lgm.mean,[],3);
P04.midH.val = std(tas.midH.mean,[],3);
P04.obs.val = std(tas.obs,[],3);
%writeAsc(4,P04,0)

disp('P5. Max Temperature of Warmest Period')
[P05.lgm.val,P05.lgm.idx] = max(tmax.lgm.mean,[],3);
[P05.midH.val,P05.midH.idx] = max(tmax.midH.mean,[],3);
[P05.obs.val,P05.obs.idx] = max(tmax.obs,[],3);
%writeAsc(5,P05,1)

disp('% P6. Min Temperature of Coldest Period')
[P06.lgm.val,P06.lgm.idx] = min(tmin.lgm.mean,[],3);
[P06.midH.val,P06.midH.idx] = min(tmin.midH.mean,[],3);
[P06.obs.val,P06.obs.idx] = min(tmin.obs,[],3);
%writeAsc(6,P06,1)

disp('% P7. Temperature Annual Range (P5-P6)')
P07.lgm.val = P05.lgm.val - P06.lgm.val;
P07.midH.val = P05.midH.val - P06.midH.val;
P07.obs.val = P05.obs.val - P06.obs.val;
%writeAsc(7,P07,0)

disp('% P3. Isothermality (P2 / P7)')
P03.lgm.val = P02.lgm.val ./ P07.lgm.val;
P03.midH.val = P02.midH.val ./ P07.midH.val;
P03.obs.val = P02.obs.val ./ P07.obs.val;
writeAsc(3,P03,0)

disp('% P12. Annual Precipitation')
P12.lgm.val = sum(precip.lgm.mean,3);
P12.midH.val = sum(precip.midH.mean,3);
P12.obs.val = sum(precip.obs,3);
writeAsc(12,P12,0)

disp('% P13. Precipitation of Wettest Period')
[P13.lgm.val,P13.lgm.idx] = max(precip.lgm.mean,[],3);
[P13.midH.val,P13.midH.idx] = max(precip.midH.mean,[],3);
[P13.obs.val,P13.obs.idx] = max(precip.obs,[],3);
writeAsc(13,P13,1)

disp('% P14. Precipitation of Driest Period')
[P14.lgm.val,P14.lgm.idx] = min(precip.lgm.mean,[],3);
[P14.midH.val,P14.midH.idx] = min(precip.midH.mean,[],3);
[P14.obs.val,P14.obs.idx] = min(precip.obs,[],3);
writeAsc(14,P14,1)

disp('% P15. Precipitation Seasonality(Coefficient of Variation) ')
P15.lgm.val = P04.lgm.val ./ (1 + P12.lgm.val/12);
P15.midH.val =  P04.midH.val ./ (1 + P12.midH.val/12);
P15.obs.val = P04.obs.val ./  (1 + P12.obs.val/12);
writeAsc(15,P15,0)

disp('clean up and save...')
clear f precip tas tmin tmax
save('/home/ubuntu/data/blockLoad/testData/CONUS/final/biovars/biovars.mat','-v7.3')
