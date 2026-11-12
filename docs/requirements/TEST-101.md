# 🎫 TEST-101: Promo Code Checkout

**Project:** Sandbox Shop  
**Issue Type:** Story  
**Priority:** High  
**Assignee:** QA Team  
**Status:** In Progress  

---

## 📝 Description
Implement a promo code system that allows users to apply discounts to their cart total during checkout.

## 🎯 Acceptance Criteria
1. **Navigation:** Add "Promo Code" input and "Apply" button below the cart summary.
2. **Logic:**
   - `SAVE10`: Reduces total by 10%.
   - `FLAT20`: Reduces total by 20.00 € (Minimum spend: 50.00 €).
3. **Feedback:** Show success message in green, error message in red.
4. **Validation:**
   - `EXPIRED`: Show "Code has expired" error.
   - Empty input: Show "Please enter a code" error.
5. **Security:** Ensure discount logic is not bypassable via the UI only (Backend required for prod, Mock for now).

## ⚠️ QA Notes
- Check behavior if user enters symbols or SQL-like injection in the input.
- Verify the total updates correctly (currency formatting).
- Test the "Minimum spend" constraint for `FLAT20`.
