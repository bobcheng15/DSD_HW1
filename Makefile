VLOG           = ncverilog
SRC            = hw01_pingpong.v
TB             = hw01_pingpong_t.v
VLOGARG        = +access+r
RM             = rm -f
TEMPFILE       = *.log \
				verilog.key \
				nWaveLog

all :: sim

sim:
	$(VLOG) $(TB) $(SRC) $(VLOGARG)
check:
	$(VLOG) $(SRC)
clean:
	$(RM) $(TEMPFILE)
