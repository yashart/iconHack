from PIL import Image, ImageDraw

def meanColor(i, j, pix):
    r = pix[i, j][0]
    g = pix[i, j][1]
    b = pix[i, j][2]
    color = (r + g + b) / 3
    return color


def isGradient(i, j, pix, detalisation):
    centerColour = meanColor(i, j, pix)
    oppositeColour = meanColor(i - 1, j - 1, pix) + meanColor(i, j - 1, pix) + meanColor(i + 1, j - 1, pix) + \
                     meanColor(i - 1, j, pix) + meanColor(i + 1, j, pix) + \
                     meanColor(i - 1, j + 1, pix) + meanColor(i, j + 1, pix) + meanColor(i + 1, j + 1, pix)
    oppositeColour /= 8.0
    if (centerColour > detalisation * oppositeColour):
        return 1
    return 0


def create_image(path, detalisation):

    image = Image.open(path)
    draw = ImageDraw.Draw(image)
    width = image.size[0]
    height = image.size[1]
    pix = image.load()

    color = 0
    for i in range(width):
        for j in range(height):
            a = pix[i, j][0]
            b = pix[i, j][1]
            c = pix[i, j][2]
            S = (a + b + c)/3
            color += S

    for i in range(width):
        for j in range(height):
            if(i == 0 or i == width-1 or j == 0 or j == height-1):
                draw.point((i, j), pix[i, j])
                continue

            if(isGradient(i,j, pix, detalisation)):
                draw.point((i, j), pix[i, j])
            else:
                draw.point((i, j), (255, 0, 0))
                draw.point((i - 1, j), (255, 0, 0))
                draw.point((i, j - 1), (255, 0, 0))
                draw.point((i - 1, j - 1), (255, 0, 0))



    image.save(path, "PNG")
    del draw
