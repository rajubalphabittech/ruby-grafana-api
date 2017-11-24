module MyMethods

  def MyMethods.JsonToHash(file)
    data = File.read(file)
    return data_hash = JSON.parse(data)
  end

  def MyMethods.http(url, method = 'GET', json = nil, sign = nil)

    uri = URI.parse(url)

    case method
    when 'GET'
      req = Net::HTTP::Get.new(uri)
    when 'POST'
      req = Net::HTTP::Post.new(uri)
    when 'DELETE'
      req = Net::HTTP::Delete.new(uri)
    end

    req['Accept'] = 'application/json'
    req['Content-Type'] = 'application/json'
    unless json.nil? 
      req.body = json
    end	    
    unless sign.nil? 
      req['Authorization'] = 'Bearer '+sign
    end	    

    res = Net::HTTP.start(
      uri.host,
      uri.port,
      #:use_ssl => uri.scheme == 'https',
      #:verify_mode => OpenSSL::SSL::VERIFY_NONE
      ) { |http| http.request(req) }

    #p res.body
    #p res.code
    
    return JSON.parse(res.body)
  end

end
