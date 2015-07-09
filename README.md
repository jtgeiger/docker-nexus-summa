# docker-nexus-summa
## Dockerized version of Sonatype Nexus OSS

### Build the Docker image
- Clone this repo: `git clone https://github.com/jtgeiger/docker-nexus-summa.git docker-nexus-summa`
- Change into the directory: `cd docker-nexus-summa`
- Build a Docker image from the Dockerfile.  Give it a tag e.g. jtgeiger/nexus:1.  `sudo docker build -t jtgeiger/nexus:1 .` (Note the trailing period!)
- Confirm that the image is built by checking the output of `sudo docker images`

### Running
- Nexus stores its data in /opt/sonatype-work.  Map this directory to a data-only container, so that the data can be preserved even if the server container is changed: `sudo docker run -v /opt/sonatype-work --name nexus_data -d jtgeiger/nexus:1 echo "Data-only container"`
- Start the server container, using the data container we just defined.  Also create a port mapping so that the container's exposed port 8081 will be reachable on port 50001 (chosen arbitrarily): `sudo docker run --volumes-from nexus_data -p 50001:8081 --name nexus -d jtgeiger/nexus:1`
- Use a web browser to connect to the host on port 50001. If the host is localhost, then this would be `http://localhost:50001/nexus`.  Substitute a different address if running somewhere other than localhost.  Make sure the URL contains the trailing '/nexus' path as shown.
- Login using the default Nexus credentials. **username:** `admin` **password:** `admin123`
- Do Nexus stuff!
- WARNING: Be sure to change the password for the admin account and the other built-in accounts before exposing the server to the internet.
