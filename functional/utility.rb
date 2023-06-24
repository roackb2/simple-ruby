# frozen_string_literal: true

# Basic utility functions for functional implmentations
module Utility
  def curry(method_name)
    method(method_name).curry(method(method_name).arity)
  end
end
