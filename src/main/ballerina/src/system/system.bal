// Copyright (c) 2017 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerinax/java;
//import ballerina/io;

# Returns the environment variable value associated with the provided name.
#
# + name - Name of the environment variable
# + return - Environment variable value if it exists, else an empty string
public function getEnv(@untainted string name) returns string {
    return covertToString(nativeGetEnv(java:fromString(name)));
}

function nativeGetEnv(handle key) returns handle = @java:Method {
    name: "getEnv",
    class: "org.ballerinalang.stdlib.system.nativeimpl.GetEnv"
} external;

# Returns the current user's name.
#
# + return - Current user's name if it can be determined, else an empty string
public function getUsername() returns string {
    return covertToString(nativeGetUsername());
}

function nativeGetUsername() returns handle = @java:Method {
    name: "getUsername",
    class: "org.ballerinalang.stdlib.system.nativeimpl.GetUsername"
} external;

# Returns the current user's home directory path.
#
# + return - Current user's home directory if it can be determined, else an empty string
public function getUserHome() returns string {
    return covertToString(nativeGetUserHome());
}

function nativeGetUserHome() returns handle = @java:Method {
    name: "getUserHome",
    class: "org.ballerinalang.stdlib.system.nativeimpl.GetUserHome"
} external;

# Returns a random UUID string.
#
# + return - The random string
public function uuid() returns string {
    return covertToString(nativeUuid());
}

function nativeUuid() returns handle = @java:Method {
    name: "uuid",
    class: "org.ballerinalang.stdlib.system.nativeimpl.Uuid"
} external;

# Executes an operating system command as a subprocess of the current process.
#
# + command - The name of the command to be executed
# + env - Environment variables to be set to the process
# + dir - The current working directory to be set to the process
# + args - Command arguments to be passed in
# + return - Returns a `Process` object in success, or an `Error` if a failure occurs
public function exec(@untainted string command, @untainted map<string> env = {},
                     @untainted string? dir = (), @untainted string... args) returns Process|Error {
    handle[] nativeArgs = [];
    int j = 0;
    if (args.length() > 0) {
        while (j < args.length()) {
            nativeArgs[j] = java:fromString(args[j]);
            j = j + 1;
        }
    }
    string nativeDir = "";
    if (dir is string) {
        nativeDir = dir;
    }
    return nativeExec(java:fromString(command), env, java:fromString(nativeDir), nativeArgs);
}

function nativeExec(handle command, map<string> env, handle nativeDir, handle[] args) returns Process|Error = @java:Method {
    name: "exec",
    class: "org.ballerinalang.stdlib.system.nativeimpl.Exec"
} external;

function covertToString(handle value) returns string {
    string output = "";
    var result = java:toString(value);
    if (result is string) {
        output = result;
    }
    return output;
}
