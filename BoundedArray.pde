/*=====================================================================
  BoundedArray -- array object with index protection, useful in loops
*/
class BoundedArray {
  public: 
  int size;
  double *arr;  
  
  public: BoundedArray( int length ) {
    size = length;
    double temp[size];
    arr = temp;
  }  
  
  public: void set( int index, double val ) {
    if( index < size-1 ) {
       arr[index] = val; 
    }
  } 
  
  public: double get( int index ) {
    if( index < size-1 ) {
      return arr[index]; 
    }
  }
  
  public: int length() {
    return size;
  }
};
