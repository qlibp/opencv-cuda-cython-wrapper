from libcpp cimport bool
from cpython.ref cimport PyObject

# References PyObject to OpenCV object conversion code borrowed from OpenCV's own conversion file, cv2.cpp
cdef extern from 'pyopencv_converter.cpp':
    cdef PyObject* pyopencv_from(const Mat& m)
    cdef bool pyopencv_to(PyObject* o, Mat& m)

cdef extern from 'opencv2/imgproc.hpp' namespace 'cv':
    cdef enum InterpolationFlags:
        INTER_NEAREST = 0
        INTER_LINEAR  = 1,
        INTER_CUBIC   = 2,
        INTER_AREA           = 3,
        INTER_LANCZOS4       = 4,
        INTER_LINEAR_EXACT = 5,
        INTER_MAX            = 7,
        WARP_FILL_OUTLIERS   = 8,
        WARP_INVERSE_MAP     = 16
    cdef enum ColorConversionCodes:
        COLOR_BGR2GRAY



cdef extern from 'opencv2/core.hpp':
    cdef int CV_8UC1
    cdef int CV_8UC3
    cdef int CV_32FC1

cdef extern from 'opencv2/core.hpp' namespace 'cv':
    cdef enum  BorderTypes:
        BORDER_CONSTANT    = 0, 
        BORDER_REPLICATE   = 1,
        BORDER_REFLECT     = 2,
        BORDER_WRAP        = 3, 
        BORDER_REFLECT_101 = 4, 
        BORDER_TRANSPARENT = 5, 
        BORDER_REFLECT101  = BORDER_REFLECT_101, 
        BORDER_DEFAULT     = BORDER_REFLECT_101,
        BORDER_ISOLATED    = 16

    cdef cppclass Size_[T]:
        Size_() except +
        Size_(T width, T height) except +
        T width
        T height
    ctypedef Size_[int] Size2i
    ctypedef Size2i Size
    cdef cppclass Scalar[T]:
        Scalar() except +
        Scalar(T v0) except +

cdef extern from 'opencv2/core.hpp' namespace 'cv':
    cdef cppclass Mat:
        Mat() except +
        void create(int, int, int) except +
        void* data
        int rows
        int cols

cdef extern from 'opencv2/core/cuda.hpp' namespace 'cv::cuda':
    cdef cppclass GpuMat:
        GpuMat() except +
        GpuMat(int rows,int cols,int typ) except +
        void upload(Mat arr) except +
        void download(Mat dst) const
        bool empty() const
    cdef cppclass Stream:
        Stream() except +
        @staticmethod
        Stream& Null()
cdef extern from 'opencv2/cudawarping.hpp' namespace 'cv::cuda':

    # src             : GpuMat needs to extend
    # dst             : GpuMat needs to extend
    # xmap            : GpuMat needs to extend 
    # ymap            : GpuMat needs to extend
    # interpolation   : enum InterpolationFlags
    # borderMode      : enum BorderTypes
    # borderValue     : Scalar needs to extend
    # stream          : Stream needs to extend
    cdef void remap(GpuMat src, GpuMat dst, GpuMat xmap, GpuMat ymap, int interpolation, int borderMode, Scalar borderValue, Stream& stream)
    cdef void remap(GpuMat src, GpuMat dst, GpuMat xmap, GpuMat ymap, int interpolation)
