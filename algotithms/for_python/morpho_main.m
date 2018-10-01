function [seg_image] = morpho_main(filter_number,mask,x_reconstruction_coords,y_reconstruction_coords)
        close all        
        filter_number;
        mask;
        x_reconstruction_coords
        y_reconstruction_coords
        
        marker = false(size(mask,2));
        for i=1:size(x_reconstruction_coords)
            marker(y_reconstruction_coords(i),x_reconstruction_coords(i)) = true;
        end


        if strcmp(filter_number,'1')
             [image_to_process] = reconstruct(marker,mask);
        elseif strcmp(filter_number,'2')
            [image_to_process] = fill_holes(mask);
        elseif strcmp(filter_number,'3')
            se_radius = input('enter structure element radius (example: 11):')
            
            [image_to_process] = open_by_reconst(image_to_process,se_radius);
            render_image(image_to_process);
        elseif strcmp(filter_number,'4')
            se_radius = input('enter structure element radius (example: 11):')
            
            [image_to_process] = close_by_reconst(image_to_process,se_radius);
            render_image(image_to_process);
        end
    
        [seg_image] = generate_pylist(image_to_process);
end

function [output_img] = reconstruct(marker,mask)
% figure;
% marker = roipoly(image);
% p2 = min(im2uint8(p),im1);
output_img = imreconstruct(marker,mask);
figure;
imshow(marker);
figure;
imshow(mask);
figure;
imshow(output_img)
end


function [im_filled] = fill_holes(image)
im_filled = imfill(image,'holes');
figure;
imshow(im_filled);
end

function [pylist] = generate_pylist(matrix)
      disp('pylist_from_matlab_matrix()');
      matrix = im2uint8(matrix);
      cell_matrix = num2cell(matrix);
      pylist = cell(1,size(matrix,1));

      for i= 1:size(matrix,1)
          pylist{i} = cell_matrix(i,:);
      end
end




