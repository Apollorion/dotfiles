# CLAUDE DEVELOPMENT GUIDELINES

## Core Philosophy

**TEST-DRIVEN DEVELOPMENT IS NON-NEGOTIABLE**

Every line of production code must be written in response to a failing test. This ensures quality, maintainability, and clear interfaces.

## Language-Specific Guidelines

### TypeScript
- **Strict mode always**: `"strict": true` in tsconfig.json
- **No `any` types**: Use proper typing or `unknown` in places where type is uncertain
- **No type assertions**: Prefer type guards and proper inference
- **Immutable data**: Use readonly arrays/objects, prefer immutable updates
- **Functional light**: Small, pure functions with clear single responsibilities
- **Testing**: Jest/Vitest + Testing Library for React/Vue components
- **Schema-first**: Define types/interfaces before implementation

### Python
- **Type hints mandatory**: Use mypy for static type checking
- **pytest for testing**: Fixtures, parametrize, and clear test organization
- **Dataclasses/Pydantic**: For structured data and validation
- **Virtual environments**: Always use venv/poetry for dependency isolation
- **Code formatting**: Black + isort + flake8/ruff
- **Async when needed**: Use asyncio for I/O bound operations
- **Schema validation**: Pydantic models for API contracts

### Go
- **Standard library first**: Minimize external dependencies
- **Table-driven tests**: Use subtests for comprehensive coverage
- **Error handling**: Explicit error returns, wrap with context
- **Interfaces**: Small, focused interfaces (prefer composition)
- **Context propagation**: Pass context.Context through call chains
- **go fmt/goimports**: Standard formatting
- **go mod**: Proper module management

### Terraform/OpenTofu
- **State management**: Remote state with locking (S3 + DynamoDB)
- **Module structure**: Reusable modules with clear interfaces
- **Variable validation**: Use validation blocks for input constraints
- **Output values**: Expose necessary values for module composition
- **Plan before apply**: Always review terraform plan
- **Formatting**: terraform fmt for consistent style
- **Documentation**: README.md for each module with examples

## Cloud & Infrastructure

### AWS
- **IAM least privilege**: Minimal required permissions
- **Resource tagging**: Consistent tagging strategy for cost allocation
- **CloudFormation/CDK**: Infrastructure as code when not using Terraform
- **Well-Architected**: Follow the 5 pillars (Security, Reliability, Performance, Cost, Operational Excellence)
- **Monitoring**: CloudWatch metrics, alarms, and structured logging

### General Cloud Principles
- **12-Factor App**: Stateless, configuration via environment
- **Container-ready**: Docker for consistent environments
- **Health checks**: Proper liveness/readiness probes
- **Secrets management**: Never hardcode, use proper secret stores
- **Observability**: Metrics, logs, traces (OpenTelemetry preferred)

## Testing Philosophy

### Test Structure
```
describe('Component/Function Name', () => {
  it('should [specific behavior] when [specific condition]', () => {
    // Arrange
    // Act  
    // Assert
  })
})
```

### Testing Priorities
1. **Behavior over implementation**: Test what, not how
2. **Integration over unit**: Favor tests that exercise real workflows
3. **Real data**: Use actual schemas/types in tests, not mocks when possible
4. **Fast feedback**: Tests should run quickly and fail clearly

## Code Organization

### Project Structure
```
src/
├── components/     # Reusable UI components (TypeScript/React)
├── services/       # Business logic and API calls
├── types/          # Type definitions and schemas
├── utils/          # Pure utility functions
├── __tests__/      # Test files (co-located preferred)
infrastructure/
├── modules/        # Terraform modules
├── environments/   # Environment-specific configs
scripts/           # Automation and deployment scripts
```

### Function Design
- **Single responsibility**: One clear purpose per function
- **Pure when possible**: No side effects, predictable outputs
- **Composition over inheritance**: Build complexity through function composition
- **Early returns**: Reduce nesting with guard clauses

## Development Workflow

1. **Write failing test**: Define expected behavior
2. **Minimal implementation**: Make test pass with simplest code
3. **Refactor**: Improve design while keeping tests green
4. **Type safety**: Ensure full type coverage
5. **Integration test**: Verify end-to-end behavior
6. **Documentation**: Update relevant docs/comments

## Preferred Libraries & Tools

### TypeScript/JavaScript
- **Testing**: Jest, Vitest, Testing Library
- **Validation**: Zod, Yup for runtime validation
- **HTTP**: Axios, fetch with proper error handling
- **State**: Zustand, Redux Toolkit (avoid complex state libs)

### Python
- **Testing**: pytest, pytest-mock, factory-boy
- **Validation**: Pydantic, marshmallow
- **HTTP**: httpx, requests
- **CLI**: Click, typer

### Go
- **Testing**: testify for assertions
- **HTTP**: net/http, gin/echo for web frameworks
- **CLI**: cobra for command-line tools
- **Database**: database/sql with sqlx for enhanced features

## Performance & Optimization

- **Measure first**: Profile before optimizing
- **Cache strategically**: Redis/Memcached for appropriate data
- **Database optimization**: Proper indexing, query optimization
- **CDN usage**: Static assets served from edge locations
- **Lazy loading**: Load resources when needed

## Security Guidelines

- **Authentication**: OAuth2/OIDC, JWT with proper validation
- **Authorization**: Role-based access control (RBAC)
- **Input validation**: Sanitize and validate all inputs
- **HTTPS everywhere**: TLS 1.2+ for all communications
- **Dependency scanning**: Regular security audits of dependencies
- **Secrets rotation**: Automated rotation of credentials

## Error Handling

- **Explicit errors**: Don't hide failures
- **Context preservation**: Include relevant details for debugging  
- **Graceful degradation**: Fail safely when possible
- **Monitoring**: Log errors with structured data
- **User-friendly messages**: Don't expose internal details

Remember: **Write tests first, keep functions small, prefer composition, and always prioritize type safety and maintainability.**