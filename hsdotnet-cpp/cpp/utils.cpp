// This file is part of Hoppy.
//
// Copyright 2015-2022 Bryan Gardiner <bog@khumba.net>
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#include "utils.hpp"

#include <algorithm>
#include <string>

#include <nethost.h>

// Header files copied from https://github.com/dotnet/core-setup
#include <coreclr_delegates.h>
#include <hostfxr.h>

std::string reverse(const std::string& str) {
    return std::string(str.rbegin(), str.rend());
}


std::string hostfxloc(const std::string& notused) {

  char_t buffer[2041];
  size_t buffer_size = sizeof(buffer) / sizeof(char_t);
  int rc = get_hostfxr_path(buffer, &buffer_size, nullptr);

  return std::string(buffer);
}
