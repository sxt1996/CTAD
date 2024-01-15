 function  [result_2D] = CTAD(X_cube,column,row)
% paper:¡¶Hyperspectral Anomaly Detection Based on Chessboard Topology¡·
% Input:
% X_cube£ºan HSI being processed; column:the number of columns on the chessboard; row: the number of rows on the chessboard 
% Output:
% result_2D: detection results


 
[samples,lines,band_num]=size(X_cube);
pixel_num = samples * lines;
X_use = reshape(X_cube,pixel_num,band_num);
X = X_use.'; 
clear('X_cube', 'X_use');


X_ave = mean(X,2);






%% vertical division for spatial disassembly
chessboard_card1 = [];
chessboard_cenvalue1 = [];
for i = 1:band_num
    X_dim = X(i,:);    
    [chessboard_i, X_dim_cen_i] = hist(X_dim, column);    
    chessboard_card1 = [chessboard_card1; chessboard_i];
    chessboard_cenvalue1 = [chessboard_cenvalue1; X_dim_cen_i];
end
[band_dis_X_ave, chessboard_cenvalue_X_ave] = hist(X_ave, row);


%% perform target detection


result = zeros(1, pixel_num);


for i = 1:pixel_num
    x = X(:,i);   
         
     [band_dis_x, chessboard_cenvalue_x] = hist(x,row);
     band_dis_diff_ave_global = abs(band_dis_x - band_dis_X_ave);
        
    anomaly_score = 0;
      
    x_level = 0;
    x_card_set = [];
    x_index_set = [];
    X_ave_card_set = [];
    X_ave_index_set = [];
    use = [];
    for j = 1:band_num    
        a = x(j);
        b = X_ave(j);
        chessboard_card_j = chessboard_card1(j,:);
        [x_max_j_cardinality,index_max] = max(chessboard_card_j);
        X_dim_cen_j = chessboard_cenvalue1(j,:);
        

        
        
        [~, index] = min(abs(X_dim_cen_j(:) - a));
        x_index_set = [x_index_set, index];
        x_j_cardinality = chessboard_card1(j, index);
        if x_j_cardinality == 0
            x_j_cardinality=1;
        end 
        x_card_set = [x_card_set,x_j_cardinality];
 
        
        
        
        [~, index_ave] = min(abs(X_dim_cen_j(:) - b));
        X_ave_index_set = [X_ave_index_set, index_ave];
        X_ave_j_cardinality = chessboard_card1(j, index_ave);
        X_ave_card_set = [X_ave_card_set, X_ave_j_cardinality];        
             
    end

    
        hi = 0;
        card_dis_diff_ave_global = [];
        % horizontal division for spectral disassembly
            for n = 1:row
                band_dis_X_ave_n = band_dis_X_ave(n);
                chessboard_cenvalue_X_ave_n = chessboard_cenvalue_X_ave(n);
                band_dis_x_n = band_dis_x(n);
                chessboard_cenvalue_x_n = chessboard_cenvalue_x(n);
         
         [~,x_index_n] = sort(abs(x - chessboard_cenvalue_x_n)); 
         
            if band_dis_x_n == 0
                score = 0;
            else
                x_index_n = x_index_n(1:band_dis_x_n);     
                x_n_cardinality = sum(x_card_set(x_index_n));
                [x_n_cardinality_min, min_po] = min(x_card_set(x_index_n));  
                min_band = x_index_n(min_po);     
                [x_n_cardinality_max, max_po] = max(chessboard_card1(min_band,:));    
                score = x_n_cardinality_max/x_n_cardinality_min;

            end
         
         [~,X_ave_index_n] = sort(abs(X_ave - chessboard_cenvalue_X_ave_n)); 
            X_ave_index_n = X_ave_index_n(1:band_dis_X_ave_n);
            X_ave_n_cardinality = sum(X_ave_card_set(X_ave_index_n));            
        
        card_dis_diff_ave_global = [card_dis_diff_ave_global,abs(x_n_cardinality - X_ave_n_cardinality)];
     
        anomaly_score = anomaly_score + score;
           end

         result(i) = anomaly_score * norm(band_dis_diff_ave_global,1) * norm(card_dis_diff_ave_global,1);     
        
end   
 
r_255 = get_255(result);   
result_2D = reshape(r_255, samples, lines);   
     
end



