import re
from constants import *
from typing import List

def bin_str(x, size):
    return f'{x:0{size}b}'

def error_message(line_idx, message):
    return f"Error in line {line_idx}: {message}"

def reg_bin_str(reg1, reg2 = DEFAULT_REG):
    return bin_str(reg1, REG_SIZE) + bin_str(reg2, REG_SIZE)

def imm_bin_str(imm):
    return bin_str(imm, IMM_SIZE) if imm != None else ""

def check_imm_value(val):
    return re.match(IMM_REGEX, val) != None

def translate_opcode(opcode_string, line_index):
    
    try:
        opcode = bin_str(OPCODES[opcode_string], OPCODE_SIZE);
    except Exception as e:
        raise Exception(error_message(line_index, f'Unknown opcode: {str(e)}'))
    
    opcode_type = OpcodeType(int(opcode[0:2], 2))
    reg_or_imm = int(opcode[2], 2)
    subtype = int(opcode[3], 2)
    return opcode, opcode_type, reg_or_imm, subtype

def extract_dst(words: List[str], line_index: int):
    assert len(words) == 2 and words[1].strip(), error_message(line_index, "Should have operands")
    assert (re.match(REG_REGEX, words[1]) != None), error_message(line_index, "Incorrect register syntax")
    return int(words[1][1], 8)

def extract_2_opernads(words: List[str], line_index: int):
    assert len(words) == 2 and words[1].strip() != '', error_message(line_index, "Should have operands")
    words[1] = words[1].replace(" ", "")
    operands = words[1].split(',', 1)
    assert len(operands) == 2, error_message(line_index, "Should have 2 operands")
    return operands

def extract_dst_src(words: List[str], line_index: int):
    operands = extract_2_opernads(words, line_index)
    for opd in operands:
        assert (re.match(REG_REGEX, opd) != None), error_message(line_index, "Incorrect register syntax")
        pass
    return int(operands[0][1], 8), int(operands[1][1], 8)

def extract_dst_imm(words: List[str], line_index: int):
    operands = extract_2_opernads(words, line_index)
    assert (re.match(REG_REGEX, operands[0]) != None), error_message(line_index, "Incorrect register syntax")
    assert (re.match(IMM_REGEX, operands[1]) != None), error_message(line_index, "Incorrect Immediate value syntax")
    return int(operands[0][1], 8), int(operands[1], 16)

def extract_dst_offset_src(words: List[str], line_index: int):
    operands = extract_2_opernads(words, line_index)
    assert (re.match(REG_REGEX, operands[0]) != None), error_message(line_index, "Incorrect register syntax")
    assert (re.match(OFFSET_REG_REGEX, operands[1]) != None), error_message(line_index, "Incorrect offset(register) syntax")
    [offset, src] = operands[1][:-1].split('(', 1)
    return int(operands[0][1], 8), int(offset, 16), int(src[1], 8)

def remove_comment(line: str):
    new_line = line
    try:
        comment_start = line.index(COMMENT_SYMBOL);
        new_line = new_line[0:comment_start];
    except ValueError:
      pass
    
    return new_line