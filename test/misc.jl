
using Colors, Base.Test
import Compose: Point

# showcompact
tomato_bisque =
           compose(context(),
                   (context(), circle(), fill(colorant"bisque")),
                   (context(), rectangle(), fill(colorant"tomato")))

io = IOBuffer()
showcompact(io, tomato_bisque)
str = takebuf_string(io)
@test str == "Context(Context(f,R),Context(f,C))"

# Tagging
function points(xa, ya)
    [Point(x,y) for (x,y) in zip(xa,ya)]
end

pnts = points(rand(5), rand(5))
p = polygon(pnts, :mypoints)
@test p.tag == :mypoints

r = rectangle(0, 1, 0.5, 0.8, :box)
@test r.tag == :box
r = rectangle(rand(5),rand(5),rand(5),rand(5),:manybox)
@test r.tag == :manybox

c = circle(0, 0.8, 1.2, :circle)
@test c.tag == :circle
c = circle(rand(5), rand(5), rand(5), :data)
@test c.tag == :data

elps = ellipse(0, 0.8, 1.2, 1.5, :ellipse)
@test elps.tag == :ellipse
elps = ellipse(rand(5),rand(5),rand(5),rand(5),:manyellipse)
@test elps.tag == :manyellipse

txt = text(1.5, 15, "hello", tag=:hello)
@test txt.tag == :hello
txt = text(rand(5),rand(5),map(x->randstring(5), 1:5), tag=:random)
@test txt.tag == :random

ln = line(pnts, :line)
@test ln.tag == :line

crv = curve((0,0), (1,0.5), (0.2,0.3), (0.7,-2.4), :curve)
@test crv.tag == :curve
crv = curve(pnts, pnts, pnts, pnts, :manycurve)
@test crv.tag == :manycurve

bm = bitmap("fake", rand(Uint8,10), 0, 1, 0.8, 0.7, :image)
@test bm.tag == :image

# type definitions
c = Compose.circle(rand(5), rand(5), rand(5))
@test isa(c, Compose.Circle)
