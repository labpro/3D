in  = 25.4; // [mm/inch]

// i, j, k vector from Linear Algebra
I = [1,0,0];
J = [0,1,0];
K = [0,0,1];

O = [0,0,0];

IJ = I+J;// xy-plane
JI = I+J;// xy-plane
IK = I+K;// xz-plane
KI = I+K;// xz-plane
JK = J+K;// yz-plane
KJ = J+K;// yz-plane
IJK = I+J+K;

function Rapothem(r,n) = r*cos(180/n);
function Aapothem(a,n) = a/cos(180/n);

function Ones(length) =
    let (length = abs(length))
    (length > 0) ? [for(i=[0:length-1]) 1]:[];

function Zeros(length) =
    let (length = abs(length))
    (length > 0) ? [for(i=[0:length-1]) 0]:[];

function OnesUntil(n,length) =
    cat(Ones(n),Zeros(length-n));

function SumVector(v) = 
    v*Ones(len(v));

function SumVectorUntil(v,n) = 
    v*OnesUntil(n,len(v));

function cat(v1,v2) = [
    for(i=[0:len(v1)+len(v2)-1])
        (i < len(v1)) ?
        v1[i]         :
        v2[i-len(v1)]
];

function odd(n)  = (n%2);
function even(n) = !odd(n);

module sector(r=15,angle=30,height=1,n=5) {
    P = [
            for(i = [-1:n])
                let (t =i*angle/n)
                (i == -1)?
                [0,0]:
                r*[cos(t),sin(t)]

        ];
    linear_extrude(height) polygon(P);
}
module ring(R=20,r=15,angle=30,height=1,n=5) {
    difference() {
        sector(max(R,r),angle,height,n);
        sector(min(R,r),angle,height,n);
    }
}

module cblock(size,cx=true,cy=false,cz=false,center=false) {
    if(center)
        cube(size,center=true);
    else
    {
        // If it is a scalar
        if(size[0] == undef)
            cblock(size*IJK,cx,cy,cz,center);
        else
        {
            dx = (cx) ? -0.5*size*I : 0;
            dy = (cy) ? -0.5*size*J : 0;
            dz = (cz) ? -0.5*size*K : 0;
            tx(dx)
            ty(dy)
            tz(dz)
            cube(size);
        }
    }
}
module tx(d=0){
    translate(d*I)
    children();
}
module ty(d=0){
    translate(d*J)
    children();
}
module tz(d=0){
    translate(d*K)
    children();
}
module rx(r=0){
    rotate(r*I)
    children();
}
module ry(r=0){
    rotate(r*J)
    children();
}
module rz(r=0){
    rotate(r*K)
    children();
}
