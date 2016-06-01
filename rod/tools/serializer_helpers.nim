import json

import nimx.image
import nimx.types
import nimx.matrixes

import rod.rod_types
import rod.node

proc getSerializedValue*(j: JsonNode, name: string, val: var int) =
    let jN = j{name}
    if not jN.isNil:
        val = jN.getNum().int

proc getSerializedValue*(j: JsonNode, name: string, val: var float32) =
    let jN = j{name}
    if not jN.isNil:
        val = jN.getFnum()

proc getSerializedValue*(j: JsonNode, name: string, val: var float) =
    let jN = j{name}
    if not jN.isNil:
        val = jN.getFnum()

proc getSerializedValue*(j: JsonNode, name: string, val: var Vector3) =
    let jN = j{name}
    if not jN.isNil:
        val = newVector3(jN[0].getFnum(), jN[1].getFnum(), jN[2].getFnum())

proc getSerializedValue*(j: JsonNode, name: string, val: var Size) =
    let jN = j{name}
    if not jN.isNil:
        val = newSize(jN[0].getFnum(), jN[1].getFnum())

proc getSerializedValue*(j: JsonNode, name: string, val: var Image) =
    let jN = j{name}
    if not jN.isNil:
        val = imageWithResource(jN.getStr())

proc getSerializedValue*(j: JsonNode, name: string, val: var bool) =
    let jN = j{name}
    if not jN.isNil:
        val = jN.getBVal()

proc getSerializedValue*(j: JsonNode, name: string, val: var Node) =
    let jN = j{name}
    if not jN.isNil and jN.getStr().len > 0:
        val = newNode(jN.getStr())

proc getSerializedValue*(j: JsonNode, name: string, val: var Color) =
    let jN = j{name}
    if not jN.isNil:
        val.r = jN[0].getFNum()
        val.g = jN[1].getFNum()
        val.b = jN[2].getFNum()
        if jN.len > 3: #TODO: new format should always have 4 components for color.
            val.a = jN[3].getFNum()
        else:
            val.a = 1.0