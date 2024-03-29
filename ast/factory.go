// generated by Textmapper; DO NOT EDIT

package ast

import (
	"fmt"
	"github.com/satishbabariya/llts"
)

func ToTsNode(n *Node) TsNode {
	switch n.Type() {
	case llts.Abstract:
		return &Abstract{n}
	case llts.AccessibilityModifier:
		return &AccessibilityModifier{n}
	case llts.AdditiveExpr:
		return &AdditiveExpr{n}
	case llts.Arguments:
		return &Arguments{n}
	case llts.ArrayLiteral:
		return &ArrayLiteral{n}
	case llts.ArrayPattern:
		return &ArrayPattern{n}
	case llts.ArrayType:
		return &ArrayType{n}
	case llts.ArrowFunc:
		return &ArrowFunc{n}
	case llts.AssertsType:
		return &AssertsType{n}
	case llts.AssignmentExpr:
		return &AssignmentExpr{n}
	case llts.AssignmentOperator:
		return &AssignmentOperator{n}
	case llts.AsyncArrowFunc:
		return &AsyncArrowFunc{n}
	case llts.AsyncFunc:
		return &AsyncFunc{n}
	case llts.AsyncFuncExpr:
		return &AsyncFuncExpr{n}
	case llts.AsyncMethod:
		return &AsyncMethod{n}
	case llts.AwaitExpr:
		return &AwaitExpr{n}
	case llts.BindingRestElement:
		return &BindingRestElement{n}
	case llts.BitwiseAND:
		return &BitwiseAND{n}
	case llts.BitwiseOR:
		return &BitwiseOR{n}
	case llts.BitwiseXOR:
		return &BitwiseXOR{n}
	case llts.Block:
		return &Block{n}
	case llts.Body:
		return &Body{n}
	case llts.BreakStmt:
		return &BreakStmt{n}
	case llts.CallExpr:
		return &CallExpr{n}
	case llts.CallSignature:
		return &CallSignature{n}
	case llts.Case:
		return &Case{n}
	case llts.Catch:
		return &Catch{n}
	case llts.Class:
		return &Class{n}
	case llts.ClassBody:
		return &ClassBody{n}
	case llts.ClassExpr:
		return &ClassExpr{n}
	case llts.CoalesceExpr:
		return &CoalesceExpr{n}
	case llts.CommaExpr:
		return &CommaExpr{n}
	case llts.ComputedPropertyName:
		return &ComputedPropertyName{n}
	case llts.ConciseBody:
		return &ConciseBody{n}
	case llts.ConditionalExpr:
		return &ConditionalExpr{n}
	case llts.ConstructSignature:
		return &ConstructSignature{n}
	case llts.ConstructorType:
		return &ConstructorType{n}
	case llts.ContinueStmt:
		return &ContinueStmt{n}
	case llts.DebuggerStmt:
		return &DebuggerStmt{n}
	case llts.Declare:
		return &Declare{n}
	case llts.DecoratorCall:
		return &DecoratorCall{n}
	case llts.DecoratorExpr:
		return &DecoratorExpr{n}
	case llts.Default:
		return &Default{n}
	case llts.DefaultParameter:
		return &DefaultParameter{n}
	case llts.DoWhileStmt:
		return &DoWhileStmt{n}
	case llts.ElementBinding:
		return &ElementBinding{n}
	case llts.EmptyDecl:
		return &EmptyDecl{n}
	case llts.EmptyStmt:
		return &EmptyStmt{n}
	case llts.EqualityExpr:
		return &EqualityExpr{n}
	case llts.ExponentiationExpr:
		return &ExponentiationExpr{n}
	case llts.ExportClause:
		return &ExportClause{n}
	case llts.ExportDecl:
		return &ExportDecl{n}
	case llts.ExportDefault:
		return &ExportDefault{n}
	case llts.ExportSpec:
		return &ExportSpec{n}
	case llts.ExprStmt:
		return &ExprStmt{n}
	case llts.Extends:
		return &Extends{n}
	case llts.Finally:
		return &Finally{n}
	case llts.ForBinding:
		return &ForBinding{n}
	case llts.ForCondition:
		return &ForCondition{n}
	case llts.ForFinalExpr:
		return &ForFinalExpr{n}
	case llts.ForInStmt:
		return &ForInStmt{n}
	case llts.ForInStmtWithVar:
		return &ForInStmtWithVar{n}
	case llts.ForOfStmt:
		return &ForOfStmt{n}
	case llts.ForOfStmtWithVar:
		return &ForOfStmtWithVar{n}
	case llts.ForStmt:
		return &ForStmt{n}
	case llts.ForStmtWithVar:
		return &ForStmtWithVar{n}
	case llts.Func:
		return &Func{n}
	case llts.FuncExpr:
		return &FuncExpr{n}
	case llts.FuncType:
		return &FuncType{n}
	case llts.Generator:
		return &Generator{n}
	case llts.GeneratorExpr:
		return &GeneratorExpr{n}
	case llts.GeneratorMethod:
		return &GeneratorMethod{n}
	case llts.Getter:
		return &Getter{n}
	case llts.IdentExpr:
		return &IdentExpr{n}
	case llts.IfStmt:
		return &IfStmt{n}
	case llts.ImportDecl:
		return &ImportDecl{n}
	case llts.ImportSpec:
		return &ImportSpec{n}
	case llts.ImportType:
		return &ImportType{n}
	case llts.InExpr:
		return &InExpr{n}
	case llts.IndexAccess:
		return &IndexAccess{n}
	case llts.IndexSignature:
		return &IndexSignature{n}
	case llts.IndexedAccessType:
		return &IndexedAccessType{n}
	case llts.Initializer:
		return &Initializer{n}
	case llts.InstanceOfExpr:
		return &InstanceOfExpr{n}
	case llts.IntersectionType:
		return &IntersectionType{n}
	case llts.KeyOfType:
		return &KeyOfType{n}
	case llts.LabelIdent:
		return &LabelIdent{n}
	case llts.LabelledStmt:
		return &LabelledStmt{n}
	case llts.LetOrConst:
		return &LetOrConst{n}
	case llts.LexicalBinding:
		return &LexicalBinding{n}
	case llts.LexicalDecl:
		return &LexicalDecl{n}
	case llts.Literal:
		return &Literal{n}
	case llts.LiteralPropertyName:
		return &LiteralPropertyName{n}
	case llts.LiteralType:
		return &LiteralType{n}
	case llts.LogicalAND:
		return &LogicalAND{n}
	case llts.LogicalOR:
		return &LogicalOR{n}
	case llts.MappedType:
		return &MappedType{n}
	case llts.MemberMethod:
		return &MemberMethod{n}
	case llts.MemberVar:
		return &MemberVar{n}
	case llts.Method:
		return &Method{n}
	case llts.MethodSignature:
		return &MethodSignature{n}
	case llts.Module:
		return &Module{n}
	case llts.ModuleSpec:
		return &ModuleSpec{n}
	case llts.MultiplicativeExpr:
		return &MultiplicativeExpr{n}
	case llts.NameIdent:
		return &NameIdent{n}
	case llts.NameSpaceImport:
		return &NameSpaceImport{n}
	case llts.NamedImports:
		return &NamedImports{n}
	case llts.NewExpr:
		return &NewExpr{n}
	case llts.NewTarget:
		return &NewTarget{n}
	case llts.NoElement:
		return &NoElement{n}
	case llts.NonNullableType:
		return &NonNullableType{n}
	case llts.NullableType:
		return &NullableType{n}
	case llts.ObjectLiteral:
		return &ObjectLiteral{n}
	case llts.ObjectMethod:
		return &ObjectMethod{n}
	case llts.ObjectPattern:
		return &ObjectPattern{n}
	case llts.ObjectType:
		return &ObjectType{n}
	case llts.OptionalCallExpr:
		return &OptionalCallExpr{n}
	case llts.OptionalIndexAccess:
		return &OptionalIndexAccess{n}
	case llts.OptionalPropertyAccess:
		return &OptionalPropertyAccess{n}
	case llts.Parameters:
		return &Parameters{n}
	case llts.Parenthesized:
		return &Parenthesized{n}
	case llts.ParenthesizedType:
		return &ParenthesizedType{n}
	case llts.PostDec:
		return &PostDec{n}
	case llts.PostInc:
		return &PostInc{n}
	case llts.PreDec:
		return &PreDec{n}
	case llts.PreInc:
		return &PreInc{n}
	case llts.PredefinedType:
		return &PredefinedType{n}
	case llts.Property:
		return &Property{n}
	case llts.PropertyAccess:
		return &PropertyAccess{n}
	case llts.PropertyBinding:
		return &PropertyBinding{n}
	case llts.PropertySignature:
		return &PropertySignature{n}
	case llts.Readonly:
		return &Readonly{n}
	case llts.ReadonlyType:
		return &ReadonlyType{n}
	case llts.ReferenceIdent:
		return &ReferenceIdent{n}
	case llts.RelationalExpr:
		return &RelationalExpr{n}
	case llts.RestParameter:
		return &RestParameter{n}
	case llts.RestType:
		return &RestType{n}
	case llts.ReturnStmt:
		return &ReturnStmt{n}
	case llts.Setter:
		return &Setter{n}
	case llts.ShiftExpr:
		return &ShiftExpr{n}
	case llts.ShorthandProperty:
		return &ShorthandProperty{n}
	case llts.SingleNameBinding:
		return &SingleNameBinding{n}
	case llts.SpreadElement:
		return &SpreadElement{n}
	case llts.SpreadProperty:
		return &SpreadProperty{n}
	case llts.Static:
		return &Static{n}
	case llts.SuperExpr:
		return &SuperExpr{n}
	case llts.SwitchStmt:
		return &SwitchStmt{n}
	case llts.SyntaxProblem:
		return &SyntaxProblem{n}
	case llts.This:
		return &This{n}
	case llts.ThisType:
		return &ThisType{n}
	case llts.ThrowStmt:
		return &ThrowStmt{n}
	case llts.TryStmt:
		return &TryStmt{n}
	case llts.TsAmbientBinding:
		return &TsAmbientBinding{n}
	case llts.TsAmbientClass:
		return &TsAmbientClass{n}
	case llts.TsAmbientEnum:
		return &TsAmbientEnum{n}
	case llts.TsAmbientExportDecl:
		return &TsAmbientExportDecl{n}
	case llts.TsAmbientFunc:
		return &TsAmbientFunc{n}
	case llts.TsAmbientGlobal:
		return &TsAmbientGlobal{n}
	case llts.TsAmbientImportAlias:
		return &TsAmbientImportAlias{n}
	case llts.TsAmbientInterface:
		return &TsAmbientInterface{n}
	case llts.TsAmbientModule:
		return &TsAmbientModule{n}
	case llts.TsAmbientNamespace:
		return &TsAmbientNamespace{n}
	case llts.TsAmbientTypeAlias:
		return &TsAmbientTypeAlias{n}
	case llts.TsAmbientVar:
		return &TsAmbientVar{n}
	case llts.TsAsConstExpr:
		return &TsAsConstExpr{n}
	case llts.TsAsExpr:
		return &TsAsExpr{n}
	case llts.TsCastExpr:
		return &TsCastExpr{n}
	case llts.TsConditional:
		return &TsConditional{n}
	case llts.TsConst:
		return &TsConst{n}
	case llts.TsDynamicImport:
		return &TsDynamicImport{n}
	case llts.TsEnum:
		return &TsEnum{n}
	case llts.TsEnumBody:
		return &TsEnumBody{n}
	case llts.TsEnumMember:
		return &TsEnumMember{n}
	case llts.TsExclToken:
		return &TsExclToken{n}
	case llts.TsExport:
		return &TsExport{n}
	case llts.TsExportAssignment:
		return &TsExportAssignment{n}
	case llts.TsImplementsClause:
		return &TsImplementsClause{n}
	case llts.TsImportAliasDecl:
		return &TsImportAliasDecl{n}
	case llts.TsImportRequireDecl:
		return &TsImportRequireDecl{n}
	case llts.TsIndexMemberDecl:
		return &TsIndexMemberDecl{n}
	case llts.TsInterface:
		return &TsInterface{n}
	case llts.TsInterfaceExtends:
		return &TsInterfaceExtends{n}
	case llts.TsNamespace:
		return &TsNamespace{n}
	case llts.TsNamespaceBody:
		return &TsNamespaceBody{n}
	case llts.TsNamespaceExportDecl:
		return &TsNamespaceExportDecl{n}
	case llts.TsNonNull:
		return &TsNonNull{n}
	case llts.TsThisParameter:
		return &TsThisParameter{n}
	case llts.TsTypeOnly:
		return &TsTypeOnly{n}
	case llts.TupleType:
		return &TupleType{n}
	case llts.TypeAliasDecl:
		return &TypeAliasDecl{n}
	case llts.TypeAnnotation:
		return &TypeAnnotation{n}
	case llts.TypeArguments:
		return &TypeArguments{n}
	case llts.TypeConstraint:
		return &TypeConstraint{n}
	case llts.TypeName:
		return &TypeName{n}
	case llts.TypeParameter:
		return &TypeParameter{n}
	case llts.TypeParameters:
		return &TypeParameters{n}
	case llts.TypePredicate:
		return &TypePredicate{n}
	case llts.TypeQuery:
		return &TypeQuery{n}
	case llts.TypeReference:
		return &TypeReference{n}
	case llts.TypeVar:
		return &TypeVar{n}
	case llts.UnaryExpr:
		return &UnaryExpr{n}
	case llts.UnionType:
		return &UnionType{n}
	case llts.UniqueType:
		return &UniqueType{n}
	case llts.Var:
		return &Var{n}
	case llts.VarDecl:
		return &VarDecl{n}
	case llts.VarStmt:
		return &VarStmt{n}
	case llts.WhileStmt:
		return &WhileStmt{n}
	case llts.WithStmt:
		return &WithStmt{n}
	case llts.Yield:
		return &Yield{n}
	case llts.MultiLineComment, llts.SingleLineComment, llts.InvalidToken:
		return &Token{n}
	case llts.NoType:
	  return nilInstance
	}
	panic(fmt.Errorf("ast: unknown node type %v", n.Type()))
	return nil
}
