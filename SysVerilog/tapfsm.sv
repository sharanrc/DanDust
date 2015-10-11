

module tap (
            input reset_b,
            input tms,
            input clk,
            output sl_DR,
            output sl_IR,
            output c_DR,
            output c_IR,
            output sh_DR,
            output sh_IR,
            output u_DR,
            output u_IR
            );

wire [7:0] out_sig;
assign out_sig = {sl_DR,sl_IR,c_DR,c_IR,sh_DR,sh_IR,u_DR,u_IR};

    parameter   trst = 0,
                idle = 1,
                sel_DR = 2,
                cap_DR = 3,
                shi_DR = 4,
                exi1_DR = 5,
                pau_DR = 6,
                exi2_DR = 7,
                upd_DR = 8,
                sel_IR = 9,
                cap_IR = 10,
                shi_IR = 11,
                exi1_IR = 12,
                pau_IR = 13,
                exi2_IR = 14,
                upd_IR = 15;

reg [15:0] p_state,n_state;

always_ff@(negedge clk or negedge reset_b)
begin
    p_state = 'b0;
    if(!reset_b)
        p_state[trst] <= 1'b1;
    else
        p_state <= n_state;
end

always_cc(p_state)
begin
    n_state = 'b0;
    out_sig = 'b0;
    case(1'b1)
        p_state[trst]:   begin
                            if(tms==1'b1)
                            n_state[trst] = 1'b1;

                            else
                            n_state[idle] = 1'b1;
                        end
        p_state[idle]:   begin
                            if(tms == 1'b1)
                                n_state[sel_DR] = 1'b1;
                            else
                                n_state[idle] = 1'b1;
                        end
        p_state[sel_DR]: begin
                            if(tms == 1'b1)
                                n_state[sel_IR]=1'b1;
                            else
                                n_state[cap_DR] = 1'b1;
                        end
        p_state[cap_IR]: begin
                            if(tms == 1'b1)
                                n_state[exi1_DR] = 1'b1;
                            else
                                n_state[shi_DR] = 1'b1;
                        end
        p_state[shi_DR]: begin
                            if(tms==1'b1)
                                n_state[exi1_DR] = 1'b1;
                            else
                                n_state[shi_DR] = 1'b1;
                        end
        p_state[exi1_DR]: begin
                            if(tms == 1'b1)
                                n_state[upd_DR] = 1'b1;
                            else
                                n_stat[pau_DR] = 1'b1;
                        end
        p_state[pau_DR]: begin
                            if(tms==1'b1)
                                n_state[exi2_DR] = 1'b1;
                            else
                                n_state[pau_DR] = 1'b1;
                        end
        p_state[exi2_DR]: begin
                            if(tms==1'b1)
                                n_state[upd_DR] = 1'b1;
                            else
                                n_state[shi_DR] = 1'b1;
                        end
        p_state[upd_DR]: begin
                            if(tms==1'b1)
                                n_state[sel_DR] = 1'b1;
                            else
                                n_state[idle] = 1'b1;
                        end
        p_state[sel_IR]: begin
                            if(tms==1'b1)
                                n_state[trst] = 1'b1;
                            else
                                n_state[cap_IR] = 1'b1;
                        end
        p_state[cap_IR]: begin
                            if(tms==1'b1)
                                n_state[exi1_IR] = 1'b1;
                            else
                                n_state[shi_IR] = 1'b1;
                        end
        p_state[shi_IR]: begin
                            if(tms==1'b1)
                                n_state[exi1_IR] = 1'b1;
                            else
                                n_state[shi_IR] = 1'b1;
                        end
        p_state[exi1_IR]: begin
                            if(tms==1'b1)
                                n_state[upd_IR] = 1'b1;
                            else
                                n_state[pau_IR] = 1'b1;
                        end
        p_state[pau_IR]: begin
                            if(tms==1'b1)
                                n_state[exi2_IR] = 1'b1;
                            else
                                n_state[pau_IR] = 1'b1;
                        end
        p_state[exi2_IR]: begin
                            if(tms==1'b1)
                                n_state[upd_IR] = 1'b1;
                            else
                                n_state[shi_IR] = 1'b1;
                        end
        p_state[upd_IR]: begin
                            if(tms==1'b1)
                                n_state[sel_DR] = 1'b1;
                            else
                                n_state[idle] = 1'b1;
                        end
        default: n_state[trst]=1'b1;
    endcase
end

always_cc(p_state)
begin
    case (1'b1)
        p_state[trst]: out_sig = 'b0;
        p_state[idle]: out_sig = 'b0;
        p_state[]
