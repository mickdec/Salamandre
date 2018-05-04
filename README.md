<center><h1>Salamandre</h1></center>
<center>A Metasploit Automation Script.</center>
<h2>REQUIREMENTS</h2>
<ul>
<li>1. a <a href="https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-9.4.0-amd64-netinst.iso">linux</a> system (preferably  <a href="https://www.kali.org/downloads/">kali</a>).
<li>2. a <a href="https://www.metasploit.com/download">metasploit</a> facility (already in kali).
</ul>
<h2>DISCLAIMER</h2>
<p><i>
This script is meant to be used only for benevolent purposes.
<br>I am in no way responsible for your actions and the use you can make of them.
</i><p>
<h2>WHAT THIS SCRIPT DOES</h2>
<p>
This script let you choose a payload, create it with your local IP, launch an apache2 server, auto create an index.html website who force the download of the created payload, and start the MSF listener with the most common AutoRun POST.
</p>
<h2>TO-DO (if you want to help)</h2>
<p>
<ul>
<li> I need a solution for portforwarding a phone device. Since VoIP :)
<li> HTML website is not created for now
<li> All the payloads are not listed (need to implement a "custom choice")
<li> Need to transfer data from .sh to .rb (or create a lot of .rb files)
<li> I didn't have implemented verifications, if the script crash, you have to debug by yourself for now.
</ul>
</p>





