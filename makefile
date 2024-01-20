NAME        := libcrypto.a

SRC_DIR     := src
SRCS        := $(wildcard $(SRC_DIR)/**/*.c)
INCS        := include

LIB_PATH := lib
LIBS_NAME := hexutil

LIBRARIES := $(foreach lib, $(LIBS_NAME), $(LIB_PATH)/$(LIB_PATH)$(lib)/$(LIB_PATH)$(lib).a)

BUILD_DIR   := .build
OBJS        := $(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.o, $(SRCS))
DEPS        := $(OBJS:.o=.d)

CC          := gcc
CFLAGS      := -Wall -Wextra -g -MMD -MP
CPPFLAGS    += $(foreach lib, $(LIBS_NAME), -I $(LIB_PATH)/$(LIB_PATH)$(lib)/include)


AR          := ar
ARFLAGS     := -r -c -s -v

RM          := rm -f
DIR_DUP     = mkdir -p $(@D)



all: $(LIBRARIES) $(NAME)


$(NAME): $(OBJS)
	$(info Making static library : $@)
	$(AR) $(ARFLAGS) $(NAME) $(OBJS)


$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	$(info Compiling object file : $@)
	$(DIR_DUP)
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $@

-include $(DEPS)

# Pattern rule for building libraries
$(LIB_PATH)/%.a:
	$(MAKE) -C $(@D)

clean:
	for f in $(dir $(LIBRARIES)); do $(MAKE) -C $$f clean; done
	$(RM) $(NAME)

.PHONY: clean