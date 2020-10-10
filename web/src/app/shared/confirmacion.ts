import { FormGroup, ValidationErrors, ValidatorFn } from '@angular/forms';


export const confirmContra: ValidatorFn = (
  control: FormGroup
): ValidationErrors | null => {
  const password = control.get('password')
  const passEqual = control.get('passEqual')

  return password.value === passEqual.value
    ? null
    : { Nocoinciden: true };
};
