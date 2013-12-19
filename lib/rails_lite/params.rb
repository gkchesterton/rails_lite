require 'uri'

class Params
  def initialize(req, route_params = {})
    @params = route_params
    parse_www_encoded_form(req.query_string) if req.query_string
    parse_www_encoded_form(req.body) if req.body
  end

  def [](key)
    @params[key]
  end

  def to_s
    @params.to_s
  end

  private
  def parse_www_encoded_form(www_encoded_form)
    arr = URI.decode_www_form(www_encoded_form)
    arr.each do |pair|
      key, val = pair[0], pair[1]
      keys = parse_key(key)
      @params = rmerge(@params, build_nested_hash(keys, val))
    end
  end

  def parse_key(key)
    nested_keys = key.split(/\]\[|\[|\]/)
  end


  def rmerge(hash1, hash2)
    r = {}
    hash1.merge(hash2)  do |key, oldval, newval| 
      r[key] = oldval.class == hash1.class ? rmerge(oldval, newval) : newval
    end
  end

  def build_nested_hash(keys, val)
    if keys.length == 1
      { keys[0] => val }
    else
      { keys[0] => build_nested_hash(keys[1..-1], val) }
    end
  end
end
