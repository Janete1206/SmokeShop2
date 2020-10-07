import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { Password_recoveryComponent } from './password_recovery.component';

describe('Password_recoveryComponent', () => {
  let component: Password_recoveryComponent;
  let fixture: ComponentFixture<Password_recoveryComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ Password_recoveryComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(Password_recoveryComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
