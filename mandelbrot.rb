#encoding: utf-8
#Idea and modified from http://blog.mostof.it/mandelbrot-set-in-ruby-and-haskell
require 'rubygems'
require 'complex'
require 'RMagick'
include Magick
 
def mandelbrot(surface,width = 800,height = 600, x1 = -2.0,x2 = 0.5,y1 = -1.0 ,y2 = 1.0, iterations = 200)

  xsize = (x2 - x1) / width.to_f
  ysize = (y2 - y1) / height.to_f
  colors = 0xffffff / iterations

  height.to_i.times do |y|
    puts "Line #{y}"
    width.to_i.times do |x|
      escape = escapes?(Complex((x * xsize) + x1, (y * ysize) + y1), iterations)
      Draw.new.fill("#%06x" % (escape * colors)).point(x,y).draw(surface) if escape 
    end
  end
end

def escapes?(c, iterations = 200)

  # quick check to see if the point is in the main bulb
  #q = ((c.real - 1/4) ** 2) + (c.imag ** 2)
  #return false if q * (q + (c.real - 1/4)) < (1/4 * c.imag ** 2)
  # it isn't, so compute
  z = Complex(0)
  iterations.times do |x|
    return x if z.abs > 2
    z = z*z + c
  end
  0
end
 
complex_plane = Image.new(8000,6000)

mandelbrot(complex_plane, 8000, 6000)
 
complex_plane.write("mandelbrot.png")
