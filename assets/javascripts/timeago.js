// prefixAgo and suffixAgo are included by Redmine locale dictionaries.
Object.assign(jQuery.timeago.settings.strings, {
  prefixAgo: null,
  suffixAgo: null
});

jQuery(function() { jQuery("time.timeago, abbr.timeago").timeago() });
