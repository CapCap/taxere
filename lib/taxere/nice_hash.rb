module Taxere
  class NiceHash < Hash

    def default_proc
      @default_proc ||= Proc.new { |h, k| h[k] = Hash.new(&h.default_proc) }
    end

  end
end
