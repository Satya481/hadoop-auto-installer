#!/bin/bash

source lib/colors.sh
source lib/logger.sh
source lib/common.sh
source lib/java.sh

banner

check_java

install_java

detect_java

configure_java
