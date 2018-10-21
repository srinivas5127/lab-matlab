clc;

v = read_values("exp1.txt");
s = create_two_phase_struct(v);
disp(s);

cd = drag_coefficent(s);
gas_capacity_constraint(s,cd);
oil_capacity(s);
two_phase_result();

function gas_capacity_constraint(tp_s,cd)
    
    E = tp_s.Qg * tp_s.T * tp_s.z / tp_s.P;
    W = tp_s.pg / (tp_s.po-tp_s.pg);
    A = cd(length(cd))/tp_s.dm;
    LD = 422 * E * ((W * A)^0.5);
    disp('Gas capacity constraint');
    disp(LD);
    
end

function oil_capacity(tp_s)

    K = 1.428 * tp_s.Qo * tp_s.tr;
    disp('Oil capacity constraint');
    disp(K);
    
end 

function two_phase_result()
    for D=[30,32,34,36,38,40,42]
        Lg = (40.15/D);
        Lsg= (Lg)+(D/12);
        Lo= (8568/(D^2));
        Lso= (4*Lo)/3;
        sr= (12*Lso)/D;
        T= table( D,Lg,Lsg,Lo,Lso,sr);
        disp(T);
    end
    
end

function cd = drag_coefficent(tp_s)
    cd = zeros(10,1);
    cd(1)=0.34;
    for D=2:10
        u = 0.01186 * (((tp_s.po - tp_s.pg) / (tp_s.pg)) * (tp_s.dm / (cd(D-1))))^0.5;                                                                      
        Re = 0.0049 * ((tp_s.pg*tp_s.dm*u)/tp_s.ug);
        cd(D) = 0.34 + (3/(Re^0.5))+(24/Re);
    end
    disp("Drag Coefficients");
    disp(cd);
end 

function tp_s = create_two_phase_struct(values)
    rows = length(values{1});
    c = cell(1,2*rows);
    % converting 10 x 2 values matrix into 1 x 20 c matrix
    % pick constant name in column 1 of values and put it in odd position of c
    % pick constant value in column 2 of values and put it in even position of c    
    for row = 1:rows
        c{2*row - 1} = values{1}{row};
        c{2*row} = values{2}(row);
    end
    % Spread values of c as arguments to struct function
    tp_s = struct(c{:});
    tp_s.r0 = (141.5/(131.5+tp_s.API));
    tp_s.pg = 2.7 * ((tp_s.sg * tp_s.P)/(tp_s.T * tp_s.z));
    tp_s.po = tp_s.pw * tp_s.r0;
end

function values = read_values(file_name)
    fileID = fopen(file_name,'r');
    formatSpec = '%s=%f;';
    values = textscan(fileID, formatSpec);
    fclose(fileID);
end








