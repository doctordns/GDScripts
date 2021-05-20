# GDScripts

A repository of Grateful Dead and Jerry Garcia band scripts  
Thomas Lee - DoctorDNS@Gmail.Com

## Introduction

This repository contains scripts I use to curate my large collection of Jerry Garcia Band
and Grateful Dead live shows.
Most of the shows in the collection are live shows - some of which I attended (but not anywhere near enough).
Other 'shows' are sound checks, private get togethers, the acid test tapes, etc.

I use these scripts to curate my collection and makes some assumptions about file locations.
I have my collection on USB drives stored in a set of folders.
The Dead and Jerry shows have a slightly different structure.
In my archive, M:\GD holds all the GD shows, with a folder for each show.
For my Jerry shows, "N:\Jerry Garcia" holds the shows with a folder for each year containing the shows for that year.
Of course, these assumptions can be changed.

## Contents

The module consists of a PowerShell module manifest and a series of individual .ps1 files.
The manifest loads each of the .ps1 files
Each .ps1 file contains a single function:

Functions provided in this module

* Get-DeadShowEncoding   - Counts the different encodings coded into the folder names for all shows.
* Get-GDFolderExtensions - Gets the final folder type (flac, etc.) for all the shows.
* Get-GDShowSizeByYear   - Gets and reports the size of the GD shows, by year.
* Get-GDShowSizeByYear   - Shows the size of each year's shows.
* Get-ToDayInHistory     - gets all the shows performed on this date and optionally opens in them in Explorer.
* Measure-GdDuplicate    - Shows how many shows are unique and how many have duplicate recordings.
* Measure-GDShows        - Counts all the GD and Jerry Shows


Enjoy - and let me know if you find these useful.

DoctorDNS@Gmail.Com
