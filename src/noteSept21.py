self.cols = [Sym(headings[0]), Num(headings[1].split('-')[0]),
                     Num(headings[2].split('<')[1]), Sym(headings[3]),
                     Num(headings[4].split('>')[1])]


def aha_distance(i, r1, r2):
        distance = 0
        for col, row1, row2 in zip(i.cols, r1, r2):
            distance += col.dist(row1, row2)
        if distance<0:
            distance = 0
            for col, row1, row2 in zip(i.cols, r2, r1):
                distance += col.dist(row1, row2)
        return math.sqrt(distance)
