document.addEventListener('DOMContentLoaded', () => {
    const toastElements = document.querySelectorAll('.toast');
    toastElements.forEach(toastEl => {
        const toast = new bootstrap.Toast(toastEl);
        toast.show(); // Exibe o toast automaticamente
    });
});
