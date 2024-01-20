#ifndef __BASE64_h__
#define __BASE64_h__

#include <stdio.h>
#include <stdlib.h>

#include "hex_util.h"

RawByte *base64_encode(const char *base64_string);
RawByte *base64_decode(const char *base64_string);
#endif