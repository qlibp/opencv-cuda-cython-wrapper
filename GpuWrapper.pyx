import numpy as np  # Import Python functions, attributes, submodules of numpy
cimport numpy as np  # Import numpy C/C++ API
np.import_array() 

def cuda_remap(np.ndarray[np.uint8_t,ndim=3]src,
               np.ndarray[np.float32_t,ndim=2]map1,#CV_32FC1 ???? CV_16SC2???
               np.ndarray[np.float32_t,ndim=2]map2,#CV_16UC1 ?????
               int interpolation,
               dst=None,
               int borderMode=BORDER_CONSTANT):
    rows = src.shape[0]
    cols = src.shape[1]
    cdef Mat src_mat
    cdef GpuMat src_gpu=GpuMat(rows,cols,CV_8UC3)
    pyopencv_to(<PyObject*>src,src_mat)
    src_gpu.upload(src_mat)
    
    cdef Mat map1_mat
    # To be disscussed
    cdef GpuMat map1_gpu
    pyopencv_to(<PyObject*>map1, map1_mat)
    map1_gpu.upload(map1_mat)
 
    cdef Mat map2_mat
    # To be disscussed
    cdef GpuMat map2_gpu
    pyopencv_to(<PyObject*>map2, map2_mat)
    map2_gpu.upload(map2_mat)

    cdef Mat dst_mat
    cdef GpuMat dst_gpu=GpuMat(rows,cols,CV_8UC3)
 
    remap(src_gpu, dst_gpu, map1_gpu, map2_gpu, interpolation)
    dst_gpu.download(dst_mat)
    cdef np.ndarray out = <np.ndarray> pyopencv_from(dst_mat)
    if dst is not None:
       dst = out
    else:
        return out


