im = imread('./dataset1/im1.jpg');
im = rgb2gray(im);
[sizey,sizex] = size(im);
bits_array = zeros(1,95);
flagl = 0;
flagr = 0;
barcode_px_l = 0;
first = 1;
last = sizex;
for i = 1:sizex
    if im(round(sizey/2),i) <128 && flagl == 0
        start = i;
        flagl = 1;
    end
end
j = sizex;

while j > 0 
    if im(round(sizey/2),j) < 128 && flagr == 0
        last = j;
        flagr = 1;
    end
    j = j - 1;
end

barcode_px_l = last - first + 1;
bit_width = barcode_px_l / 95;
idx = start;
% for k = 1:95
%     c = 0;
%     for l = 0:bit_width - 1
%         temp = idx + l
%         if im(sizey/2, temp) == 0
%             c = c + 1;
%         end
%     end
%     idx = temp + 1;
%     if c >= 2
%         bits_array(k) = 1;
%     else
%         bits_array(k) = 0;
%     end
% end
    
k = start;
idx = 1;
while k < last
    l = k;
    cw = 0;
    cb = 0;
    if im(round(sizey/2), k) < 128
        while l < last
            if im(round(sizey/2),l) < 128
                cb = cb + 1;
                l = l + 1;
            else
                k = l;
                no_of_ones = round (cb / bit_width);
                for h = idx : idx + no_of_ones
                    bits_array(h) = 1;
                end
                idx = idx + no_of_ones;
                break;
            end 
        end
    else
        while l < last
            if im(round(sizey/2),l) >= 128
                cw = cw + 1;
                l = l + 1;
            else
                k = l;
                no_of_zeros = round (cw / bit_width);
                for h = idx : idx + no_of_zeros
                    bits_array(h) = 0;
                end
                idx = idx + no_of_zeros;
                break;
            end 
        end
    end
end
%Perer Cocke - lib
%V
%peter kovacy
          
        

    
    
