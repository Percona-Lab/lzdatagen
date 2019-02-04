
local ffi = require("ffi")

ffi.cdef[[
void init_lzdgen(uint64_t seed);
void lzdg_generate_data(void *ptr, size_t size, double ratio, double len_exp, double lit_exp);
]]

local lzdg=ffi.load("./liblzdgen.so")

lzdg.init_lzdgen(0);

function gen_data(len,ratio,lexp,mexp)
  local buf = ffi.new("char[?]", len)
  lzdg.lzdg_generate_data(buf, len, ratio, lexp, mexp)
  return ffi.string(buf,len)
end

out_file="test.lzdgen.bin"

file = io.open(out_file, "w")
io.output(file)
for i=1,100,1 do
  io.write(gen_data(20,3.0,3.0,3.0))
end
io.close(file)
