from enum import Enum

class OpcodeType(Enum):
    NO_SINGLE_OPD   = 0b00
    DOUBLE_OPD      = 0b01
    MEM_OP          = 0b10
    CTRL_OP         = 0b11

OPCODES = {
    'NOP'   : 0x00,
    'SETC'  : 0x01,
    'CLRC'  : 0x02,
    'CLR'   : 0x10,
    'NOT'   : 0x11,
    'INC'   : 0x12,
    'NEG'   : 0x13,
    'DEC'   : 0x14,
    'OUT'   : 0x15,
    'IN'    : 0x16,
    'RLC'   : 0x17,
    'RRC'   : 0x18,
    'MOV'   : 0x40,
    'ADD'   : 0x41,
    'SUB'   : 0x42,
    'AND'   : 0x43,
    'OR'    : 0x44,
    'IADD'  : 0x65,
    'SHL'   : 0x66,
    'SHR'   : 0x67,
    'LDM'   : 0x68,
    'PUSH'  : 0x80,
    'POP'   : 0x81,
    'LDD'   : 0xB0,
    'STD'   : 0xB1,
    'RET'   : 0xC0,
    'RTI'   : 0xC1,
    'JZ'    : 0xD0,
    'JN'    : 0xD1,
    'JC'    : 0xD2,
    'JMP'   : 0xD3,
    'CALL'  : 0xD4
}

OPCODE_SIZE = 8
REG_SIZE = 4
IMM_SIZE = 16
OFFSET_SIZE = 16
DEFAULT_REG = 0b1111;

REG_REGEX = r'^[R|r][0-7]$'
IMM_REGEX = r'^[\dA-Fa-f]+$'
OFFSET_REG_REGEX = r'^\d+\([R|r][0-7]\)$'
COMMENT_SYMBOL='#'
ORG_INST = '.ORG'