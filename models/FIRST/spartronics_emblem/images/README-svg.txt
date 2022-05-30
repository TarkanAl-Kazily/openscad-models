Converting a PNG to an SVG

Edit the desired PNG image in a bitmap/paint program, cropping the area
of interest, and converting the image to a two-color file. This can be
done by converting to black & white, and setting the contrast to 100%.
As a result, the shape that you want the SVG to represent should be
black, and it should be on a white background (invert the colors if
necesary to achieve this).

Save the resulting intermediate PNG file, and open it with InkScape.
Select the image, then select Path -> Trace Bitmap. A dialog will open
with a bunch of settings. Select "Brightness cutoff" with a value of
0.450, and check the "Smooth", "Stack scans" and "Remove background"
check boxes. On the Options tab, enable "Suppress speckles" with a
value big enough to eliminate rough edges from the bitmap. This could
be large, around 25. Experiment with the "Smooth corners" and "Optimize
paths" as desired. The "Update" button will show a preview. Click on
"OK" to execute the trace.

Now the bitmap and SVG are on top of each other in the editing window.
Select and drag the top image to the side. One will be the bitmap, and
the other will be the SVG. Delete the bitmap (you may need to zoom in
to see which is which), then save the remaining SVG in a new file.
