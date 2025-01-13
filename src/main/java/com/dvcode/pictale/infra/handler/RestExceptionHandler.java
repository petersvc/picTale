// package com.dvcode.pictale.infra.handler;

// import org.springframework.web.bind.annotation.ControllerAdvice;
// import org.springframework.web.bind.annotation.ExceptionHandler;
// import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

// @ControllerAdvice
// public class RestExceptionHandler extends ResponseEntityExceptionHandler {
//     // Exception handling methods
//     @ExceptionHandler(VeiculoNaoEncontradoException.class)
//     public ResponseEntity<String> veiculoNotFoundHandler(VeiculoNaoEncontradoException exception) {
//         return ResponseEntity.status(HttpStatus.NOT_FOUND).body(exception.getMessage());
//     }
// }
