return {
      'numToStr/Comment.nvim', -- "gc" to comment visual regions/lines 
      lazy = false,
      config = function ()
        require("Comment").setup()
      end
}
