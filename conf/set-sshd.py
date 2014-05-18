#!/usr/bin/env python
import pexpect

ssh_newkey = 'Are you sure you want to continue connecting'
# command line 'ssh-host-config'
p=pexpect.spawn('ssh-host-config')
'''
i=p.expect([ssh_newkey,'password:',pexpect.EOF])
if i==0:
	print "I say yes"
	p.sendline('yes')
	i=p.expect([ssh_newkey,'password:',pexpect.EOF])
if i==1:
	print "I give password",
	p.sendline("mypassword")
	p.expect(pexpect.EOF)
elif i==2:
	print "I either got key or connection timeout"
	pass
print p.before # print out the result
'''
