function HFD_matrixs_for_1_sub(sub_name,kmax)
%
%Find the addr of the epoch data(20 * 4) of the subject
epoch_basic_addr = ['f:\STUDY\Project 1_Shanshan\Epoch_data\'];
state_name = {'_Negative High ','_Negative Low ','_Positive High ','_Positive Low '};

mkdir('HFD_matrix',sub_name); 
for current_state = 1:4,    % four different states of emotions. 1:NH, 2:NL, 3:PH, 4:PL
    %start calculate HFD matrix of ONE state of one subject.(20*14).
    temp_HFD_matrix = zeros(20,14); %allocate space
    for epoch_num = 1:20,
        Vector = zeros(1,14);       %allocate space
        %--------The name and addr of the epoch we are processing---------%
        %find the name of current epoch
        epoch_num_str = num2str(epoch_num);
        current_epoch_name = [sub_name,state_name{current_state},'No.',epoch_num_str,'.mat'];
        %find the addr of current epoch
        current_epoch_addr = [epoch_basic_addr,sub_name,'\',current_epoch_name];
        %----------------Imoprt the data to the workspace-----------------%
        current_epoch = importdata(current_epoch_addr);     %current epoch should be a matrix (14*1280)
        %--calculate the HFDs according to the each row of current_epoch--%
        for row_num = 1:14,
            Vector(row_num)=HiguchiFD(current_epoch(row_num,:),kmax);
        end
        %So we got one vector,which corresponds to the current epoch
        %Every element in the vector represents the a Higuchi FD value in one channel.
        temp_HFD_matrix(epoch_num,:) = Vector;
    end
    %when you finish this loop, you got the HFD matrix:
    % -----------------------------------
    % |            channel = 1  ...  14 |
    % | epoch = 1                       |
    % |   ...                           |
    % | epoch = 20                      |
    % -----------------------------------(20*14)
    %here is the channel index:
        %  1  2  3   4   5  6 7  8  9  10 11  12 13  14
        % AF3 F7 F3 FC5 T7 P7 O1 O2 P8 T8 FC6 F4 F8 AF4    
    %save the matrix in the directory 'f:\STUDY\Project 1_Shanshan\HFD_matrix\sub_name'
    %with the name current_state_HFD_matrix_name
    current_state_HFD_matrix_name = [sub_name,state_name{current_state},'Hfd_Matrix','.mat'];
    current_state_HFD_matrix_addr = ['f:\STUDY\Project 1_Shanshan\HFD_matrix\',sub_name,'\',current_state_HFD_matrix_name];
    save(current_state_HFD_matrix_addr,'temp_HFD_matrix');
end
end

