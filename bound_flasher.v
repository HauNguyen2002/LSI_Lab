module bound_flasher(lamp,flick,clk,rst);
	output reg [15:0] lamp;
	input flick,clk,rst;
	reg [2:0] stage;
	reg [15:0] limit;
	reg running,in_rst;
	initial begin
	    stage=3'b000;
	    limit= getLimit(stage);
		lamp=0;
		running=0;
		in_rst=0;
	    stage=stage+1;
	end
	always @ (posedge clk)begin
	    if(clk) begin
	        if (!flick && !running && !in_rst);
	        else begin
	            running=1;
    	        if ((lamp==65535 && limit==0) || (lamp==0 && limit==65535) || (lamp==65535 && stage==3'b000)) lamp = limit;
    	        else begin
        	        if(lamp<limit) begin
        	            lamp=lamp<<1;
        	            lamp[0]=1;
        	        end
        	        else if(lamp>limit) begin
        	            lamp=lamp>>1;
        	        end
        	        else begin
        	            if(limit==16'b0000000000111111 && rst==1) begin
        	                stage=3'b111;
        	                limit=getLimit(stage);
        	                stage=0;
        	                in_rst=1;
        	            end
        	            else if (limit==16'b0000011111111111 && rst==1) begin
        	                stage=3'b001;
        	                limit=getLimit(stage);
        	                stage=stage+1;
        	            end
        	            else begin
            	            limit=getLimit(stage);
            	            if(stage==3'b000 && in_rst==0) running=0;
            	            else if(stage==3'b000 && in_rst==1) in_rst=0;
            	            if(stage==3'b111) stage=0;
            	            else stage=stage+1;
        	            end
        	        end
    	        end
	        end
	    end
	end
	
	
	
	
	function [15:0] getLimit(input [2:0] stage);
	    case (stage)
	    3'b000: getLimit= 16'b0000000000111111;
	    3'b001: getLimit= 16'b0000000000000000;
	    3'b010: getLimit= 16'b0000011111111111;
	    3'b011: getLimit= 16'b0000000000011111;
	    3'b100: getLimit= 16'b1111111111111111;
	    3'b101: getLimit= 16'b0000000000000000;
	    3'b110: getLimit= 16'b1111111111111111;
	    3'b111: getLimit= 16'b0000000000000000;
	   endcase
	endfunction
endmodule