---
sidebar-position: 2
---

# API Reference

## Constructors

### new

Constructs a new log instance.

**Parameters**  
``filePath`` An optional string which is a path to log to.  
``prettyOutput`` A boolean which determines whether or not to make the console output pretty.

```luau
new: (filePath: string?, prettyOutput: boolean) -> Log
```

## Methods

### info

Logs an info message. If ``prettyOutput`` is enabled, it will show as bold and blue.

**Parameters**  
``self``  
``message`` The string to log.

```luau
info: (self: Log, message: string)
```

### warn

Logs a warning message. If ``prettyOutput`` is enabled, it will show as bold and yellow.

**Parameters**  
``self``  
``message`` The string to log.

```luau
warn: (self: Log, message: string)
```

### error

Logs an error message. If ``prettyOutput`` is enabled, it will show as bold and red.

**Parameters**  
``self``  
``message`` The string to log.

```luau
error: (self: Log, message: string)
```

### debug

Logs a debug message. If ``prettyOutput`` is enabled, it will show as bold and white.

**Parameters**  
``self``  
``message`` The string to log.

```luau
debug: (self: Log, message: string)
```

## Properties

### prettyOutput

Whether or not to make the output pretty.

```luau
prettyOutput: boolean
```

### filePath

An optional path to log to.

```luau
filePath: string?
```
