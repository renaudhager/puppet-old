#!/opt/puppetlabs/puppet/bin/ruby

# Variables
$port = 8141
$token = '4C30LmLSj3Cx6GEm4YbuG01oPY003yoIWh334yc49y520P3N8Q'
###########

require "webrick"

class PuppetCAWebhook < WEBrick::HTTPServlet::AbstractServlet
    def do_GET (request, response)
        response.content_type = "text/plain"
        if request.query["token"] && request.query["host"]
            if request.query["token"] == $token

                host = request.query["host"]

                # Regexp check to avoid injections
                if /^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\-]*[A-Za-z0-9])$/.match(host)
                    hosts_found = `/opt/puppetlabs/bin/puppet cert list --all | grep #{host} | wc -l`
                    if hosts_found.to_int < 1
                        response.status = 403
                        response.body = "No hosts found, exiting"
                    elsif hosts_found.to_int > 1
                        response.status = 403
                        response.body = "More than one host found, exiting"
                    else
                        host_name = `/opt/puppetlabs/bin/puppet cert list --all | grep #{host} | awk '{print $2}'  | tr -d '"'`
                        response.status = 200
                        response.body = `puppet cert clean #{host_name}`
                    end
                else
                    response.status = 403
                    response.body = "Invalid hostname"
                end
            else
                response.status = 403
                response.body = "Incorrect token"
            end
        else
            response.status = 403
            response.body = "You did not provide the correct parameters"
        end
    end
end

server = WEBrick::HTTPServer.new(:Port => $port)

server.mount "/", PuppetCAWebhook

trap("INT") {
    server.shutdown
}

server.start
