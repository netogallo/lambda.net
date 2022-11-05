-- This file is part of Hoppy.
--
-- Copyright 2015-2022 Bryan Gardiner <bog@khumba.net>
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

module Foreign.Hoppy.Example.Generator (interfaceResult) where

import Foreign.Hoppy.Generator.Spec (
  Function,
  Interface,
  Module,
  Purity (Nonpure),
  addReqIncludes,
  ident,
  includeLocal,
  interface,
  interfaceAddHaskellModuleBase,
  makeFn,
  makeModule,
  moduleAddExports,
  moduleModify',
  moduleSetCppPath,
  moduleSetHppPath,
  toExport,
  )
import Foreign.Hoppy.Generator.Std (c_string, mod_std)
import Foreign.Hoppy.Generator.Types (objT)

interfaceResult :: Either String Interface
interfaceResult = do
  iface <- interface "example"
           [ mod_example
           , moduleModify' mod_std $ do
               moduleSetHppPath "gen_std.hpp"
               moduleSetCppPath "gen_std.cpp"
           ]
  interfaceAddHaskellModuleBase ["Foreign", "Hoppy", "Example"] iface

mod_example :: Module
mod_example =
  moduleModify' (makeModule "utils" "gen_utils.hpp" "gen_utils.cpp") $
  moduleAddExports [toExport f_reverse, toExport f_hostfxloc]

f_reverse :: Function
f_reverse =
  addReqIncludes [includeLocal "utils.hpp"] $
  makeFn (ident "reverse") Nothing Nonpure [objT c_string] $ objT c_string

f_hostfxloc :: Function
f_hostfxloc =
  addReqIncludes [includeLocal "utils.hpp"] $
  makeFn (ident "hostfxloc") Nothing Nonpure [objT c_string] $ objT c_string
