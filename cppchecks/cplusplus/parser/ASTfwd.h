/***************************************************************************
**
** This file is part of Qt Creator
**
** Copyright (c) 2008-2009 Nokia Corporation and/or its subsidiary(-ies).
**
** Contact:  Qt Software Information (qt-info@nokia.com)
**
**
** Non-Open Source Usage
**
** Licensees may use this file in accordance with the Qt Beta Version
** License Agreement, Agreement version 2.2 provided with the Software or,
** alternatively, in accordance with the terms contained in a written
** agreement between you and Nokia.
**
** GNU General Public License Usage
**
** Alternatively, this file may be used under the terms of the GNU General
** Public License versions 2.0 or 3.0 as published by the Free Software
** Foundation and appearing in the file LICENSE.GPL included in the packaging
** of this file.  Please review the following information to ensure GNU
** General Public Licensing requirements will be met:
**
** http://www.fsf.org/licensing/licenses/info/GPLv2.html and
** http://www.gnu.org/copyleft/gpl.html.
**
** In addition, as a special exception, Nokia gives you certain additional
** rights. These rights are described in the Nokia Qt GPL Exception
** version 1.3, included in the file GPL_EXCEPTION.txt in this package.
**
***************************************************************************/
// Copyright (c) 2008 Roberto Raggi <roberto.raggi@gmail.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#ifndef CPLUSPLUS_ASTFWD_H
#define CPLUSPLUS_ASTFWD_H

#include <CPlusPlusForwardDeclarations.h>

CPLUSPLUS_BEGIN_HEADER
CPLUSPLUS_BEGIN_NAMESPACE

class AST;
class ASTVisitor;

class AccessDeclarationAST;
class ArrayAccessAST;
class ArrayDeclaratorAST;
class ArrayInitializerAST;
class AsmDefinitionAST;
class AttributeAST;
class AttributeSpecifierAST;
class BaseSpecifierAST;
class BinaryExpressionAST;
class BoolLiteralAST;
class BreakStatementAST;
class CallAST;
class CaseStatementAST;
class CastExpressionAST;
class CatchClauseAST;
class ClassSpecifierAST;
class CompoundLiteralAST;
class CompoundStatementAST;
class ConditionAST;
class ConditionalExpressionAST;
class ContinueStatementAST;
class ConversionFunctionIdAST;
class CoreDeclaratorAST;
class CppCastExpressionAST;
class CtorInitializerAST;
class DeclarationAST;
class DeclarationStatementAST;
class DeclaratorAST;
class DeclaratorIdAST;
class DeclaratorListAST;
class DeleteExpressionAST;
class DestructorNameAST;
class DoStatementAST;
class ElaboratedTypeSpecifierAST;
class EmptyDeclarationAST;
class EnumSpecifierAST;
class EnumeratorAST;
class ExceptionDeclarationAST;
class ExceptionSpecificationAST;
class ExpressionAST;
class ExpressionListAST;
class ExpressionOrDeclarationStatementAST;
class ExpressionStatementAST;
class ForStatementAST;
class FunctionDeclaratorAST;
class FunctionDefinitionAST;
class GotoStatementAST;
class IfStatementAST;
class LabeledStatementAST;
class LinkageBodyAST;
class LinkageSpecificationAST;
class MemInitializerAST;
class MemberAccessAST;
class NameAST;
class NamedTypeSpecifierAST;
class NamespaceAST;
class NamespaceAliasDefinitionAST;
class NestedDeclaratorAST;
class NestedExpressionAST;
class NestedNameSpecifierAST;
class NewArrayDeclaratorAST;
class NewExpressionAST;
class NewPlacementAST;
class NewInitializerAST;
class NewTypeIdAST;
class NumericLiteralAST;
class OperatorAST;
class OperatorFunctionIdAST;
class ParameterDeclarationAST;
class ParameterDeclarationClauseAST;
class PointerAST;
class PointerToMemberAST;
class PostIncrDecrAST;
class PostfixAST;
class PostfixDeclaratorAST;
class PostfixExpressionAST;
class PtrOperatorAST;
class QualifiedNameAST;
class ReferenceAST;
class ReturnStatementAST;
class SimpleDeclarationAST;
class SimpleNameAST;
class SimpleSpecifierAST;
class SizeofExpressionAST;
class SpecifierAST;
class StatementAST;
class StringLiteralAST;
class SwitchStatementAST;
class TemplateArgumentListAST;
class TemplateDeclarationAST;
class TemplateIdAST;
class TemplateTypeParameterAST;
class ThisExpressionAST;
class ThrowExpressionAST;
class TranslationUnitAST;
class TryBlockStatementAST;
class TypeConstructorCallAST;
class TypeIdAST;
class TypeidExpressionAST;
class TypenameCallExpressionAST;
class TypenameTypeParameterAST;
class TypeofSpecifierAST;
class UnaryExpressionAST;
class UsingAST;
class UsingDirectiveAST;
class WhileStatementAST;
class QtMethodAST;

// ObjC++
class IdentifierListAST;
class ObjCClassDeclarationAST;

CPLUSPLUS_END_NAMESPACE
CPLUSPLUS_END_HEADER

#endif // CPLUSPLUS_ASTFWD_H