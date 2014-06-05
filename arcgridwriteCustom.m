%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% NAME: arcgridwriteCustom.m
%% PROJECT: MVZ Downscaling
%% AUTHOR: Yugarshi Mondal
%% DESCRIPTION: Takes matricies and writes them out to asc files
%% INPUTS: filesName - path to write asc file, Z - matrix, boxBorder - range of written asc
%% OUTPUTS: - none -
%%
%% HISTORY:
%% YM 06/04/2013 -- Created

function arcgridwrite(fileName,Z,boxBorder)

	obsDef = loadObsDef();
	runNum = boxBorder(1,1);
	dummy = boxBorder(1,2:5); boxBorder = dummy;
	lats = [boxBorder(1)*obsDef.deltaLat+obsDef.zeroLat:obsDef.deltaLat:boxBorder(2)*obsDef.deltaLat+obsDef.zeroLat];
	lons = [boxBorder(3)*obsDef.deltaLon+obsDef.zeroLon:obsDef.deltaLon:boxBorder(4)*obsDef.deltaLon+obsDef.zeroLon];

	%replace NaNs with NODATA value 
	Z(isnan(Z))=-9999;
	Z=flipud(Z);

	%define precision of output file
	dc = 4;
	dc=['%.',sprintf('%d',dc),'f'];

	fid=fopen(fileName,'wt');

	%write header
	mz = size(Z,1); nz= size(Z,2);
	fprintf(fid,'%s\t','ncols');
	fprintf(fid,'%d\n',nz);
	fprintf(fid,'%s\t','nrows');
	fprintf(fid,'%d\n',mz);
	fprintf(fid,'%s\t','xllcorner');
%fprintf(fid,[dc,'\n'],min(lons));
	fprintf(fid,[dc,'\n'],-125.020833);
	fprintf(fid,'%s\t','yllcorner');
%fprintf(fid,[dc,'\n'],min(lats));
	fprintf(fid,[dc,'\n'],24.062500333119);
	fprintf(fid,'%s\t','cellsize');
%fprintf(fid,[dc,'\n'],obsDef.deltaLat);
	fprintf(fid,[dc,'\n'],0.0083333333330444);
	fprintf(fid,'%s\t','NODATA_value');
	fprintf(fid,[dc,'\n'],-9999);


	test=repmat([dc,'\t'],1,nz); 
	test(end-1:end)='\n'; 
	%write data 
	for i=mz:-1:1 
		fprintf(fid,test,Z(i,:)); 
	end 


	fclose(fid);

end
