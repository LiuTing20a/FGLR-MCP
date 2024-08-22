
%% MCP
function H = correcH(x,r1,r2)
temp = r1*r2;
Nwayx = size(x);
H = zeros(Nwayx);
x = x(:);
l = length(x);
for i = 1:l
   if abs(x(i))<= temp
      H(i) = (1/r2) * x(i);
   else
       if abs(x(i))> temp
            H(i) = r1 * sign(x(i));
       end
   end
   H = reshape(H,Nwayx);
end



           










