// Noah's Productivity Boost -- modified from Invisibility Cloak
// version 0.2.1
// originally Gina Trapani, modified by Noah Gibbs
// 2006-01-03, mod 2010-03-19
// Released to the public domain.
//
// ==UserScript==
// @name          Keep Noah Working
// @description   Turns off time-wasting web pages
// @include       http://flickr.com/*
// @include       http://*.flickr.com/*
// @include       http://metafilter.com/*
// @include       http://*.metafilter.com/*
// @include       http://news.ycombinator.com/*
// @include       http://*.travian.*/*
// @include       http://slashdot.org/*
// @include       http://armorgames.com/*
// @include       http://*.ninjakiwi.com/*
// @include       http://*.sinfest.net/*
// @include       http://*.fmylife.com/*
// @include       http://*.erfworld.com/*wiki*
// @include       http://*.penny-arcade.com/*
// @include       http://*.dilbert.com/*
// ==/UserScript==
//
// ==RevisionHistory==
// Invisibility Cloak Version 0.1:
// Released: 2006-01-03.
// Initial release.
//
// Invisibility Cloak Version 0.2:
// Released: 2006-01-18.
// Includes option to not apply cloak on the weekends.
//
// Keep Noah Working Version 0.3:
// Released: 2010-03-19.
// Cut down to almost nothing, more sites added.
// ==/RevisionHistory==



(function () {
    var b = (document.getElementsByTagName("body")[0]);
    b.setAttribute('style', 'display:none!important');
    alert("Begone, O Waste of Time!  Noah, get work done!");
})();