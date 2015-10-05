

module tap (input tdi,
            input reset_b,
            input tms,
            input clk,
            output tdo);

    parameter   trst = 4'b0000,
                idle = 4'b0001,
                sel_DR = 4'b0011,
                cap_DR = 4'b0010,
                shi_DR = 4'b0110,
                exi1_DR = 4'b0111,
                pau_DR = 4'b0101,
                exi2_DR = 4'b0100,
                upd_DR = 4'b1100,
                sel_IR = 4'b1101,
                cap_IR = 4'b1111,
                shi_IR = 4'b1110,
                exi1_IR = 4'b1010,
                pau_IR = 4'b1011,
                exi2_IR = 4'b1001,
                upd_IR = 4'b1000;

reg [3:0] p_state,n_state;
reg [7:0] idcode,idcode_shift,mbist,mbist_shift;
reg [2:0] irreg,irreg_shift;
reg [0:0] bypass_shift;
wire drmuxout;

always_ff@(negedge clk or negedge reset_b)
begin
    if(!reset_b)
        p_state = idle;
    else
        p_state = n_state;
end

always_ff@(posedge clk)
    
    case(p_state)
        trst:   begin
                if(tms==1'b1)
                    n_state=trst;
                else
                    n_state=idle;
                end
        idle:   begin
                if(tms==1'b1)
                    n_state=sel_DR;
                else
                    n_state = idle;
                end
        sel_DR: begin
                if(tms==1'b1)
                    n_state = sel_IR;
                else
                    n_state = cap_DR;
                case (irreg)
                3'b000: begin
                        bypass_shift <= tdi;
                        drmuxout <= bypass_shift;
                3'b001: begin
                        idcode_shift[7]<=tdi;
                        drmuxout<= idcode_shift[0];
                        end
                3'b010: begin
                        mbist_shift[7] <= tdi;
                        drmuxout <= mbist_shift[0];
                default:
                        drmuxout <= 'bxxxxxxxxx;




