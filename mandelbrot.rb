#Idea and modified from http://blog.mostof.it/mandelbrot-set-in-ruby-and-haskell
require 'rubygems'
require 'complex'
require 'RMagick'
include Magick
 
# this is the interesting area of the complex plane
X_START = -2.0
X_END = 0.5
Y_START = -1.0
Y_END = 1.0
 
# wanted image dimensions
WIDTH = 800.0
HEIGHT = 600.0
 
# set this to higher values and sleep well :)
ITERATIONS = 200 
COLORS = 0xfffff / ITERATIONS
 
STEP_X = (X_END - X_START) / WIDTH
STEP_Y = (Y_END - Y_START) / HEIGHT
 
def mandelbrot(surface,width,height,x1,x2,y1,y2)

  xsize = (x2 - x1) / width.to_f
  ysize = (y2 - y1) / height.to_f

  height.to_i.times do |y|
    puts "Line #{y}"
    width.to_i.times do |x|
      escape = escapes?(Complex((x * xsize) + x1, (y * ysize) + y1))
      Draw.new.fill("#%06x" % (escape * COLORS)).point(x,y).draw(surface) if escape 
    end
  end
end

def escapes?(c)
  z = Complex(0)
  ITERATIONS.times do |x|
    return x if z.abs > 2
    z = z*z + c
  end
  false
end
 
complex_plane = Image.new(WIDTH.to_i, HEIGHT.to_i)

mandelbrot(complex_plane,WIDTH,HEIGHT,X_START,X_END,Y_START,Y_END)
 
complex_plane.write("mandelbrot.png")
