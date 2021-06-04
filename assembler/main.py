import sys
from helpers import *
from constants import DEFAULT_REG, OpcodeType, COMMENT_SYMBOL

def translate(line: str, line_index: int, out_index: int):
    # Output containers
    src_reg, dst_reg = DEFAULT_REG, DEFAULT_REG
    imm = None
    tokens = []

    # Split to opcode and operands
    words = line.rstrip('\n').split(" ", 1)

    # Check org
    if (words[0].upper() == ORG_INST):
        for _ in range(out_index, int(words[1].replace(" ", ""), 16)):
            tokens.append(bin_str(0, 16))
    
    # Check imm value
    # Just the check that the words are 1 only is good as we don't have any 0-opd instruction that confuse with hex
    elif (check_imm_value(words[0]) and len(words) == 1):
        tokens.append(bin_str(int(words[0], 16), 16))

    # Translate opcode
    else:
        opcode, opcode_type, reg_or_imm, subtype = translate_opcode(words[0].upper(), line_index)
        # No or Single Operand
        if (opcode_type == OpcodeType.NO_SINGLE_OPD):
            if (subtype == 1):
                dst_reg = extract_dst(words, line_index)
            pass
        
        # Double operand
        elif (opcode_type == OpcodeType.DOUBLE_OPD):
            # Reg, Reg
            if (reg_or_imm == 0):
                dst_reg, src_reg = extract_dst_src(words, line_index)
            # Reg, Imm
            else:
                dst_reg, imm = extract_dst_imm(words, line_index)
                src_reg = dst_reg
            pass
        
        # Memory operation
        elif (opcode_type == OpcodeType.MEM_OP):
            # 1-opd
            if (subtype == 0):
                dst_reg = extract_dst(words, line_index)    
            # 2-opds w/ offset
            else:
                dst_reg, imm, src_reg = extract_dst_offset_src(words, line_index)

        # Control operation
        elif (opcode_type == OpcodeType.CTRL_OP):
            raise Exception(error_message(line_index, "Control operations are not implemented"))

        # Unknown opcode
        else :
            raise Exception(error_message(line_index, "Unknown Opcode Type"))

        tokens.append(opcode + reg_bin_str(dst_reg, src_reg))
        tokens.append(imm_bin_str(imm))
    return tokens


if len(sys.argv) != 3:
    print("Invalid arguments")
    sys.exit(-1);

in_file_name = sys.argv[1];
out_file_name = sys.argv[2];

try:
    out_list = []
    token_count = 0
    with open(in_file_name, 'r') as inf, open(out_file_name, 'w') as outf:
        lines = inf.readlines()
        
        for i, line in enumerate(lines):
            # Ignore empty lines
            if (line == '\n'):
                continue
            
            # Removing comments and trailing WSs
            line = remove_comment(line)
            line = line.strip()
            if (line == ''):
                continue
            
            tokens = translate(line, i+1, token_count)
            for token in tokens:
                if (token != ""):
                    token_count+=1
                    out_list.append(token + '\n')
                            
        outf.writelines(out_list);
except Exception as e:
    print(e)
    exit(-1)