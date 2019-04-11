# Wrap OpenCV C++ function via Cython

## 1. Background Infomation

OpenCV have supported CUDA for a long time. Though it also provides Python API for most of its functions, it has **no Python API for its CUDA functions written in C++, in its early versions**.

Therefore, if you are requested to wrap OpenCV CUDA function into Python API for those early OpenCV versions, then here is the right place. 

Otherwise, I recommend you to keep track **OpenCV 4.0 Version**, they're working on Python API for CUDA function now on this branch.


## 2. About this example

What the example doing here is to wrap the following cuda function:

```cpp
void cv::cuda::remap(	InputArray 	src,
			OutputArray 	dst,
			InputArray 	xmap,
			InputArray 	ymap,
			int 	        interpolation,
			int 	        borderMode = BORDER_CONSTANT,
			Scalar 	        borderValue = Scalar(),
		        Stream & 	stream = Stream::Null() 
			)	
```

If you would like to use this ```.so``` file, feel free to get it. It should be correct if your src image is of CV_8U3C. Also, feel free to open an issue if you have any doubts.


## 3. If You want to Build your Own wrapper

### 0) Pre-Request

- Cython installation
- CUDA installation(it is a must if you want to wrap CUDA function)

- OpenCV and OpenCV contribute installation
- Numpy installation(actually when you install OpenCV, you should have installed Numpy first)

### 1) Understand the procedure

```
Python(Numpy)--> C++(OpenCV Mat/others)--> Call C++ function--> Return C++ Data Structure--
     |                                                                                    | 
     --------------------------------------------------------------------------------------
```

### 2) Get your hands dirty

**First, to build the example,**

0. Check the configuration in ```setup.py```,  what really matters is the library paths of OpenCV and Numpy.

1. Run ```python setup.py build_ext --inplace```. If there is anything wrong here, go and check your path. Otherwise, you may need to figure out if there is anything wrong with the pre-request dependency.

2. After that, you will get a  ```.so``` file, which contains your desired cuda function. It means that your dependency is ready. If you see warning like the following, it is alright:
   - ```cc1plus: warning: command line option ‘**-Wstrict-prototypes**’ is valid for C/ObjC but not for C++.```
   - ```warning: #warning "Using deprecated NumPy API, disable it with " "#define NPY_NO_DEPRECATED_API NPY_1_7_API_VERSION" [-Wcpp]```
3. Then, you need to copy or move the .so file to the place where your python interpreter can find it.
4. Finally, you can simply write ```import GpuWrapper``` , the name of the ```.so``` file, then you can use the cuda function in your python code directly. 

**Second, to write your own functions,**

1. Read the documentation of OpenCV. Pay attention to input/output data Structure
2. Write the dependent data structure/ class/ function in the ```.pxd``` file.
3. Write your own logic in ```.pyx``` file.
4. Repeat the procedure in first step.

### 3) Tips

```pyopencv_converter.cpp``` is the code that convert , which is copied from OpenCV. It deals with the convertion from Python(Numpy data structure) to C++(OpenCV Mat data structure). So, you don't really need to care about this.


## Reference

[Cython official tutorial](https://cython.readthedocs.io/en/latest/src/tutorial/cython_tutorial.html)

[Accessing OpenCV CUDA Functions from Python (No PyCUDA)](https://stackoverflow.com/questions/42125084/accessing-opencv-cuda-functions-from-python-no-pycuda)

[知乎:Cython 基本用法(Chinese)](https://zhuanlan.zhihu.com/p/24311879)
