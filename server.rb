require 'sinatra'
require 'espeak'
require 'digest/sha1'

include ESpeak

set :bind, '0.0.0.0'

post '/' do
    filename = "/tmp/#{Digest::SHA1.hexdigest(params.to_s)}.mp3"
    input = request.body.string

    begin
        puts "Transcribing: #{input}"
        puts "Filename: #{filename}"
        speech = Speech.new(input, voice: 'en-uk', speed: 140, pitch: 15)
        speech.save(filename)
        [200, {'Content-type' => 'audio/mpeg'}, File.read(filename)]
    rescue Exception => e
        status 500
        return
    ensure 
        File.delete(filename)
    end
end