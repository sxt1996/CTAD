clear all;  
clc; 
close all

%% read the HSI data being processed
a = dir;   
filename_path = a.folder;     
filename_path = strcat(filename_path,'\');
name_HSI = 'AVIRIS_WTC';     

filename = strcat(filename_path,name_HSI,'.mat');

load(filename);
X_cube = data;
clear('data');
[samples,lines,band_num]=size(X_cube);
pixel_num = samples * lines;

gt = map;
clear('map');

mask = squeeze(gt(:));    



%% set parameters for the constrction of a chessboard-shaped topology 
 
column = 830;   % the number of columns on the chessboard
row = 120;    % the number of rows on the chessboard

%% perform anomaly detection with CTAD 
r_CTAD = CTAD(X_cube, column, row); 

%% illustrate detection results 
figure;
subplot(121), imagesc(gt); axis image;   title('Ground Truth')     
subplot(122), imagesc(r_CTAD); axis image;   title('Detection map of CTAD')    

%% evaluate detection results with ROC
r_255 = squeeze(r_CTAD(:));
figure;
AUC = ROC(mask,r_255,'r')       

