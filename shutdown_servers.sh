#!/bin/bash
kill `ps ux | grep redis-server | awk '{print $2}'`
