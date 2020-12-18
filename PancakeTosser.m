clear all; close all;
%Uncomment the try you want to run, or uncomment everything to run them all
addpath("./funcs");
addpath("./data");
% runToss('data/failures.mat', 1970, 2070, "Failed Toss");
% pause(5);
% runToss('data/oj.mat', 700, 780, "Trial Toss #1");
% pause(5);
runToss('data/perfectTossesx4.mat', 573, 693, "Trial Toss #1 (Perfect)");
% pause(5);
% runToss('data/izzie.mat', 610, 710, "Trial Toss #2 (Failure)");