module bound_flash(lamp,flick,clk);
	output reg [15:0] lamp;
	input flick,clk;
	reg [4:0] idx;
	reg [7:0] limit;
	reg run, final;
	initial begin 
	run=0;
	final=0;
	idx=0;
	limit=8'b00000101;
	
	end
	always @ (posedge clk) begin
	    if(flick == 1) run=1;
	    if(run==1) begin
	        case (limit)
	         
	            8'b00000101:begin // 0 5
    	            lamp[idx]=1;
    	            idx=idx+1;
    	            if(idx>limit[3:0]) begin
        	            idx=limit[3:0];
        	            limit=8'b10100000;
    	            end
	            end
	            
	            8'b10100000:begin // 10 0
    	            lamp[idx]=0;
    	            idx=idx-1;
    	            if(idx<limit[3:0] || idx[4]) begin
        	            idx=limit[3:0];
        	            limit=8'b00001010;
    	            end
	            end
	            
	            8'b00001010:begin // 5 10
    	            lamp[idx]=1;
    	            idx=idx+1;
    	            if(idx>limit[3:0]) begin
    	                idx=limit[3:0];
    	                if(flick) limit=8'b10100000;
    	                else limit=8'b11110101;
    	            end
	            end
	            
	            8'b11110101:begin // 15 5
    	            lamp[idx]=0;
    	            idx=idx-1;
    	            if(idx<limit[3:0])begin
        	            idx=limit[3:0];
        	            limit=8'b00001111;
    	            end
	            end
	            
	            8'b00001111:begin// 0 15
    	            lamp[idx]=1;
    	            idx=idx+1;
    	            if(idx>limit[3:0] || idx[4])begin
				        idx=limit[3:0];
        	            limit=8'b11110000;
			        end
	            end
	            
	            8'b11110000:begin//15 0
    	            lamp[idx]=0;
    	            idx=idx-1;
    	            if(idx<limit[3:0] || idx[4])begin
    	                idx=limit[3:0];
    	                limit=8'b11111111;
    	            end
	            end
	            8'b11111111:begin
                    if(final) begin 
                    lamp=0;
                    limit=0;
                    end
                    else begin
                    lamp=65535;
                    final=1;
                    end
                    
	            end
	            default:begin
    	            run=0;
    	            final=0;
    	            limit=5;
    	            idx=0;
	            end
	        endcase
	    end
	end
endmodule