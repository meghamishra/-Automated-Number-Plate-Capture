clc
clear all

I=imread('a.jpg');
I1=uint8(zeros(size(I,1),size(I,2)));

%rgb2gray

for i=1:size(I,1)
      for j=1:size(I,2)
          I1(i,j)=0.2989*I(i,j,1)+0.2870*I(i,j,2)+0.1140*I(i,j,3);
   
      end
end

%size(I,1) means no. of rows
%size(I,2) means no. of cols


I2=double(I1);

%sobel fiter

for i=1:size(I2,1)
    for j=1:size(I2,2)
         
        if i-1<=0 && j-1<=0
            
         %Sobel mask for x-direction:
         Gx=(2*I2(i+1,j)+I2(i+1,j+1));
         %Sobel mask for y-direction:
         Gy=(I2(i+1,j+1)+2*I2(i,j+1));
        
        elseif i-1<=0 && j>1 && j<size(I2,2)
            
         %Sobel mask for x-direction:
         Gx=(I2(i+1,j-1)+2*I2(i+1,j)+I2(i+1,j+1));
         %Sobel mask for y-direction:
         Gy=((I2(i+1,j+1)+2*I2(i,j+1))-(I2(i+1,j-1)+2*I2(i,j-1)));    
         
        elseif j-1<=0 && i>1 && i<size(I2,1)
         %Sobel mask for x-direction:
         Gx=((2*I2(i+1,j)+I2(i+1,j+1))-(2*I2(i-1,j)+I2(i-1,j+1)));
         %Sobel mask for y-direction:
         Gy=(I2(i+1,j+1)+2*I2(i,j+1)+I2(i-1,j+1));
         
        elseif i+1>size(I2,1) && j+1>size(I2,2)
            
         %Sobel mask for x-direction:
         Gx=(I2(i-1,j-1)+2*I2(i-1,j));
         %Sobel mask for y-direction:
         Gy=(2*I2(i,j-1)+I2(i-1,j-1));
            
        elseif i+1>size(I2,1) && j>1 && j<size(I2,2)
            
         %Sobel mask for x-direction:
         Gx=(I2(i-1,j-1)+2*I2(i-1,j)+I2(i-1,j+1));
         %Sobel mask for y-direction:
         Gy=((2*I2(i,j+1)+I2(i-1,j+1))-(2*I2(i,j-1)+I2(i-1,j-1)));
         
        elseif j+1>size(I2,2) && i>1 && i<size(I2,1)
            
          %Sobel mask for x-direction:
          Gx=((I2(i+1,j-1)+2*I2(i+1,j))-(I2(i-1,j-1)+2*I2(i-1,j)));
          %Sobel mask for y-direction:
          Gy=(I2(i+1,j-1)+2*I2(i,j-1)+I2(i-1,j-1));
        
        elseif j>1 && j<size(I2,2) && i>1 && i<size(I2,1)          
          
         %Sobel mask for x-direction:
         Gx=((I2(i+1,j-1)+2*I2(i+1,j)+I2(i+1,j+1))-(I2(i-1,j-1)+2*I2(i-1,j)+I2(i-1,j+1)));
         %Sobel mask for y-direction:
         Gy=((I2(i+1,j+1)+2*I2(i,j+1)+I2(i-1,j+1))-(I2(i+1,j-1)+2*I2(i,j-1)+I2(i-1,j-1)));
        end
        
        %The gradient of the image
        I1(i,j)=sqrt(Gx.^2+Gy.^2);
      
    end
end

I2 = im2bw(I1,0.5);
I3=double(I2);

se=[1 1;1 1];

i=1;j=1;flag=0;flag1=0;
while 1
    for k=1:2
        for l=1:2
            if k==2 && l==2 && se(k,l)==I2(i+k-1,j+l-1)
             flag1=1;
            end    
            if se(k,l)~=I2(i+k-1,j+l-1)
            flag=1;
            end
            
            if flag==1 && flag1==1
                I3(i+k-1,j+l-1)=0;
           
            else 
                I3(i+k-1,j+l-1)=I2(i+k-1,j+l-1);
            end
        end
    end
    j=j+1;
      
    if (j+2)==size(I3,2)
        if (i+2)==size(I3,1)
          break;
        end
        i=i+1;
        j=1;
    end   
            
end
   
imshow(I2)