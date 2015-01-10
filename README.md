# toast
The OLCF Asset Staging Tool. Download the latest version (here)[https://github.com/robertdfrench/toast/archive/v0.1.0.tar.gz]

Toast can be used to load assets onto node-local filesystems (such as ramdisk or SSD) prior to application launch. This can reduce stress on parallel filesystems, and help speed up the load time of leadership scale applications.

### Usage
Toast takes two arguments:
  * a source file on the scratch filesystem
  * a staging path on the destination filesystem

For example, to stage the file `libxml_viz.so` to ramdisk on 1200 nodes of a modern Cray system:

`$ aprun -n 1200 -N 1 ./toast libxml_viz.so /tmp/scratch/libxml_viz.so`

### What are Assets?
An asset is any small-ish file that an application process (in MPI terms, a "rank") might need in order to boot correctly. This could be a dynamic library, an auxiliary program, or even a collection of Python modules. 

### Why stage?
Typically it is advantageous to embed assets statically into your application, but this may not always be convenient, or may require changes in your code. For these situations, toast can push assets to each node for you; the application can then load them locally, which saves congestion on the shared filesystem.

### How does work?
Before launching your application, run one rank of toast on each node in your job. Toast will balance itself so that only a few ranks will load your assets from the shared filesystem. Once loaded, toast will broadcast your assets to all the other nodes allocated to your application, persisting them to whatever local path you define.
