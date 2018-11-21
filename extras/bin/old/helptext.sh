#!/bin/bash

cmd=$1

{
	{
		$cmd --help >/dev/null 2>/dev/null && \
		$cmd --help
	} || \
	{
		$cmd -h >/dev/null 2>/dev/null && \
		$cmd -h
	}
}
