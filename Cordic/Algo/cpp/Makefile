# Makefile for building cordic.cpp

# Compiler and flags
CXX = g++
CXXFLAGS = -Wall -O2 -std=c++11

# Target executable name
TARGET = cordic

# Source file
SRC = cordic.cpp

# Default target
all: $(TARGET)

# Build target
$(TARGET): $(SRC)
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(SRC)

# Clean up build files
clean:
	rm -f $(TARGET)
