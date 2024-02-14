#!/usr/bin/env python3

import sys

def gen_template(module_name):
    return """module {0};

{0} uut();

initial begin
    $dumpfile("build/{0}"); //Assume in 'build' directory
    $dumpvars(0, {0});

    $finish();
end

endmodule
""".format(module_name)

if __name__ == "__main__":

    #Must specify testbench module
    if len(sys.argv) <  2:
        print("Usage: {0} <module-name>".format(sys.argv[0]))
        sys.exit(1)

    #Input the module name and produce the testbench file
    module_input = sys.argv[1]; testbench_file = module_input + ".v"

    print("[+] Generating Verilog Testbench ('{0}') template".format(testbench_file))

    #Write the test bench verilog file
    f = open(testbench_file,'w')
    f.write(gen_template(module_input))

    print("[+] Done!")
