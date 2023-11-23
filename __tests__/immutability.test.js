const { execSync } = require('child_process');

const executeCommand = (cmd) => {
    return execSync(`docker exec test /bin/sh -c "${cmd}"`).toString();
}

describe('Immutability', () => {
    beforeAll(() => {
        // Build fresh if not already built
        execSync('docker build -t development-toolkit .')
        // Run container forever
        execSync('docker run --name test -d development-toolkit tail -f /dev/null')
    });
    
    afterAll(() => {
        execSync('docker stop test')
        execSync('docker rm -f test')
    })

    describe('Core', () => {
        it('Installed packages', () => {
            const output = executeCommand("apt list --installed");
            expect(output).toMatchSnapshot();
        })
    })

    describe('Core Extended packages', () => {
        it('Git version', () => {
            const output = executeCommand("git --version");
            expect(output).toMatchSnapshot();
        })
    
        it('Git LFS version', () => {
            const output = executeCommand("git-lfs --version");
            expect(output).toMatchSnapshot();
        })
    
        it('Docker version', () => {
            const output = executeCommand("docker --version");
            expect(output).toMatchSnapshot();
        })

        it('Docker-compose version', () => {
            const output = executeCommand("docker-compose --version");
            expect(output).toMatchSnapshot();
        })
    
        it('Curl version', () => {
            const output = executeCommand("curl --version");
            expect(output).toMatchSnapshot();
        })

        it('net-tools: netstat version', () => {
            const output = executeCommand("netstat --version");
            expect(output).toMatchSnapshot();
        })

        it('gnupg: gpg version', () => {
            const output = executeCommand("gpg --version");
            expect(output).toMatchSnapshot();
        })
        
        it('libcurl4-openssl-dev version', () => {
            const output = executeCommand("curl-config --version");
            expect(output).toMatchSnapshot();
        })

        it('gcc version', () => {
            const output = executeCommand("gcc --version");
            expect(output).toMatchSnapshot();
        })

        it('g++ version', () => {
            const output = executeCommand("g++ --version");
            expect(output).toMatchSnapshot();
        })

        it('make version', () => {
            const output = executeCommand("make --version");
            expect(output).toMatchSnapshot();
        })

        it('fastjar: jar version', () => {
            const output = executeCommand("jar --version");
            expect(output).toMatchSnapshot();
        })

    })

    describe('Development packages', () => {
        it('Node version', () => {
            const output = executeCommand("node --version");
            expect(output).toMatchSnapshot();
        })
    
        it('NPM version', () => {
            const output = executeCommand("npm --version");
            expect(output).toMatchSnapshot();
        })
    
        it('Dotnet runtimes list', () => {
            const output = executeCommand("dotnet --list-runtimes");
            expect(output).toMatchSnapshot();
        })
    
        it('Dotnet SDKs list', () => {
            const output = executeCommand("dotnet --list-sdks");
            expect(output).toMatchSnapshot();
        })
    
        it('opinionated-bash-scripts version', () => {
            const output = executeCommand("cat /usr/share/opinionated-bash-scripts/scripts/version.sh");
            expect(output).toMatchSnapshot();
        })
    })
    







});