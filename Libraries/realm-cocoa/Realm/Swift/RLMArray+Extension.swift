////////////////////////////////////////////////////////////////////////////
//
// Copyright 2014 Realm Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
////////////////////////////////////////////////////////////////////////////

extension RLMArray: Sequence {

    // Support Sequence-style enumeration

    func generate() -> GeneratorOf<RLMObject> {
        var i  = 0
        return GeneratorOf<RLMObject>({
            if (i >= self.count) {
                return .None
            } else {
                return self[i++] as? RLMObject
            }
        })
    }

    // Swift query convenience functions

    func indexOfObjectWhere(predicateFormat: String, _ args: CVarArg...) -> Int {
        return indexOfObjectWhere(predicateFormat, args: getVaList(args))
    }

    func objectsWhere(predicateFormat: String, _ args: CVarArg...) -> RLMArray {
        return objectsWhere(predicateFormat, args: getVaList(args))
    }
}
