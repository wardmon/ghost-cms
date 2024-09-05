//Thanks to the jQuery Plugin Boilerplate project (http://jqueryboilerplate.com/)
;(function ( $, window, document, undefined ) {

    // Create the defaults once
    var pluginName = "bookmarklet",
        defaults = {
            //Probably do not need to change this
            gist_api_url: "https://api.github.com/gists/",

            //Set this to request a Gist
            gist_id: undefined,
            //If your Gist contains multiple files, use this:
            gist_filename: undefined,

            //Plain JavaScript files can be loaded with this option:
            raw: undefined,

            //A callback that will be executed when the bookmarklet is created.
            //Will be given the jQuery-selected element as an argument:
            on_ready: undefined
        };

    var handlers = {
        "gist": function() {
            var gist_id = this.settings.gist_id;
            var api_url = this.settings.gist_api_url;
            var filename = this.settings.gist_filename;

            return $.getJSON(api_url + gist_id)
                .then(function(gist) {
                    var file;
                    if (filename) {
                        file = gist.files[filename];
                    } else if (Object.keys(gist.files).length === 1) {
                        file = gist.files[Object.keys(gist.files)[0]];
                    } else {
                        throw "Gist contains multiple files. Use 'gist_filename' setting to specify.";
                    }

                    return file.content;
                });
        },
        "raw": function() {
            return $.ajax({
                url: this.settings.raw,
                dataType: "text"
            });
        }
    };

    // The actual plugin constructor
    function Bookmarklet ( element, options ) {
        this.element = element;
        this.$element = $(this.element);

        //Get some settings from the element's data attributes
        var attrs = $.extend({}, {
            gist_id: this.$element.data("bookmarklet-gist-id"),
            gist_filename: this.$element.data("bookmarklet-gist-filename"),
            raw: this.$element.data("bookmarklet-raw")
        });

        this.settings = $.extend({}, defaults, attrs, options );
        this._defaults = defaults;
        this._name = pluginName;
        this.init();
    }

    Bookmarklet.prototype = {
        init: function () {
            var self = this;
            var request;
            if (this.settings.raw) {
                request = handlers.raw.call(this);
            } else if (this.settings.gist_id) {
                request = handlers.gist.call(this);
            } else {
                throw "Bookmarklet settings must include either 'gist_id' or 'raw'.";
            }

            request
                .done(function(code) {
                    self.$element.attr("href", self.build_url(code));
                    self.settings.on_ready && self.settings.on_ready(self.$element);
                })
                .fail(function(error) {
                    throw error;
                });
        },
        build_url: function(code) {
            return "javascript:" + encodeURIComponent(code);
        }
    };

    // A really lightweight plugin wrapper around the constructor,
    // preventing against multiple instantiations
    $.fn[ pluginName ] = function ( options ) {
        this.each(function() {
            if ( !$.data( this, "plugin_" + pluginName ) ) {
                $.data( this, "plugin_" + pluginName, new Bookmarklet( this, options ) );
            }
        });

        // chain jQuery functions
        return this;
    };

})( jQuery, window, document );
