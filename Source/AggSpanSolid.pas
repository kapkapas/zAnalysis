{ ****************************************************************************** }
{ * memory Rasterization with AGG support                                      * }
{ * by QQ 600585@qq.com                                                        * }
{ ****************************************************************************** }
{ * https://github.com/PassByYou888/CoreCipher                                 * }
{ * https://github.com/PassByYou888/ZServer4D                                  * }
{ * https://github.com/PassByYou888/zExpression                                * }
{ * https://github.com/PassByYou888/zTranslate                                 * }
{ * https://github.com/PassByYou888/zSound                                     * }
{ * https://github.com/PassByYou888/zAnalysis                                  * }
{ * https://github.com/PassByYou888/zGameWare                                  * }
{ * https://github.com/PassByYou888/zRasterization                             * }
{ ****************************************************************************** }

(*
  ////////////////////////////////////////////////////////////////////////////////
  //                                                                            //
  //  Anti-Grain Geometry (modernized Pascal fork, aka 'AggPasMod')             //
  //    Maintained by Christian-W. Budde (Christian@pcjv.de)                    //
  //    Copyright (c) 2012-2017                                                 //
  //                                                                            //
  //  Based on:                                                                 //
  //    Pascal port by Milan Marusinec alias Milano (milan@marusinec.sk)        //
  //    Copyright (c) 2005-2006, see http://www.aggpas.org                      //
  //                                                                            //
  //  Original License:                                                         //
  //    Anti-Grain Geometry - Version 2.4 (Public License)                      //
  //    Copyright (C) 2002-2005 Maxim Shemanarev (http://www.antigrain.com)     //
  //    Contact: McSeem@antigrain.com / McSeemAgg@yahoo.com                     //
  //                                                                            //
  //  Permission to copy, use, modify, sell and distribute this software        //
  //  is granted provided this copyright notice appears in all copies.          //
  //  This software is provided "as is" without express or implied              //
  //  warranty, and with no claim as to its suitability for any purpose.        //
  //                                                                            //
  ////////////////////////////////////////////////////////////////////////////////
*)
unit AggSpanSolid;

{$INCLUDE AggCompiler.inc}
interface
uses
  AggBasics,
  AggSpanAllocator,
  AggSpanGenerator,
  AggColor32;

type
  TAggSpanSolid = class(TAggSpanGenerator)
  private
    FColor: TAggColor;

    procedure SetColor(c: PAggColor);
    function GetColor: PAggColor;
  public
    constructor Create(Alloc: TAggSpanAllocator);

    function Generate(x, y: Integer; Len: Cardinal): PAggColor; override;
  end;

implementation


{ TAggSpanSolid }

constructor TAggSpanSolid.Create(Alloc: TAggSpanAllocator);
begin
  inherited Create(Alloc);
end;

procedure TAggSpanSolid.SetColor(c: PAggColor);
begin
  FColor := c^;
end;

function TAggSpanSolid.GetColor: PAggColor;
begin
  Result := @FColor;
end;

function TAggSpanSolid.Generate(x, y: Integer; Len: Cardinal): PAggColor;
var
  Span: PAggColor;
begin
  Span := Allocator.Span;

  repeat
    Span^ := FColor;

    inc(PtrComp(Span), SizeOf(TAggColor));
    dec(Len);
  until Len = 0;

  Result := Allocator.Span;
end;

end.
 
 
 
